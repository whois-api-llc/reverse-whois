$url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php'

$username = 'Your reverse whois api username'
$password = 'Your reverse whois api password'
$term1 = 'test'
$rows = 5

$uri = $url`
     + '?term1=' + [uri]::EscapeDataString($term1)`
     + '&username=' + [uri]::EscapeDataString($username)`
     + '&password=' + [uri]::EscapeDataString($password)`
     + '&rows=' + $rows

#######################
# Use a JSON resource #
#######################

$j = Invoke-WebRequest -Uri $uri
echo "JSON:`n---" $j.content "`n"

#######################
# Use an XML resource #
#######################

$uri = $uri + '&output_format=xml'

$j = Invoke-WebRequest -Uri $uri
echo "XML:`n---" $j.content