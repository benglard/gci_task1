# This program was created for testing. 

use Android;
use strict;
use warnings;

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

