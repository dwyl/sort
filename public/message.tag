<message>
  <li each={messageStore}>
    <small class="time">{parent.getTime(t)}</small>
    <span class="name">{n}</span>
    <span class="msg">{m}</span>
  </li>
  
  <script>
    
    this.messageStore = opts.messageStore
    
    this.leadZero = function (number) {
      return (number < 10) ? '0'+number : number;
    };
    
    // The above is one way of declaring a function in Riot
    // An alternate way is:
    //   leadZero (number) {
    //     return (number < 10) ? '0'+number : number;
    //   }
    
    this.getTime = function (timestamp) {
      var t, h, m, s, time;
      t = new Date(timestamp);
      h = this.leadZero(t.getHours());
      m = this.leadZero(t.getMinutes());
      s = this.leadZero(t.getSeconds());
      return '' + h  + ':' + m + ':' + s;
    };

  </script>
</message>