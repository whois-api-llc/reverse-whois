<?php

$term = 'wikimedia';
$password = 'Your_reverse_whois_api_password';
$username = 'Your_reverse_whois_api_username';

$url ="https://www.whoisxmlapi.com/reverse-whois-api/search.php?term1={$term}"
    ."&username={$username}&password={$password}&mode=preview";

print(file_get_contents($url));