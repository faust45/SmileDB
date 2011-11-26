$(function() {
  var url = $('#dataForm').attr('action'),
      inputMsg = $('#dataForm input[name=msg]');

  $('#dataForm').bind('submit', function() {
    $.post(url, {msg: inputMsg.val()}, successFun)
    return false;
  });

  function successFun(e, data) {
    console.log('Resp come');
  }

  setInterval(function() {
    $.get('/feed', updateChat)
  }, 1000);

  function updateChat(e, data) {
    var arr = eval(e);
    for(var i in arr) {
        var el = arr[i];
        $('#chatPage').append($('<div>'+el.from+': &nbsp;&nbsp;'+el.msg+'</div>'));
    }
    console.log('in log update', e, data);
  }
});
