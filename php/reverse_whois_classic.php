<?php

$term = 'wikimedia';
$username = 'Your reverse whois api username';
$password = 'Your reverse whois api password';
$mode = 'purchase';
$format = 'xml';
$rows = 10;

$apiUrl = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php';

$params = array(
    'term1' => $term,
    'mode' => $mode,
    'rows' => $rows,
    'username' => $username,
    'password' => $password,
    'output_format' => $format
);

$url = $apiUrl . '?' . http_build_query($params, '', '&');

print($url . PHP_EOL . PHP_EOL);
print(file_get_contents($url) . PHP_EOL);