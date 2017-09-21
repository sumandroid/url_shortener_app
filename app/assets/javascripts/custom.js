/********* submit short url form script *************/
{
  $(document).on('click', '.create_short_url_button', function (e) {
    e.preventDefault();
    var self = $(this);
    var form = self.closest('form');
    var long_url_input = form.find('input[name="long_url"]').val();
    if($.trim(long_url_input) == ''){
      alert('Come on! provide a valid url');
      return false;
    }else{
      var data = form.serialize();
      var url = form.attr('action');
      $.ajax({
        url: url,
        data: data,
        type: 'post',
        dataType: 'json',
        error: function () {
          alert('There is some error, please try again later');
        },
        success: function (result) {
          if (result.status == 'error') {
            alert('there occurred some error');
            form.find('div.link_div').addClass('hidden');
            form.find('span.link_span').find('a').attr("href", '');
          }
          else if (result.status == 'failure') {
            alert(result.msg);
            form.find('div.link_div').addClass('hidden');
            form.find('span.link_span').find('a').attr("href", '');
          }
          else if (result.status == 'success') {
            form.find('div.link_div').removeClass('hidden');
            form.find('span.link_span').find('a').attr("href", '');
            form.find('span.link_span').find('a').attr("href", result.long_url);
            form.find('span.link_span').find('a').html(result.short_url);
          }
          else {
            alert('There is some error, please try again later');
          }
        }
      });
    }
  });
}