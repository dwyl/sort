<message>
  <li each={messageStore}>
    <small class="time">{parent.getTime(t)}</small>
    <span class="name">{n}</span>
    <span class="msg">{m}</span>
  </li>

  <script>

		// if opts.messageStore is undefined, the && will make it skip over the parse
		// this way we avoid errors from JSON.parse being called on undefined
		// we could also use a try / catch
    this.messageStore = opts.messageStore && JSON.parse(opts.messageStore) || [];

    this.leadZero = function (number) {
      return (number < 10) ? '0'+number : number;
    };

    this.getTime = function (timestamp) {
      var t, h, m, s, time;
      t = new Date(timestamp);
      h = this.leadZero(t.getHours());
      m = this.leadZero(t.getMinutes());
      s = this.leadZero(t.getSeconds());
      return '' + h  + ':' + m + ':' + s;
    };

    // CLIENT SIDE ONLY

    // we want to check whether we are on the SERVER or on the CLIENT
    // we can do this by checking for the presence of a render method on riot
    // (riot explodes if we check for 'window')

    var onClient = !riot.render

    if (onClient) {

      var socket = io();

      socket.on('chat:messages:latest', function(msg) {
        this.renderMessage(msg);
        this.scrollToBottom();
      }.bind(this));

      socket.on('chat:people:new', function(name) {
        $('#joiners').show();
        $('#joined').text(name)
        $('#joiners').fadeOut(5000);
      });

      this.renderMessage = function (msg) {
        msg = JSON.parse(msg);
        this.messageStore.push(msg);
        this.update();
        return;
      }

      // keeps latest message at the bottom of the screen
      // http://stackoverflow.com/a/11910887/2870306
      this.scrollToBottom = function () {
        $(window).scrollTop($('#messages').height());
      }

      window.onresize = function(){
        this.scrollToBottom();
      }.bind(this);

      this.on('mount', function(){
        this.scrollToBottom();
      })
    }

  </script>
</message>
