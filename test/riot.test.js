var server = require('../server.js');
var test   = require('tape');

test('we get back "Hello #dwylsummer"', function (t) {
  server.inject({method: 'GET', url: '/hello'}, function (response) {
    t.equals(response.statusCode, 200);
    t.ok(response.payload.indexOf('Hello #dwylsummer') > -1);
    t.end();
  })
})
