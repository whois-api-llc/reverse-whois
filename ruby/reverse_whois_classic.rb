require 'erb'
require 'json'
require 'net/https'
require 'uri'
require 'yaml' # only needed to print the returned result in a very pretty way

########################
# Fill in your details #
########################
username = 'Your reverse whois api username'
password = 'Your reverse whois api password'
term = 'wikimedia'

url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php' \
      '?term1=' + ERB::Util.url_encode(term) +
      '&username=' + ERB::Util.url_encode(username) +
      '&password=' + ERB::Util.url_encode(password) +
      '&output_format='

#######################
# Use a JSON resource #
#######################
format = 'json'

# Open the resource
buffer = Net::HTTP.get(URI.parse(url + format))

# Parse the JSON result
result = JSON.parse(buffer)

# Print out a nice informative string
puts "JSON:\n" + result.to_yaml + "\n"