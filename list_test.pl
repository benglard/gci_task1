use Android;

my $droid = Android->new();
$droid->dialogCreateAlert("Options", "Click the option you would like to select.");
$droid->dialogSetPositiveButtonText('Text');
$droid->dialogSetNegativeButtonText('Email');
$droid->dialogShow();

my $choice = $droid->dialogGetResponse()->{'result'}->{'which'};

print "$choice";

# This program was created for testing. 
