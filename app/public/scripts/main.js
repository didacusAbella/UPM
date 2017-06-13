(function () {
  $(document).ready(function () {
    $('#form2 input[type=file]').each(function (key, value) {
      $(value).on('change', function () {
        if (typeof (FileReader) != "undefined") {
          var img_holder = $(value).next();
          img_holder.empty();
          var reader = new FileReader();
          reader.onload = function (e) {
            $("<img />", {
              "src": e.target.result
            }).appendTo(img_holder);

          }
          img_holder.show();
          reader.readAsDataURL($(this)[0].files[0]);
        }
      });
    });
  });
})();