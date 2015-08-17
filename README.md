# Hapi.js Socket.io Redis Riot.js Chat Example [Work in Progress]

This example adds [Riot.js](http://muut.com/riotjs/) to our popular [Hapi.js Socket.io and Redis Publish/Subscribe chat application example](https://github.com/dwyl/hapi-socketio-redis-chat-example), as per issue [#20]( https://github.com/dwyl/hapi-socketio-redis-chat-example/issues/20).

The commits have been added in step-by-step so it should be simple to follow along. Watch this space!

+ [ ] Add links to Riot documentation throughout & encourage pre-reading

##Deciding where to add Riot.js

We took our [basic chat app example](https://github.com/dwyl/hapi-socketio-redis-chat-example) and decided to add in Riot.js to replace the portion of the code where HTML was being dynamically generated.

```javascript
//code snipped from client.js
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
<br/>

##Add Riot to the app & get it to display simple dummy data

### 1. [Adds Riot.js 'Hello World'](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/commit/13742162d8894e49684a6d27dcf1ea65f122180c?diff=split&w=1)
Our first task is to add our [custom riot tag](https://muut.com/riotjs/guide/) into `index.html` and have it display some content (in this case, "Hello World"). This ensures we have Riot set up properly.
+ Add the [Riot CDN](https://muut.com/riotjs/download.html) in a script tag at the bottom of your `index.html` (use the version which includes the _compiler_)
+ Add your custom element (`<message></message>`) to the body of `index.html`
+ Create your `.tag` file (where your _Riot code_ will live, in this case `message.tag`) and link it to `index.html` using a script tag (don't forget to add `type='riot/tag'`)
  + `.tag` is a riot file extension with special syntax so you shouldn't worry if your text editor doesn't have syntax highlighting.
  + _Note: You **can** call your `.tag` file whatever you like as long as you reference it correctly in `index.html` - we recommend keeping it to the name of your component so the contents of the file are immediately obvious_
+ Inside your `.tag` file, make sure your 'Hello World' is contained within the custom tags you have added `index.html`. In our case, it should look like this:

```html
<message>
  <p>Hello World!</p>
</message>
```


### 2. [Adds dummy array of data & iterates through it with Riot](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/13742162d8894e49684a6d27dcf1ea65f122180c...9d8d80ab628bd71282a0eaf66ebb343d0358ca0c?diff=split)
We're using Riot to replace dynamically generated HTML so we need to make sure our Riot code can do the same job. We will **create some dummy data and render it with Riot**.
+ Create some dummy data in the form of an array
  + This will be in your `<message>` element within `message.tag` and should be contained within `<script>` tags for readability (though this isn't strictly necessary)
  + Remember to attach your array to `this` so that Riot recognises it
+ Use [Riot's `each` functionality](https://muut.com/riotjs/guide/#loops) to iterate through that array and display the data in each `<li>`
  + Pass your array of dummy data to the `each` loop
  + The tag that you add the `each` attribute to (in this case, `<li>`) is the tag that will be repeated for every element of the array
  + Note that properties of the array's elements (such as `{msg}` in this commit) can be referenced directly by name

As always, you can [look at our commit](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/blob/9d8d80ab628bd71282a0eaf66ebb343d0358ca0c/public/message.tag) to see what we have added in this step.


### 3. [Changes dummy data format & HTML structure in message.tag](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/9d8d80ab628bd71282a0eaf66ebb343d0358ca0c...88d53cc1601b564cfb6df695b1ccff0527558f1e?diff=split)
We want to ensure that our Riot code will work with the structure of the data coming from our Redis database.
+ Change your dummy data array to mimic the data structure you would get from Redis
  + The data structure is explained in a comment in the file for this commit
+ Alter your HTML to look like the expected HTML structure (the HTML that is being appended in `renderMessage` in `client.js`)


### 4. [Format the timestamp correctly](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/88d53cc1601b564cfb6df695b1ccff0527558f1e...0f3ab0d7acd12c8335870988171b7f778665fe86?diff=split)
We need to **format our data to be human readable**. `getTime()` and `leadZero()` in `client.js` already do this but we **don't have access to them in `<message>`** as they are scoped to the `$(document).ready` handler in `client.js`.
Given that we are not using either of these functions for any other purpose except formatting the data we will be rendering in `<message>`, we can safely move these functions as a whole into that file which now allows our Riot code to access them.
+ **Move _getTime()_ and _leadZero()_ to `message.tag`**
  + Replace the `function` keyword with `this.`, for the same reason as we attached our dummy data array to `this` ([explained in step 2](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/issues/9))
  + Similarly, we need to bind the calls to `leadZero()` _within_ `getTime()` to `this`
```js
this.getTime = function (timestamp) {
  var t, h, m, s, time;
  t = new Date(timestamp);
  h = this.leadZero(t.getHours());
  m = this.leadZero(t.getMinutes());
  s = this.leadZero(t.getSeconds());
  return '' + h  + ':' + m + ':' + s;
};
```
+ **Call the `getTime()` function on our time (`t`) data**
  + We need to use `parent.getTime()`. Riot would read `getTime()` as `this.getTime()` and `this` refers to the current element of the array as opposed to `<message>` which is where the function is accessible

+ Delete the section of `renderMessage()` that appends the HTML to the `#messages` ul, so we understand what is being done by Riot versus our original code  

_ Note: At this point, if you try to type something into the message input box, it won't show up on the page as we've now removed the functionality of `renderMessage()` but have yet to replace it with Riot functionality_

<br/>

##Hook up Riot to the live data from Redis
### 5. [Change where we mount Riot](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/0f3ab0d7acd12c8335870988171b7f778665fe86...6cd72e0e4e18beffe8574847d91a7da1677e2988?diff=split)
We know that we only want to [mount](https://muut.com/riotjs/guide/#mounting) the `<message>` tag when there is data to display.

+ Move `riot.mount` to the `$.get()` callback within `loadMessages()` (in `client.js`) to ensure the Riot element is mounted when there is data

If you're worried `riot` is not defined in your `client.js`, don't be as it's a global variable.
[JSHint](http://jshint.com/) however, _will_ complain about this.

![must-add-riot-to-jshint-globals](https://cloud.githubusercontent.com/assets/4185328/9226392/5e0bf338-4106-11e5-85ca-172a14328d1d.png)

+ To fix this, add 'riot' to globals in your `.jshintrc` file


### 6. [Get data from Redis to be rendered using Riot](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/6cd72e0e4e18beffe8574847d91a7da1677e2988...b755c52189805c0a402753cefecc2ae069a21383?diff=split)
**Every time a new message is input** through the message input box, we want to **save it to an array** (`messageStore`). Changes made to this array will be available to `<message>`
+ Create empty array to hold new messages (`messageStore`)

renderMessage() is called once for every message (both from Redis and from Socket.io), so this is the ideal place to update our `messageStore` array.

+ Add messages to our array using push in `renderMessage()`
+ Pass the `messageStore` array to our Riot `tag` as an option in riot.mount: `riot.mount('message', {messageStore: messageStore});`
+ `messageStore` is now available to be used in `<message>` and you can now replace the dummy data with the live data from this array using `this.messageStore = opts.messageStore`
+ Switch your data source from `dummyData` to `messageStore` in the Riot `each` loop
_Note: Any messages input into the message input box at this stage and going into the database and into our `messageStore` array, but are not yet being rendered on the page by Riot - if you refresh your page however, messages are loaded in from Redis and will appear in the browser_.


### 7. [Get Riot to render new messages to the page](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/b755c52189805c0a402753cefecc2ae069a21383...a71edd3da901ef6b01f5206578ffbb26aa810bdd?diff=split)
Everything is set up for Riot to function correctly, we just need to tell it when changes are made to `messageStore` so that it can render these to the browser.

+ Add `riot.update()` to `renderMessage()` to be called after updating the `messageStore` array.

:tada:  :tada:  :tada:  :tada:
##Bug fixes
### 8. [scrollToBottom bug](https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/compare/a71edd3da901ef6b01f5206578ffbb26aa810bdd...b85121e0aa14c803d4041dd730b8189c86feab5f?w=1)
It looks like someone has raised an issue on our repo!
https://github.com/dwyl/hapi-socketio-redis-riot-chat-example/issues/3

**Why is this happening?**
+ Try adding `console.log($('#messages').height())` to `scrollToBottom()` and refresh your page to see what happens

We're calling `scrollToBottom()` straight after calling `riot.mount` which means **Riot has not yet had the time to update the page** so there is nothing to scroll to the bottom of!. What we want to do is call it right after `riot.mount` **_finishes_**. To fix this:
+ Pass the `scrollToBottom()` function as part of the options object so it's available to `<message>`
+ `this.on('mount')` tells Riot to perform an action once `mount` is complete, so add `this.on('mount', opts.scrollToBottom)` to `message.tag`.

_Note: In step 4, we moved functions into our `message.tag` file to give Riot access to them. In this case, `scrollToBottom()` is being used in various places in `client.js` so we can't remove it completely otherwise `client.js` would lose access to it._  

_We could move `window.onresize` to `message.tag` as `window` is a global variable, but this is a bad [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)._
