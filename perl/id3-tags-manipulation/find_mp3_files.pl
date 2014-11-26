#!/usr/bin/perl
#
# find_mp3_files.pl
# https://metacpan.org/pod/Path::Iterator::Rule
#
use 5.010;
use warnings;
use strict;
use lib "/Users/ajitabh/perl5/lib/perl5";
use Path::Iterator::Rule;

my $start_location = shift @ARGV or die "Usage: $0 DIRECTORY\nwhere DIRECTORY is the starting location to start looking for mp3 files\n";

# Create a new rule object
my $rule = Path::Iterator::Rule->new;

# Set the rules for iteration
$rule->name("*.mp3");

my $iterator = $rule->iter($start_location);
while (my $file = $iterator->()) {
  say $file;
}