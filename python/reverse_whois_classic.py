try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen

term = 'wikimedia'
password = 'Your_reverse_whois_api_password'
username = 'Your_reverse_whois_api_username'

url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php?mode=preview'\
    + '&term1=' + term + '&username=' + username + '&password=' + password

print(urlopen(url).read().decode('utf8'))