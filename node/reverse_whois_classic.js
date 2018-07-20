var http = require('https');
var querystring = require('querystring');

var term = 'cinema';
var username = 'your reverse whois api username';
var password = 'your reverse whois api password';
var mode = 'preview';
var rows = 20;

var url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php';

var params = {
    term1: term,
    username: username,
    password: password,
    mode: mode,
    rows: rows
};

url += '?' + querystring.stringify(params);

http.get(url, function(response) {
    var str = '';
    response.on('data', function(chunk) {
        str += chunk;
    });
    response.on('end', function() {
        console.log(JSON.parse(str));
    });
}).end();