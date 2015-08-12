<message>
  <li each={dummyData}>
    <small class="time">{parent.getTime(t)}</small>
    <span class="name">{n}</span>
    <span class="msg">{m}</span>
  </li>
  
  <script>
    //Timestamps are 13 digit numbers (not strings!)
    //{n:'name', m:'message', t:timestamp}
    this.dummyData = [
      {n:'Emma', m:'Message 1', t:1234567891234},
      {n:'Mina', m:'Message 2', t:3456789123456},
      {n:'Rafe', m:'Message 3', t:5678912345678},
      {n:'Jack', m:'Message 4', t:7891234567891},
      {n:'Dave', m:'Message 5', t:9123456789123},
    ];
    
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