#!/usr/bin/env perl

use strict;
use warnings;
use Net::DNS;
use Data::Dumper;

my $qname = "example.com";
my $type = "A";

my $resolver = Net::DNS::Resolver->new(
        'nameservers' => 'a.iana-servers.net',
        'port'        => 53,
        'retry'       => 3,
        'udp_timeout' => 3,
        'tcp_timeout' => 3,
        'recurse'     => 0,
);

my $packet = new Net::DNS::Packet("$qname", "$type");

my $rr = new Net::DNS::RR(
        name            => "",
        type            => "OPT",
        class           => 4960,
        optioncode      => 3,
        optiondata      => 0,
);

$packet->push(additional => $rr);
my $reply = $resolver->send($packet);

## debug
#print Dumper $rep;

if ($reply->additional){
        my $nsid = $reply->pop("additional")->rdata;
        print "NSID: $nsid\n"
}
