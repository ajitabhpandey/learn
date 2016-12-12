#!/usr/bin/perl
use warnings;
use strict;

# to print 50 lines of output, first containing X, second XX etc
# using for
for my $times (1..50) {
	print 'X' x $times, "\n";
}

# using foreach
foreach my $times (1..50) {
	print 'X' x $times, "\n";
}  

# asks for a word and prints it five times. 
# continue until 'quit' is entered
my $word = '';

while ($word ne 'quit'){
	print "Enter a word and I will print it 5 times, quite to exit: ";
	chomp($word = <STDIN>);
	if ($word ne 'quit') {
		for my $count (1..5) {
			print $word, " ";
		}
		print "\n";
	}
}

# PIN checking
my $pin = "03452";
my $attempts = 3;

while ($attempts-- > 0) {
	print "Enter your PIN: ";
	chomp(my $user_input = <STDIN>);
	
	if ($user_input eq $pin) {
		print "Correct, you can enter.\n";
		last;
	}
	else {
		if ($attempts > 0) {
			print "Incorrect: Retry\n";
		}
		else {
			print "You have exhausted all attempts. Bye!\n";
		}
	}
}