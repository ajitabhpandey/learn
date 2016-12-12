#!/usr/bin/perl

use strict;
use warnings;

use Filesys::DfPortable qw(dfportable);

my $df = dfportable("/", 1024);

print "Total size: $df->{blocks} K\n";
print "Available: $df->{bfree} K\n";
print "Used: $df->{bused} K\n";
print "Percent Full: $df->{per} %\n";
print "Total available for use: $df->{bavail} K\n";