$( document ).ready(function() {
  var socket = io(); // initialise socket.io connection

  function getName() {
    // prompt for person's name before allowing to post
    var name = Cookies.get('name');
    if(!name) {
      name = window.prompt("What is your name/handle?");
      Cookies.set('name', name);
    }
    socket.emit('io:name', name);
    $( "#m" ).focus(); // focus cursor on the message input
    return name;
  }

  function sanitise(txt) {
    if(txt.indexOf("<") > -1 || txt.indexOf(">") > -1) {
      txt = 'tries to inject : ' +  txt.replace(/</g, "&lt").replace(/>/g, "&gt");
    }
    return txt;
  }

  $('form').submit(function() {
    if(!Cookies.get('name') || Cookies.get('name').length < 1 || Cookies.get('name') === 'null') {
      getName();
      return false;
    } else {
      var msg  = $('#m').val();
      socket.emit('io:message', sanitise(msg));
      $('#m').val(''); // clear message form ready for next/new message
      return false;
    }
  });

  socket.on('chat:people:new', function(name) {
    $('#joiners').show();
    $('#joined').text(name)
    $('#joiners').fadeOut(5000);
  });

  getName();

});
