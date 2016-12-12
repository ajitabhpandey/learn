#!/usr/bin/perl
use warnings;
use strict;
use 5.10.0;
use Net::OpenSSH;

my $host = 'ucvsrv1.unixclinic.net'; 
my $port = "9012";
my $username = 'ajitabhp';
my $password = 'Vubpash0@7';

my $kernelRevisionCmd = "uname -r";

my @cmds = ("uname -r", "uname -m", "uname -s");

my $ssh = Net::OpenSSH->new("$username:$password\@$host:$port",
    timeout=>30);
$ssh->error 
    and die "Unable to connect to remote host: " . $ssh->error;

my $out = $ssh->pipe_out($kernelRevisionCmd) or die "Unable to run remote command";

while (<$out>) {
    print "$. $_";
}
