use Android;
use strict;
use warnings;

my $droid = Android->new();

#purpose of program
$droid->makeToast('This program is a guessing game. 
See how many tries it takes you to guess the number. Enjoy!');

my $range = 100;
my $rand_num = rand($range);
$rand_num = int(rand_num) +1;

my $input = askInput();

my $counter = 1;

while ($input != rand_num) 
{
	if ($input > rand_num) 
	{
		$counter++;
		$droid->makeToast("Your guess was too large");
		$input = askInput();
	}
	elsif ($input < rand_num)
	{
		$counter++;
		$droid->makeToast("Your guess was too small");
		$input = askInput();
	}
}

$droid->makeToast("Congratulations!");
$droid->makeToast("The random number was $rand_num");
$droid->makeToast("It took you $counter guesses");

sub askInput {
	#ask for a user's guess, return it
	my $input = $droid->dialogGetInput("Input Box", "Please enter a guess (1-100): ",
	'')->{'result'};
	return $input;
}