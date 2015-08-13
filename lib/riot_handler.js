var riot           = require('riot');
var message        = require('../public/message.tag');
var getMessages    = require('./load_messages').get;

function renderRedisMessages (request, reply){
  // getMessages takes a function as an argument
  getMessages(function (messagesFromRedis) {
    var messageStore = messagesFromRedis.map(JSON.parse);
    var renderedHTML = riot.render(message, {messageStore: messageStore});
    reply.view('index', {messages: renderedHTML } );
  });
}

module.exports = {
  message: renderRedisMessages
};
