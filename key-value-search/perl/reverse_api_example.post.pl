#!/usr/bin/perl

use HTTP::Request::Common qw{ POST }; # From CPAN
use JSON qw( decode_json );           # From CPAN
use LWP::Protocol::https;             # From CPAN
use LWP::Simple;                      # From CPAN
use LWP::UserAgent;                   # From CPAN

use strict;
use warnings;

########################
# Fill in your details #
########################
my $user_name = 'Your reverse whois api username';
my $password = 'Your reverse whois api password';

my $url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php';

#######################
# Use a JSON resource #
#######################

my $responseJson = JSON->new->decode(reverseWhoisApiSearch('json'));
print "JSON\n---\n";
print JSON->new->pretty->encode($responseJson);

#######################
# Getting the data    #
#######################

sub reverseWhoisApiSearch {
    my $content = ' {
        "terms": [
            {
                "section": "Admin",
                "attribute": "organization",
                "value": "Wikimedia",
                "matchType": "anywhere",
                "exclude": false
            },
            {
                "section": "technical",
                "attribute": "city",
                "value": "San Francisco",
                "matchType": "anywhere",
                "exclude": false
            }
        ],
        "recordsCounter": false,
        "outputFormat": "json",
        "username": "' . $user_name . '",
        "password": "' . $password . '",
        "rows": 100
    }';

    my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 0 });
    my $req = HTTP::Request->new('POST', $url);

    $req->header('Content-Type' => 'application/json');
    $req->header('Accept', 'application/json');
    $req->content($content);

    my $response = $ua->request($req);
    print $response->content;
    return $response->content;
}