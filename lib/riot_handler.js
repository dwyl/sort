var riot           = require('riot');
var serverMessage  = require('../public/server-message.tag');
var getMessages    = require('./load_messages').get;

function renderRedisMessages (request, reply){
  // getMessages takes a function as an argument
  getMessages(function (messagesFromRedis) {
    var messageStore = messagesFromRedis.map(JSON.parse);
    var renderedHTML = riot.render(serverMessage, {messageStore: messageStore});
    reply(renderedHTML);
  });
}

module.exports = {
  message: renderRedisMessages
};
