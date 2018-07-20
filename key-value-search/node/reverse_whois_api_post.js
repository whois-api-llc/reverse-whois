var https = require('https');

// Fill in your details
var username = 'Your reverse whois api username';
var password = 'Your reverse whois api password';

// Build the post string
var post_data = {
    terms: [
        {
            section: 'Registrant',
            attribute: 'email',
            value: 'gmail.com',
            exclude: false,
            matchType: 'EndsWith'
        },
        {
            section: 'General',
            attribute: 'DomainName',
            value: '.com',
            exclude: false,
            matchType: 'EndsWith'
        }
    ],
    recordsCounter: false,
    mode: 'purchase',
    outputFormat: 'json',
    username: username,
    password: password,
    rows: 20
};

// Set options fo request
var options = {
    hostname: 'www.whoisxmlapi.com',
    path: '/reverse-whois-api/search.php',
    port: 443,
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Content-Length': JSON.stringify(post_data).length
    },
    json: true
};

// Create request and get response
var req = https.request(options, function(res)  {
    var str = '';
    res.on('data', function(chunk) {
        str += chunk;
    });
    res.on('end', function() {
        console.log(JSON.parse(str));
    });

});

// Handle errors
req.on('error', function(e) {
    console.error(e);
});

// Send request
req.write(JSON.stringify(post_data));
req.end();