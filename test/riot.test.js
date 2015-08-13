var server = require('../server.js');
var test   = require('tape');


// var dummyData = [
//   {n:'Emma', m:'Message 1', t:1234567891234},
//   {n:'Mina', m:'Message 2', t:3456789123456},
//   {n:'Rafe', m:'Message 3', t:5678912345678},
//   {n:'Jack', m:'Message 4', t:7891234567891},
//   {n:'Dave', m:'Message 5', t:9123456789123},
// ];

test('we get back "Hello #dwylsummer"', function (t) {
  server.inject({method: 'GET', url: '/hello'}, function (response) {
    t.equals(response.statusCode, 200);
    t.ok(response.payload.indexOf('Hello #dwylsummer') > -1);
    t.end();
  })
});

// test('we get back iterated messages', function (t) {
//   server.inject({ method: 'GET',  url: '/server-message'}, function (response) {
//     t.equals(response.statusCode, 200);
//     dummyData.forEach(function(messageObject, index){
//       t.ok(response.payload.indexOf(messageObject.m) > -1, 'message #' + (index + 1) + ' is present');
//     });
//     t.end();
//   });
// });

test('we get back messages from Redis', function (t) {
  server.inject({method: 'GET', url: '/server-message'}, function (response) {
    t.ok(response.payload.indexOf('butterflies') > -1, 'message from test is in response payload');
    t.end();
  })
});
