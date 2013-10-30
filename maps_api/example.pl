#!/usr/bin/perl

use strict;
use warnings;
require LWP::UserAgent;
require HTTP::Request;
use JSON qw( decode_json );
use LWP::Simple;

print "Sample google maps api call\n\n";

#can do gps coordinates as well
my $start_location = "Pittsburgh";
my $end_location = "Philidelphia";

my $url = 'http://maps.googleapis.com/maps/api/directions/json?origin='.$start_location.'&destination='.$end_location.'&sensor=false';

#make api call
my $json_response = get($url);
die "Could not get $url!" unless defined $json_response;

#decode the JSON response
my $decoded_response = decode_json($json_response);

print "\n";
my @routes_array = @{ $decoded_response->{'routes'} };
my @legs_array = @{ $routes_array[0]->{'legs'} };
my $start_address = $legs_array[0]->{'start_address'};
my $end_address = $legs_array[0]->{'end_address'};
my $duration = $legs_array[0]->{'duration'}->{'text'};

print "From: ".$start_address."\n";
print "To: ".$end_address."\n";
print "Time: ".$duration."\n";
