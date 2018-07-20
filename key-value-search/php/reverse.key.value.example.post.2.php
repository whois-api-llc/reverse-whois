<?php

$user = 'Your reverse whois api username';
$password = 'Your reverse whois api password';

$header = "Content-Type: application/json\r\nAccept: application/json\r\n";
$url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php';

$options = array('http' => array(
    'method' => 'POST',
    'header' => $header,
    'content' => json_encode(
        array(
            'terms' => array(
                array(
                    'section' => 'Registrant',
                    'attribute' => 'Email',
                    'value' => 'a',
                    'exclude' => false,
                    'matchType' => 'BeginsWith'
                ),
                array(
                    'section' => 'General',
                    'attribute' => 'DomainName',
                    'value' => '.com',
                    'exclude' => 'false',
                    'matchType' => 'EndsWith'
                )
            ),
            'recordsCounter' => false,
            'mode' => 'purchase',
            'rows' => 10,
            'username' => $user,
            'password' => $password
        )
    )
));

$response = file_get_contents($url,false,stream_context_create($options));
print_r(json_decode($response));
print(PHP_EOL);