########################
# Fill in your details #
########################

$username = 'Your reverse whois api username'
$password = 'Your reverse whois api password'

#######################
# Use a JSON resource #
#######################

$postParams = @{
    terms = @(
        @{
            section = 'Admin'
            attribute = 'name'
            value = 'john'
            matchType = 'anywhere'
            exclude = 'false'
        }
    )
    recordsCounter = 'false'
    username = $username
    password = $password
    outputFormat = 'json'
    rows = 10
    mode = 'purchase'
} | ConvertTo-Json

$uri = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php'

$response = Invoke-WebRequest -Uri $uri -Method POST -Body $postParams `
            -ContentType 'application/json'

echo $response.content | convertfrom-json | convertto-json -depth 10