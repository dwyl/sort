var riot           = require('riot');
var hello          = require('../public/hello.tag');
var serverMessage  = require('../public/server-message.tag');

function helloHandler (request, reply) {
  var renderedHTML = riot.render(hello);
  reply(renderedHTML);
}

function serverMessageHandler (request, reply) {
  var renderedHTML = riot.render(serverMessage);
  reply(renderedHTML);
}

module.exports = {
  hello: helloHandler,
  message: serverMessageHandler
};
