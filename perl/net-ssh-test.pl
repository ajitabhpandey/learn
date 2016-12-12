#!/usr/bin/perl -w
use strict;
use Net::SSH::Perl;

my $hostname = "paru.aphome.lan";
my $username = "";
my $password = '';

my $cmd = shift;

my $ssh = Net::SSH::Perl->new("$hostname", debug=>0);
$ssh->login("$username","$password");
my ($stdout,$stderr,$exit) = $ssh->cmd("$cmd");
print $stdout;