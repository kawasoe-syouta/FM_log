$(function(){
  $('.categoryTree--item').hover(
    function(){
      $(this).find('h3').find('a').css({
        backgroundColor : '#3CCAEC',
        color : '#fff'
    });
    },
    function(){
      $(this).find('h3').find('a').css({
        backgroundColor : '#fff',
        color : 'black'
    });
    }
  )
  $('.categoryTree--item2').hover(
    function(){
      $(this).find('h2').find('a').css('backgroundColor','#eee');
    },
    function(){
      $(this).find('h2').find('a').css('backgroundColor','#fff');
    }
  )
});