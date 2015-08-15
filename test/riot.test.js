var server = require('../server.js');
var test   = require('tape');

test('we get back messages from Redis', function (t) {
  server.inject({method: 'GET', url: '/'}, function (response) {
    t.ok(response.payload.indexOf('butterflies') > -1, 'message from test is in response payload');
    t.end();
  })
});
