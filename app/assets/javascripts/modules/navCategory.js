$(function(){
  
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
  
});