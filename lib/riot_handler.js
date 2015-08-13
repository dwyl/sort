var riot  = require('riot');
var hello = require('../public/hello.tag');

// riot.render([pathname], [options object])

module.exports = function (request, reply) {
  var renderedHTML = riot.render(hello);
  reply(renderedHTML);
}
