$(function(){

  $('#categoryBtn').hover(
    function(){
      $(this).find('.displayNone').addClass('hover-active')
    },
    function(){
      $(this).find('.displayNone').removeClass('hover-active')
    }
  )
});