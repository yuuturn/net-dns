#!/usr/bin/perl
use strict;
use warnings;
use MIME::Base64;
use Net::DNS;
use Net::DNS::Packet;

my $bb64 = <STDIN>;
chomp($bb64);
my $data = decode_base64($bb64);
my $packet = Net::DNS::Packet->new(\$data, 1);
