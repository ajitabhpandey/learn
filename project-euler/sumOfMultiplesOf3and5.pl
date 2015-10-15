#!/usr/bin/perl
#
# Multiples of 3 and 5 - 
#
# If we list all the natural numbers below 10 that are multiples of 3 or 
# 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.
use warnings;
use strict;

my $maxNum = 1000;
my @nums = ( 3, 5 );
my @allMultiples = ();
my $sumOfMultiples = 0;

# for each of the numbers, loop through to find out multiples 
# which are less than $maxNum
foreach (@nums) {
	for (my $i = $_; $i < $maxNum; $i += $_) {
		push @allMultiples, $i;
	}
}

# The GCD for 3 and 5 is 1 and the LCM for 3 and 5 is 15. 
# This means that every number which is divisible by 15 was counted twice.
# Thus, these duplicates need to be removed from the array @allMultiples
#
# Removing duplicates from array by using hash 
# (Ref - http://stackoverflow.com/a/7829/1213682)
#
my %allMultiplesHash = map { $_, 1 } @allMultiples;
my @uniqueMultiples = keys %allMultiplesHash;

foreach (@uniqueMultiples) {
	$sumOfMultiples += $_;
}

print "\nSum of multiples is: ", $sumOfMultiples, "\n";