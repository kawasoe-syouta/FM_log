$(function(){

  // 数値のみの入力制限
  $(".CardPage__format--text,.CardPage__format--texthalf").on('input', function(){
    let input = $(this).val().replace(/[^0-9]/g,"");
    $(this).val(input);
  })

  // カード情報の登録
  $("#card_submit").on('click',function(e){
    e.preventDefault();
    // カード情報の取得
    let card = {
      number: $("#card_number").val(),
      cvc: $("#card_cvc").val(),
      exp_month: $("#card_month").val(),
      exp_year: "20" + $("#card_year").val()
    };

    Payjp.createToken(card, function(http, response) {
      if (http === 200) {
        $(".CardPage__format").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        );
        $(".CardPage__format").submit();
      } else {
        alert("カード情報が正しくありません")
      }
    })
  })
})