$(function(){

  // 画像用のinputを生成する関数
  function buildFileField(index, url){
    const html = `<div class="SellPage__uploadfile" data-index="${index}"
                    id="item_images_attributes_${index}">
                    <img data-index="${index}" src="${url}" class="SellPage__uploadfile--file">
                    </img>
                    <div class="SellPage__uploadfile--remove">
                      削除
                    </div>
                  </div
                  `;
    return html;
  }

  // 空き番号のシフト
  function ImageShift(index) {
    for (let i = 0; i < fileIndex; i++) {
      if (i > index) {
        // プレビュー表示オブジェクトの参照
        img = $(`.SellPage__uploadfile[data-index="${i}"]`)[0]
        $(img).attr('data-index', i-1)
        $(img).attr('id', `item_images_attributes_${i-1}`)
        // アップロードフォームの参照
        $(img).children('.SellPage__uploadfile--input').attr('name', `item[item_images_attributes][${i-1}][image]`)
        $(img).children('.SellPage__uploadfile--input').attr('id', `item_images_attributes_${i-1}_image`)
        // 画像の参照
        $(img).children('img').attr('data-index', i-1)
      }
    }
  }

  // 追加する時に割り振る画像番地
  let fileIndex = 0;

  // 画像表示
  $(".SellPage__contents__imgbtm--file").on("change",function(e){
    const targetIndex = $(".SellPage__contents__imgbtm").attr('data-index');
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    // 該当indexを持つimgタグがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
      $(".SellPage__contents__imagefield").append(buildFileField(targetIndex, blobUrl));
      $(".SellPage__contents__imgbtm--file").clone(true).appendTo(`.SellPage__uploadfile[data-index="${fileIndex}"]`);
      $(`.SellPage__uploadfile[data-index="${fileIndex}"]`).children(".SellPage__contents__imgbtm--file").attr('class', "SellPage__uploadfile--input")
      $(`.SellPage__uploadfile[data-index="${fileIndex}"]`).children(".SellPage__uploadfile--input").attr('name', `item[item_images_attributes][${fileIndex}][image]`)
      // indexに1追加する
      fileIndex += 1
      // 入力ラベルの宛先を変更
      $(".SellPage__contents__imgbtm").attr('data-index',fileIndex)
      $(".SellPage__contents__imgbtm").attr('for',`item_item_images_attributes_${fileIndex}_image`)
      // ファイル出力フォームを変更
      $(".SellPage__contents__imgbtm--file").attr('data-index',fileIndex)
      $(".SellPage__contents__imgbtm--file").attr('id',`item_item_images_attributes_${fileIndex}_image`)
      $(".SellPage__contents__imgbtm--file").attr('name', ``)
    }
  })

  // 画像の削除
  $(".SellPage__contents__imagefield").on('click',".SellPage__uploadfile--remove",function() {
    console.log(this);
    // 削除する画像の番号を取得
    index = $(this).parent().attr('data-index')
    // 画像を削除
    $(this).parent().remove();
    // 空いた番号をシフトする
    ImageShift(index);
    // indexを1減らす
    fileIndex -= 1;
    // 入力ラベルの宛先を変更
    $(".SellPage__contents__imgbtm").attr('data-index',fileIndex)
    $(".SellPage__contents__imgbtm").attr('for',`item_item_images_attributes_${fileIndex}_image`)
    // ファイル出力フォームのidを変更
    $(".SellPage__contents__imgbtm--file").attr('data-index',fileIndex)
    $(".SellPage__contents__imgbtm--file").attr('id',`item_item_images_attributes_${fileIndex}_image`)
  });

  // 数字のみの入力制限
  $(".SellPage__format--numfield").on("input", function(){
    let input = $(this).val().replace(/e/g,"");
    let int_input = (parseInt(input, 10))
    if (isNaN(int_input)) {
      int_input = 0
    }
    $(this).val(int_input)
  })
})

{/* <input class="SellPage__uploadfile--input" type="file"
name="item[item_images_attributes][${index}][image]"
id="item_item_images_attributes_${index}_image"> */}