try:
    import http.client as http
except ImportError:
    import httplib as http

import json

username = 'Your reverse whois api username'
password = 'Your reverse whois api password'

payload = {
    'terms': [
        {
            'section': 'Admin',
            'attribute': 'name',
            'value': 'whois',
            'matchType': 'anywhere',
            'exclude': False
        }
    ],
    'recordsCounter': False,
    'username': username,
    'password': password,
    'outputFormat': 'json',
    'mode': 'purchase',
    'rows': 10
}


def print_response(txt):
    response_json = json.loads(txt)
    print(json.dumps(response_json, indent=4, sort_keys=True))


headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

conn = http.HTTPSConnection('www.whoisxmlapi.com')

conn.request('POST',
             '/reverse-whois-api/search.php',
             json.dumps(payload),
             headers)

response = conn.getresponse()
text = response.read().decode('utf8')

print_response(text)
