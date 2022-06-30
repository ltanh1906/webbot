
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
        query = 'SELECT sFK_Ma_SP, sanpham.sTen_SP,sFK_Ma_DD, sMota FROM `sanpham_dacdiem` JOIN sanpham ON sFK_Ma_SP = sanpham.sPK_Ma_SP'
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
        for a in result:
            button.append({"payload":"/sp_pl " + a['sPK_Ma_PLSP'] +"/phan_loai "+a['sFK_Ma_DD'], "title":a['sFK_Ma_DD']})
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
        print(slot_value)
        return {}

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


class CheckSoLuong(Action):
    def name(self) -> Text:
        return "check_so_luong"
    def run(
        self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict
    ) -> Dict[Text, Any]:
        for blob in tracker.latest_message['entities']:
            if blob['entity'] == 'phan_loai':
                return 
        return[]