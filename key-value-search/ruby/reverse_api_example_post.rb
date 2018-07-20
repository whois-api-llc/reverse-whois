require 'json'
require 'net/https'
require 'openssl'
require 'uri'
require 'yaml' # only needed to print the returned result in a very pretty way

########################
# Fill in your details #
########################
username = 'Your reverse whois api username'
password = 'Your reverse whois api password'

#######################
# Use a JSON resource #
#######################
format = 'json'
url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php'

content = {
  terms: [
    {
      section: 'Registrant',
      attribute: 'Name',
      matchType: 'BeginsWith',
      value: 'Mark',
      exclude: false
    },
    {
      section: 'Technical',
      attribute: 'Country',
      matchType: 'Anywhere',
      value: 'US',
      exclude: true
    }
  ],
  mode: 'preview',
  recordsCounter: false,
  username: username,
  password: password,
  outputFormat: format
}

uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)

# Connect using ssl
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Post.new(uri.request_uri)

# Set headers
request.add_field('Content-Type', 'application/json')
request.add_field('Accept', 'application/json')
request.body = content.to_json

# Get response
response = http.request(request)

# Print parsed json
puts JSON.parse(response.body).to_yaml