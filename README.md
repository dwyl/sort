# Hapi.js Socket.io Redis Riot.js Chat Example [Work in Progress]

This example adds [Riot.js](http://muut.com/riotjs/) to our popular [Hapi.js Socket.io and Redis Publish/Subscribe chat application example](https://github.com/dwyl/hapi-socketio-redis-chat-example), as per issue [#20]( https://github.com/dwyl/hapi-socketio-redis-chat-example/issues/20).

The commits have been added in step-by-step so it should be simple to follow along. Watch this space!

+ [ ] This is step-by-step - if you don't need the step-by-step below, just clone this repo and have a play, no need to got through the commits
+ [ ] Add links to riot documentation throughout
+ [ ] Decide what functionality we're replacing with riot

```javascript
function renderMessage(msg) {
  msg = JSON.parse(msg);
  var html = "<li class='row'>";
  html += "<small class='time'>" + getTime(msg.t)  + " </small>";
  html += "<span class='name'>" + msg.n + ": </span>";
  html += "<span class='msg'>"  + msg.m + "</span>";
  html += "</li>";
  $('#messages').append(html);  // append to list
  return;
}
```

+ [ ] How to run the app (`npm i`, environment variables, `redis-server`, `npm start`)


##Add Riot to the app & get it to display simple dummy data

### 1. Adds Riot.js 'Hello World' 
+ Add the [Riot CDN](https://muut.com/riotjs/download.html) (use the version which includes the _compiler_) to your `index.html`
+ Add your custom tag to `index.html`
+ Create your `.tag` file (where your _riot_ will live) and add it to `index.html`
  + _Note: You **can** call your `.tag` file whatever you like as long as you reference it correctly in `index.html` - we recommend keeping it to the name of your component so the contents of the file are immediately obvious_
+ Inside your

[ commit hash: 13742162d8894e49684a6d27dcf1ea65f122180c]

### 2. Adds dummy array of data & iterates through it with Riot
+ Create some dummy data in the form of an array
+ Use `each` to iterate through that array and display the data

 [ commit hash: 9d8d80ab628bd71282a0eaf66ebb343d0358ca0c]
 
### 3. Changes dummy data format & HTML structure in message.tag
+ Change your dummy data array to mimick the data struture you would get from Redis
+ Alter your HTML to look like the expected final HTML structure (the HTML that is being appended in renderMessage in `client.js`)

[commit hash: 88d53cc1601b564cfb6df695b1ccff0527558f1e]

### 4. Format the timestamp correctly
+ Move getTime() and leadZero to `client.js`
+ [ ] Why are we moving them?
+ [ ] Explain why this.leadZero
_ Note: At this point, if you try to type something into the message input box, it won't show up on the page as we've now removed the functionality of `renderMessage()` but have yet to replace it with riot functionality_
+ [ ] Explain `parent.function`
[ commit hash: 0f3ab0d7acd12c8335870988171b7f778665fe86]


##Hook up Riot to the data from Redis
### 5. Change where we mount Riot
+ [ ] Explain why we're moving the mounting
+ Add 'riot' to globals in .jshintrc
+ [ ] Explain why. "If you're worried riot is undefined, don't be as it's a global"

[ commit hash: 6cd72e0e4e18beffe8574847d91a7da1677e2988]

### 6. Get data from Redis to be rendered using Riot
+ Create empty array to hold messages
+ [ ] Explain where messageStore is added to (in renderMessage)
+ [ ] Add code snippet where messageStore is passed through as `opts`
+ [ ] Changes to riot
_Note: Any messages input into the message input box at this stage and going into the database and into our `messageStore` array, but are not yet being rendered on the page by riot_

[ commit hash: b755c52189805c0a402753cefecc2ae069a21383]

### 7. Get riot to render new messages to the page
+ Add riot.update() to renderMessage
+ [ ] Why are we adding it in renderMessage?

[ commit hash: a71edd3da901ef6b01f5206578ffbb26aa810bdd]

##Bug fixes
### 8. [scrollToBottom bug](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/issues/3)
+ [ ] Review wording of issue to be extremely clear
+ [ ] Explain why bug is happening (height is 0 just after riot begins mount)
+ [ ] Why we don't just move scrollToBottom() to `message.tag` entirely
+ Pass it to `message` as part of `opts`
+ Now we can use it in `message.tag`

[ commit hash: b85121e0aa14c803d4041dd730b8189c86feab5f]


