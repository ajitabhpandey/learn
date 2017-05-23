#!/usr/bin/perl
use strict;
use warnings;

my $word = "worabcdd";

hasAllUniqueChars($word);

sub hasAllUniqueChars {
	my ($chars) = @_;

	# sort the string
	my $processedChars = join('', sort(split //, $chars));

	# Only keep the unique characters
	$processedChars =~ s/(.)\1+/$1/g;

	if (length($processedChars) == length($chars)) {
		print "All Unique","\n";
		return 0;
	} else {
		print "Duplicates found", "\n";
		return 1;
	}

}