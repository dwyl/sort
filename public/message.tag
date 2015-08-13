<message>
  <raw content={ serverMessages } />
  <li each={messageStore}>
    <small class="time">{parent.getTime(t)}</small>
    <span class="name">{n}</span>
    <span class="msg">{prefix + m}</span>
  </li>

  <script>

    this.messageStore = opts.messageStore;
    this.prefix = opts.prefix || '';
    this.serverMessages = opts.serverMessages || ''

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

    // we want to check whether this is a REAL HTML document
    // (constructor = HTMLDocument)
    // or a 'simpleDom' document (constructor = simpleDom.Document)

    if (document.constructor.toString().indexOf('HTML') > -1) {

      opts.socket.on('chat:messages:latest', function(msg) {
        this.renderMessage(msg);
        this.scrollToBottom();
      }.bind(this));

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

<raw>
  this.root.innerHTML = opts.content
</raw>
