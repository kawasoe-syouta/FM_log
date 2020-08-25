$(function() {
  const buildFileField = (index)=> {
    const html = `<div data-index="${index}" class="group">
                    <input class="file" type="file"
                    name="product[images_attributes][${index}][src]"
                    id="product_images_attributes_${index}_src"><br>
                    <div class="remove">削除</div>
                  </div>`;
    return html;
  }

  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  $('.hidden').hide();
  $('#image-box').on('click', '.remove', function() {
    // フォームに割り振られた固有のインデックスを取得。
    const targetIndex = $(this).parent().data('index')
    // 取得したインデックスに対応するチェックボックスを取得。
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden`);
    // チェックボックスが存在する場合チェックを入れる。
    if (hiddenCheck) hiddenCheck.prop('checked', true);
  });
    
  let fileIndex = [1,2,3,4,5]
  lastIndex = $('.group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('#image-box').on('change', '.file', function(e) {
    $('#image-box').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('#image-box').on('click', '.remove', function() {
    $(this).parent().remove();
    if ($('.file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
    $(`img[data-index="${targetIndex}"]`).remove();
  });

  $('#image-box').on('change', '.file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
    }
  });

});