use Android;
use strict;
use warnings;

=pod

-This script geneates a password of either random letters or numbers (depending on user's choice) 
of a length that the user provides.
-Android functionality used includes:
	a. Pop-ups for information/results
	b. Getting user input through a dialog input box
	c. Getting user input through an alert box with positive/negative/neutral buttons, 
	   determing which button user clicks on

=cut

my $droid = Android->new();

# purpose of program
$droid->makeToast('This program generates a password of a given length');

my $len = $droid->dialogGetInput("Length of Password", "Enter a length for 
the password: ", '')->{'result'};

my $title = "Options";
my $message = "Click on the button corresponding to your desired form of password";
$droid->dialogCreateAlert("$title", "$message");
$droid->dialogSetPositiveButtonText('Letters');
$droid->dialogSetNegativeButtonText('Numbers');
$droid->dialogShow();

my $choice = $droid->dialogGetResponse()->{'result'}->{'which'};

if ($choice eq "positive")
{
	letters($len);
}
else
{
	numbers($len);
}

sub letters {
	my $len = $_[0];
	my @letter = ("a" .. "z");
	my @lenA = (0 .. $len - 1);
	my $res = "";
	
	foreach my $pos (@lenA) {
		my $rand = int(rand(26));
		my $rlet = $letter[$rand];
		$res .= "$rlet";
	}
	
	$droid->makeToast("Your password is: $res");
	print "Your password is: $res";
}

sub numbers {
	my $len = $_[0];
	my @lenA = (0 .. $len - 1);
	my $res = "";
	
	foreach my $pos (@lenA) {
		my $rand = int(rand(10));
		$res .= "$rand";
	}
	
	$droid->makeToast("Your password is: $res");
	print "Your password is: $res";
}