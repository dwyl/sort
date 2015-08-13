var Hapi         = require('hapi');
var server       = new Hapi.Server();
var riotHandlers = require('./lib/riot_handler.js');

server.connection({
	host: '0.0.0.0',
	port: Number(process.env.PORT)
});

server.route([
  { method: 'GET', path: '/', handler: { file: 'public/index.html' } },
	// switch these two routes for a /static handler?
  { method: 'GET', path: '/{param*}' , handler: {directory: {path:'public'} } },
  { method: 'GET', path: '/load', handler:
      require('./lib/load_messages').load },

	{ method: 'GET', path: '/hello',          handler: riotHandlers.hello },
	{ method: 'GET', path: '/server-message', handler: riotHandlers.message }
]);

server.start(function () {
  require('./lib/chat').init(server.listener, function(){
    console.log(process.env.REDISCLOUD_URL);
    console.log('What do you want to talk about...?', 'listening on: http://127.0.0.1:'+process.env.PORT);
	});
});

module.exports = server;
