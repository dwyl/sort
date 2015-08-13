var redis       = require('redis');
var rc          = require('../lib/redis_config.js')(process.env.NODE_ENV); // config for Cloud/Local
var redisClient = redis.createClient(rc.port, rc.host); // create client

redisClient.auth(rc.auth); // *optionally* authenticate when using RedisCloud

function getMessages (callback) {
  redisClient.lrange("chat:messages", 0, -1, function (err, data) {
    callback(data);
  });
}

function loadMessages (req, reply) {
  getMessages(reply);
}

module.exports = {
  load: loadMessages,
  get: getMessages,
  redisClient: redisClient
};
