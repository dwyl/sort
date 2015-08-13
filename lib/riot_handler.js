var riot           = require('riot');
var hello          = require('../public/hello.tag');
var serverMessage  = require('../public/server-message.tag');

function serverRender (tag) {
  return function (request, reply) {
    var renderedHTML = riot.render(tag);
    reply(renderedHTML);
  };
}

module.exports = {
  hello: serverRender(hello),
  message: serverRender(serverMessage)
};
