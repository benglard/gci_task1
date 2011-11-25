use Android;
use strict;
use warnings;

my $droid = Android->new();

#purpose of program
$droid->makeToast('This program checks whether a word is a palindrome.');

$droid->notify('Usage', 'Make sure not to use punctuation!');

my $input = $droid->dialogGetInput("Palindrome Checker", "Please enter a word: ",
'')->{'result'};

check($input);

# Recursive function for determining whether a word is a palindrome.
# First checks if word is entered. Then checks is first character and last characters are the same.
# If yes - remove first and last letters and start over
# If no - end 
# If length of string (possibly new string) = 1 - end => Palindrome!

sub check {
	my $input = $_[0];
	
	if ($input eq "")
	{
		$droid->makeToast('You did not enter a word.');
	}
	else 
	{
		my $len = length $input;
		my $firstChar = substr("$input", 0, 1);
		my $lastChar = substr("$input", $len -1, 1);
		print "$len, $firstChar, $lastChar"; #good for testing
		
		if ($firstChar ne $lastChar) 
		{
			$droid->makeToast('The word you entered is not a palindrome.');
		}
		elsif ($len == 1) 
		{
			$droid->makeToast('The word you entered is a palindrome.');
		}
		else 
		{
			$input = substr("$input", 0, 1, "");
			# $input = substr("$input", $len -1, 1, ""); -- done by command above
			if ($input eq "")
			{
				$droid->makeToast('The word you entered is a palindrome.');
			}
			else 
			{
				check("$input");
			}
		}
	}
}