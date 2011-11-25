# This program was created for testing. 

use Android;
use strict;
use warnings;

=pod

-This script is as an example of creating alerts with buttons and determining 
the button the user clicked on. Since I recognized that several of the other scripts would 
include alerts with buttons, I wanted to make sure I determined the correct method of 
implementing those features, and I thus created this script as a test space.
-Android functionality used includes:
	a. Creating an alert message with buttons
	b. Determing the button the user clicks on, returning user's choice

=cut

my $droid = Android->new();
$droid->dialogCreateAlert("Options", "Click the option you would like to select.");
$droid->dialogSetPositiveButtonText('Text');
$droid->dialogSetNegativeButtonText('Email');
$droid->dialogShow();

my $choice = $droid->dialogGetResponse()->{'result'}->{'which'};

print "$choice";

if ($choice eq "positive") {
	$droid->makeToast("Choice was: text");
}
else {
	$droid->makeToast("Choice was: email");
}

