#!/usr/bin/perl

use LWP::Protocol::https;         # From CPAN
use LWP::Simple;                  # From CPAN
use URI::Escape qw( uri_escape ); # From CPAN

use strict;
use warnings;

my $base_url = 'https://www.whoisxmlapi.com/reverse-whois-api/search.php';
my $term1 = 'whois';
my $exclude_term1 = 'domain';
my $exclude_term2 = 'news';
my $username = 'Your reverse whois api username';
my $password = 'Your reverse whois api password';

#######################
# Use a JSON resource #
#######################
print "JSON\n---\n" . getData('json') . "\n\n";

#######################
# Use an XML resource #
#######################
print "XML\n---\n" . getData('xml');

#######################
# Getting the Data    #
#######################
sub getData {
    my $format = $_[0];
    my $url = $base_url
            . '?username=' . uri_escape($username)
            . '&password=' . uri_escape($password)
            . '&term1=' . uri_escape($term1)
            . '&exclude_term1=' . uri_escape($exclude_term1)
            . '&exclude_term2=' . uri_escape($exclude_term2)
            . '&output_format=' . uri_escape($format);

    print "Get data by URL: $url\n";
    # 'get' is exported by LWP::Simple;
    my $object = get($url);

    die "Could not get $base_url!" unless defined $object;
    return $object
}