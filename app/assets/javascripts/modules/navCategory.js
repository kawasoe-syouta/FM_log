$(function(){
<<<<<<< HEAD

  // $('.category__parent').hover(
  //   function(){
  //     $(this).find('li').find('.category__parent--name').css({
  //       backgroundColor : '#3CCAEC',
  //       color : '#fff'
  //   });
  //   },
  //   function(){
  //     $(this).find('li').find('.category__parent--name').css({
  //       backgroundColor : '#fff',
  //       color : 'black'
  //   });
  //   }
  // )
  // $('.category__child').hover(
  //   function(){
  //     $(this).find('li').find('a').css('backgroundColor','#eee');
  //   },
  //   function(){
  //     $(this).find('li').find('a').css('backgroundColor','#fff');
  //   }
  // )
  
  $(function(){
    // #で始まるリンクをクリックしたらイベント発火
    $('a[href^="#"]').click(function() {
      // スクロールの速度
      var speed = 400; 
      // ここでいう$(this)とはクリックされたリンク要素のこと。
      var href= $(this).attr("href");
      // 三項目演算子を条件分岐をしています。
      var target = $(href == "#" || href == "" ? 'html' : href);
      // ofset().topを用いて数値として要素の左上の座標を代入。
      var position = target.offset().top;
      // animate関数でアニメーションを指定します。
      $('body,html').animate({scrollTop:position}, speed, 'swing');
      return false;
    });
  });
  
=======
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
>>>>>>> 7e158ff... categoryの見た目
});