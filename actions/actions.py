
from cmath import e
from dis import dis
from email import message
from html.entities import entitydefs
import re
import json
from typing import Text, List, Any, Dict
from matplotlib.pyplot import get, text
import mysql.connector
from rasa_sdk import Tracker, FormValidationAction, Action
from rasa_sdk.events import EventType
from rasa_sdk.events import SlotSet
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.types import DomainDict
from regex import S
from sqlalchemy import null

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="webbot"
)

def query_func(query, return_type=''):
    if return_type == '':
        list = {}
        cursor = mydb.cursor()
        cursor.execute(query)
        colums = [col[0] for col in cursor.description]
        for row in cursor.fetchall():
            list[row[0]] = dict(zip(colums, row))
        json_ouput = json.dumps(list)
        return list
    else:
        list = []
        cursor = mydb.cursor()
        cursor.execute(query)
        colums = [col[0] for col in cursor.description]
        for row in cursor.fetchall():
            list.append(dict(zip(colums, row)))
        return list

ARRAY_SELECT_PHAN_LOAI = {}

class GoiYSanPham(Action):
    def name(self) -> Text:
        return "goi_y_sp"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        query = 'SELECT sFK_Ma_SP, sanpham.sTen_SP, sFK_Ma_DD, sMota FROM `sanpham_dacdiem` JOIN sanpham ON sFK_Ma_SP = sanpham.sPK_Ma_SP'
        tensp = 0
        count_entity = 0
        count_record = 0
        for blob in tracker.latest_message['entities']:
            count_entity += 1
            if blob['entity'] == 'type_product' and tensp == 0:
                query += f" WHERE sTen_SP like '%{blob['value']}%' "
                tensp +=1
            elif blob['entity'] != 'phan_loai':
                if tensp == 0:
                    query += f" WHERE sFK_Ma_DD = '{blob['entity']}' AND sMota like '%{blob['value']}%'"
                else:
                    query += f" AND sFK_Ma_DD = '{blob['entity']}' AND sMota like '%{blob['value']}%'"
        
        if count_entity == 0:
            dispatcher.utter_message(text="Cung cấp cho mình tên sản phẩm hoặc mô tả bạn quan tâm nhé")
            return[]
        
        if count_entity != 0:
            list_goiy = {"goi_y_sp":query_func(query)}
            m = json.dumps(list_goiy)
            dispatcher.utter_message(json_message=list_goiy)
            print(list_goiy)
        return []

class SetSanPham(Action):
    def name(self) -> Text:
        return "set_product"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        ma_sp = tracker.get_slot('ma_sp')
        ARRAY_SELECT_PHAN_LOAI = {}
        return [SlotSet("type_phan_loai","color")]

class SetMaSPPhanLoai(Action):
    def name(self) -> Text:
        return "set_sp_phan_loai"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        for blob in tracker.latest_message['entities']:
            if blob['entity'] == 'phan_loai':
                return [SlotSet("sp_phan_loai","BUT1_PL1")]
        return[]

class AskSlotPhanLoai(Action):
    def name(self) -> Text:
        return "action_ask_phan_loai"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        ma_sp = tracker.get_slot('ma_sp')
        query = f"SELECT * FROM `phanloai_sanpham` WHERE `sFK_Ma_SP` = '{ma_sp}'"
        result = query_func(query, 'list')
        ARRAY_SELECT_PHAN_LOAI = result
        button = []
        for a in ARRAY_SELECT_PHAN_LOAI:
            ma_lsp = '"sp_phan_loai":'+'"'+a['sPK_Ma_PLSP']+'"'
            ten_pl = '"phan_loai":'+'"'+a['sTenPL']+'"'
            s = "/inform_mua_hang{"+ma_lsp+","+ten_pl+"}"
            button.append({"payload":s, "title":a['sTenPL']})
        print(button)
        dispatcher.utter_message(text="Bạn chọn phân loại sản phẩm nhé", buttons = button)
        return[]
        
class ValidateMuaHangForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_mua_hang_form"

    def validate_ma_sp(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict,
    ) -> Dict[Text, Any]:
        """Validate `ma_sp` value."""
        query = f"SELECT sTen_SP FROM `sanpham` WHERE `sPK_Ma_SP` = '{slot_value}' "
        result = query_func(query, "list")
        return {"ten_sp":result[0]["sTen_SP"]}

    def validate_phan_loai(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict,
    ) -> Dict[Text, Any]:
        """Validate `phan_loai` value."""
        print(ARRAY_SELECT_PHAN_LOAI)
        if slot_value is None or slot_value is null:
            print(1)
            dispatcher.utter_message(text=f"Validate phan_loai ne")
            return {"phan_loai": None}
        print(2)
        dispatcher.utter_message(text=f"OK! Phân loại hàng là {slot_value}")
        return {"phan_loai": slot_value}
        
    def validate_so_luong(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict,
    ) -> Dict[Text, Any]:
        """Validate `so_luong` value."""
        print(slot_value)
        if int(slot_value) <= 0:
            dispatcher.utter_message(text=f"Số lượng không hợp lệ")
            return {"so_luong": None}
        dispatcher.utter_message(text=f"OK! Số lượng là {slot_value}.")
        return {"so_luong": slot_value}
class ValidateGioHangForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_them_gio_hang_form"

    def validate_affirm(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict,
    ) -> Dict[Text, Any]:
        """Validate `phan_loai` value."""
        last_intent = tracker.get_last_intent()
        intent_arr = ['dong_y', 'tu_choi']
        if last_intent not in intent_arr:
            return {"affrim": None}
        else:
            if last_intent == 'dong_y':
                dispatcher.utter_message(text="Đã thêm vào giỏ hàng")
                return {"affrim": slot_value}
            else:
                dispatcher.utter_message(text="Xoá thông tin phân loại và số lương")
                return {"affrim": slot_value}


class CheckSoLuong(Action):
    def name(self) -> Text:
        return "check_so_luong"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        ma_sp = "BUT1"
        if ma_sp:
            query = f"SELECT * FROM `phanloai_sanpham` WHERE `sFK_Ma_SP` = '{ma_sp}' "
            entity_num = 0
            for blob in tracker.latest_message['entities']:
                if blob['entity'] == 'phan_loai':
                    entity_num += 1
                    query += f" AND `sTenPL` LIKE '%{blob['value']}%' "
            result = query_func(query, "list")

            if entity_num != 0: #Nếu khách hàng hỏi cụ thể 1 phân loại nào
                message_return = ""
                if result[0]['iSoLuong'] == 0:
                    message_return += f"Phân loại hàng {result[0]['sTenPL']} đang tạm thời hết hàng. "
                    result1 = query_func(f"SELECT * FROM `phanloai_sanpham` WHERE `sFK_Ma_SP` = '{ma_sp}' AND `iSoLuong` != 0", "list")
                    if result1:
                        message_return += "Phân loại "
                        for i in result1:
                            message_return += f"{i['sTenPL']}, "
                        message_return = message_return[:-1]
                        message_return += " hiện vẫn còn hàng bạn có thể cân nhắc"
                    dispatcher.utter_message(text=message_return)
                    return[]
                else:
                    message_return += f"Phân loại hàng {result[0]['sTenPL']} vẫn còn hàng ạ. "
                    dispatcher.utter_message(text=message_return)
                    return[]
            else: # Nếu khách hàng KHÔNG hỏi cụ thể 1 phân loại
                message_return = ""
                result1 = query_func(f"SELECT * FROM `phanloai_sanpham` WHERE `sFK_Ma_SP` = '{ma_sp}' AND `iSoLuong` != 0", "list")
                if result1:
                    message_return += "Phân loại "
                    for i in result1:
                        message_return += f"{i['sTenPL']}, "
                    message_return = message_return[:-1]
                    message_return += " hiện vẫn còn hàng bạn có thể cân nhắc"
                dispatcher.utter_message(text=message_return)
                return[]
        else:
            dispatcher.utter_message(text="Bạn chưa chọn sản phẩm nào")
        return[]

class AskInfoProduct(Action):
    def name(self) -> Text:
        return "custom_info_product"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        ma_sp = tracker.get_slot('ma_sp')
        if ma_sp is not None and ma_sp is not null:
            for blob in tracker.latest_message['entities']:
                ma_dd = blob['value']
                if blob['entity'] == 'info_product':
                    query = f"SELECT sMota FROM `sanpham_dacdiem` JOIN sanpham on sFK_Ma_SP = sanpham.sPK_Ma_SP WHERE `sFK_Ma_SP` = '{ma_sp}' and `sFK_Ma_DD` = '{ma_dd}'"
            if query:
                result = query_func(query, 'list')
                print(result)
        else:
            dispatcher.utter_message(response = "missing_ma_sp")
        return[]