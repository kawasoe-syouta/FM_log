$(function(){
  function build_childSelect(){
    let child_select = `
    <select name="post[category_id]" class="child_category_id">
      <option value="">---</option>
    </select>
    `
    return child_select;
  }

  function build_Option(children) {
    let option_html = `
                      <option value=${children.id}>${children.name}</option>
                      `
    return option_html;
  }
  $("#category_form").change(function(){
    let parentValue = $("#category_form").val();
    if (parentValue.length != 0) {
      $.ajax({
        url: '/sells/search',
        type: 'GET',
        data: {parent_id: parentValue},
        dataType: 'json'
      })
        .done(function(data){
          let child_select = build_childSelect
          $("#category_field").append(child_select);
          data.forEach(function (d) {
            let option_html = build_Option(d)
            $(".child_category_id").append(option_html);
          })
        })
        .fail(function(){
          alert("通信エラーです！");
        });
    }
  });


  function build_gcSelect(){
    let gc_select = `
    <select name="post[category_id]" class="gc_category_id">
              </select>
    `
    return gc_select;
  }

  function build_Option(children) {
    let option_html = `
                      <option value=${children.id}>${children.name}</option>
                      `
    return option_html;
  }
  $(document).on("change", ".child_category_id", function(){
    let childValue = $(".child_category_id").val();
    if (childValue.length != 0) {
      $.ajax({
        url: '/sells/search',
        type: 'GET',
        data: {children_id: childValue},
        dataType: 'json'
      })
        .done(function(gc_data){
          let gc_select = build_gcSelect
          $("#category_field").append(gc_select);
          gc_data.forEach(function (gc_d) {
            let option_html = build_Option(gc_d)
            $(".gc_category_id").append(option_html);
          })
        })
        .fail(function(){
          alert("gcで通信エラーです！");
        });
    }
  });
});

