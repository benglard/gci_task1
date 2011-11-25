use Android;
use strict;
use warnings;

my $droid = Android->new();

# purpose of program:
# shortens typical text messaging phrases
$droid->makeToast("This program shortens text using the SMS message style.");

my $input = $droid->dialogGetInput("Input Box", "Please enter a phrase: ",
'')->{'result'};

my $orig_len = length $input;
$droid->makeToast("Original Message: $input");

my $brb = "brb";
my $k = "k";
my $lol = "lol";
my $l8r = "l8r";

#array of shortened words
my @new = ($brb, $k, $lol, $l8r);

my $brb_full = "be right back";
my $ok = "ok";
my $lol_full = "laugh out loud";
my $later = "later";

#array of normal length words
my @full = ($brb_full, $ok, $lol_full, $later);

my $pos_brb = index($input, $brb_full);
my $pos_ok = index($input, $ok);
my $pos_lol = index($input, $lol);
my $pos_later = index($input, $later);

#array of positions
my @pos = ($pos_brb, $pos_ok, $pos_lol, $pos_later);

my $counter = 0;

foreach my $p (@pos) 
{
	if ($p != -1) 
	{
		my $len = length $full[$counter];
		my $rep = $new[$counter];
		print "$len, $rep\n";
		my $test = substr($input, $p, $len, $rep);
		$input = substr($input, $p, $len, $rep);
	}
	$counter++;
}

my $new_len = length $input;

#Output
$droid->makeToast("Length of message was reduced from $orig_len to $new_len");
$droid->makeToast("New Message: $input");

my $ret = "$input";
my $title = "Text Message";
my $message = "Would you like to text your shortened message to a friend?";
$droid->dialogCreateAlert("$title", "$message");
$droid->dialogSetPositiveButtonText('Yes');
$droid->dialogSetNegativeButtonText('No');
$droid->dialogShow();
	
my $choice = $droid->dialogGetResponse()->{'result'}->{'which'};
	
if ($choice eq "positive")
{
	textGrade($ret);
}
else {;}

sub textGrade {
	my $message = $_[0];
	my $num = $droid->dialogGetInput("Number to Text", "Please enter a number
	to text: ", '')->{'result'};
	
	if ($num ne "") 
	{
		$droid->smsSend($num, $message);
	}
}
