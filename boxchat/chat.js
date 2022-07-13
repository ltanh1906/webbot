$(document).ready(() => {
    $("#input-field").keyup(function(){
        if ($(this).val() == ""){
            $("#send-button").removeClass("active")
        }else{
            $("#send-button").addClass("active")
        }



    });

    $('#input-field').keypress(function (e) {
        if (e.which == 13) { 
            console.log($(this).val())
            if ($(this).val() != ""){
                draw_usermess($(this).val())
            }
        }
    });

    $(document).on("click",".phanloai_button",function() {
        var payload = $(this).data("payload")
        var class_button = "."+$(this).data("flag")
        var notify = '<div class="notify-mess"><p>Bạn đã chọn <b>' + $(this).html() + '</b></p></div>'
        $(".content-chat").append(notify)
        $(class_button).prop('disabled', true);
        draw_usermess(payload, 'hide')
    });

    $(document).on("click",".item-suggest",function(e) {
        if (!$(e.target).hasClass('icon-link')) {
            selectSanPham('', $(this).data('selectsp'));
        }
    });

    function selectSanPham(masp, payload){
        // ajax lấy thông tin sản phẩm qua mã
        var payload = '/select_product{"ma_sp":"'+'BUT2'+'"}'
        payload = payload.replace()
        var notify = '<div class="notify-mess"><p>Bạn đã chọn <b>' + payload + '</b></p></div>'
        $(".content-chat").append(notify)
        draw_usermess(payload, 'hide')
    }

    function send(message){
        user_id = "test1"
        console.log(message)
        $.ajax({
            url: 'http://localhost:5005/webhooks/rest/webhook',
            type: 'POST',
            contentType: "application/json",
            data: JSON.stringify({ message: message, sender: user_id }),
        }).done(function(ketqua) {
            draw_botmess(ketqua)
        });
    }

    function draw_usermess(message, hide=""){
        if(hide == ""){
            div_message = '<div class="chat outgoing"><div class="details"><p>'
            div_message += message
            div_message += '</p></div></div>'
            $('.content-chat').append(div_message)
            $('#input-field').val('')
        }
        scrollToBottom()
        send(message)
    }

    function scrollToBottom() {
        $('#chat-box').animate({ scrollTop: $('.content-chat').height() }, 'slow');
    }

    function draw_botmess(result){
        if (result.length != 0){
            var reply = []
            
            $.each( result, function( key, value ) {
                console.log(value)
                var num_rep = 0
                div_reply = '<div class="chat incoming"><img class="bot-avatar" src="img\/ava2.jpg" alt=""><div class="details"><p>'

                if (value['text'] != undefined){
                    div_reply += value['text']+'</p>'
                    num_rep++
                }
                if (value['buttons'] != undefined){
                    var flag = "btn-"+Date.now()
                    console.log(value['buttons'])
                        div_reply += '<div class="custom-button">'
                    $.each(value['buttons'], function(index, button){
                        div_reply += '<button class="active phanloai_button ' + flag + '" data-flag="'+flag+'" data-payload=\''+button['payload']+'\'>'+button['title']+'</button>'
                    });
                        div_reply += '</div>';
                    num_rep++
                }
                div_reply += '</div></div>'

                if  (num_rep > 0) {
                    reply.push(div_reply)
                }

                if (value['custom'] != undefined){
                    suggest_div = '<i style="font-size:12px">Gợi ý một số sản phẩm cho bạn:</i>'
                    $.each(value['custom']['goi_y_sp'], function(index, sp){
                        suggest_div += '<div class="item-suggest mb-1" data-selectsp="/select '+sp['sFK_Ma_SP']+'"><div class="inner-suggest">'
                        suggest_div += '<img src="img/'+ sp['sPimage'] +'" alt="">'
                        suggest_div += '<div class="details-suggest"><span>'+sp['sTen_SP']+'</span><p>'+sp['sMota']+'</p></div>'
                        suggest_div += '</div><a class="icon-link" href=""><i class="icon-link fas fa-info-circle"></i></a></div>'
                    });
                    $('.content-chat').append(suggest_div)
                    scrollToBottom()
                }
            });
            if(reply.length > 0){
                var count = 0;
                $.each( reply, function(index, value) {
                    setTimeout(function() {
                        $('.content-chat').append(value)
                        scrollToBottom()
                    }, count*1000)
                    count++
                    
                });
            }
        }
    }
})