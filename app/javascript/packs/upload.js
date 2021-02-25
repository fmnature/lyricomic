$(function(){
  if(document.URL.match(/\/lyrics\/new/)) {


    $(document).on('change', 'input[type= "file"]',function(e) {
      e.preventDefault();
      var formData = new FormData();
      formData.append("image",$('input[type=file]')[0].files[0]);


      $.ajax({
        type:'POST',
        url: '/foods/upload',
        data: formData,
        dataType:'json',
        processData: false,
        contentType: false
      })


    })


  }
})