var chalk = require('chalk'); // colorfull console output
var exec  = require('child_process').exec; // we run our script in child processes

var child = exec('npm start'); // pass in the script here
child.stdout.setEncoding('utf8');

child.stdout.on('data', function(data) {
  console.log("ChildProcess Says: " + chalk.cyan(data))
});

child.stderr.on('data', function(data) {
  console.log(chalk.green("Running: "+chalk.cyan('npm start'))
  +" at " + chalk.green(new Date().toTimeString()));
});

child.on('close', function(code) {
    console.log(chalk.green('>> Closing Child Process ;-)'));
});

var terminate = require('terminate');
var assert    = require('assert');
var phantom   = require('phantom');
var ordem     = require('ordem');
setTimeout(function(){
  phantom.create(function (ph) {
    ph.createPage(function (page) {
      page.open("http://127.0.0.1:8000", function (status) {
        console.log("opened chat? ", status);
        ordem([
          function(callback) {
            page.evaluate(function () { return document.title; }, function (result) {
              console.log('Page title is ' + result);
              // page title is what we expect it to be:
              assert(result.match(/Chat/), "Chat Title is: "+result);
              callback(null, 'done')
            });
          },
          // function(callback) {
          //   page.evaluate(function () { return document.getElementById('messages'); }, function (result) {
          //     // console.log('Messages is ', result);
          //     // page title is what we expect it to be:
          //     console.log(result.innerHTML);
          //     // assert(result.innerHTML.indexOf('<message>'), "message is empty! "+result.innerHTML);
          //     callback(null, 'done')
          //   });
          // }
        ], function callback(err, result){
          console.log(result);
          terminate(child.pid, function(err, done){
            console.log('Done? '+ done); // do what you do best!
            ph.exit();
          });
        })
      });
    });
  });
}, 2000)
