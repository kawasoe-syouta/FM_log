$(function(){
  // 数値とハイフンの入力制限
  $("#street_postalcode").on('input', function(){
    let input = $(this).val().replace(/[^-0-9]/g,"");
    let numinput = $(this).val().replace(/[^0-9]/g,"");
    if (numinput.length > 7) {
      input = numinput.substr(0,7)
    }
    $(this).val(input);
  })

  // 数値入力制限
  $("#street_phonenumber").on('input', function(){
    let input = $(this).val().replace(/[^0-9]/g,"");
    $(this).val(input);
  })

  // 住所情報の登録
  $("#street_submit").on('click',function(e){
    let postalcode = $("#street_postalcode").val().replace(/[^0-9]/g,"")
    $("#street_postalcode").val(postalcode);
    $("#street_submit").submit();
  })
})