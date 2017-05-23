#[Challenge] Unique Characters In A String
[Unique Characters In A String](https://discuss.codecademy.com/t/challenge-unique-characters-in-a-string/82151) 

Write a function that determines if any given string has all unique characters (i.e. no character in the string is duplicated). If the string has all unique characters, print "all unique". If the string does not have all unique characters, print "duplicates found."

##Solution 1 - Using regular expressions

In perl the logic goes as follows -

* sort the characters in the string (not very efficient for very long strings)
* use regular expression to keep only one copy of the character in case characters are repeated in the sorted string The entire regular expression translates to - "Any character followed by the same character one or more time is to be substituted by that character."
	* (.) - Matches any one character and create a group of that character for later use.
	* \1 - Is backreference and refers to the previously selected charcter.
	* + - Plus sign in regular expression means one or more time. 
* Compare the length of the processed string with the original string and print results


```
sub hasAllUniqueChars {
	my ($chars) = @_;

	# sort the string (not very efficient for long strings
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
```
