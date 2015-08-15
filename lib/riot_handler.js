var riot           = require('riot');
var message        = require('../public/message.tag');
var getMessages    = require('./load_messages').get;

function renderRedisMessages (request, reply){
  // getMessages takes a function as an argument
  getMessages(function (messagesFromRedis) {
    var messageStore = JSON.stringify(messagesFromRedis.map(JSON.parse));
    var renderedHTML = riot.render(message, {messageStore: messageStore});
    var safeHTML = renderedHTML.replace(/<\/script/g, '<\\/script')
        .replace(/<!--/g, '<\\!--');
    reply.view('index', {messages: safeHTML, messageStore: messageStore } );
  });
}

module.exports = renderRedisMessages;
