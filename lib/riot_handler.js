var riot           = require('riot');
var hello          = require('../public/hello.tag');
var serverMessage  = require('../public/server-message.tag');
var getMessages    = require('./load_messages').get;

function serverRender (tag) {
  return function (request, reply) {
    var renderedHTML = riot.render(tag);
    reply(renderedHTML);
  };
}

function renderRedisMessages (request, reply){
  // getMessages takes a function as an argument
  getMessages(function (messagesFromRedis) {
    var messageStore = messagesFromRedis.map(JSON.parse);

    // Hmmm  ... not very DRY ...
    //
    // messageStore is being passed in as an option to the serverMessage tag
    // where it will be accessible as opts.messageStore
    var renderedHTML = riot.render(serverMessage, {messageStore: messageStore});
    reply(renderedHTML);
  });
}

module.exports = {
  hello: serverRender(hello),
  message: renderRedisMessages
};
