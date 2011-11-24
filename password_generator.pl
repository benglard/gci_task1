use Android;

my $droid = Android->new();

# purpose of program
$droid->makeToast('This program generates a password of a given length');

$len = $droid->dialogGetInput("Length of Password", "Enter a length for 
the password: ", '')->{'result'};

$title = "Options";
$message = "Click on the button corresponding to your desired form of password";
$droid->dialogCreateAlert("$title", "$message");
$droid->dialogSetPositiveButtonText('Letters');
$droid->dialogSetNegativeButtonText('Numbers');
$droid->dialogShow();

$choice = $droid->dialogGetResponse()->{'result'}->{'which'};

if ($choice eq "positive")
{
	letters($len);
}
else
{
	numbers($len);
}

sub letters {
	$len = $_[0];
	@letter = ("a" .. "z");
	@lenA = (0 .. $len - 1);
	$res = "";
	
	foreach my $pos (@lenA) {
		$rand = int(rand(26));
		$rlet = $letter[$rand];
		$res .= "$rlet";
	}
	
	$droid->makeToast("Your password is: $res");
	print "Your password is: $res";
}

sub numbers {
	$len = $_[0];
	@lenA = (0 .. $len - 1);
	$res = "";
	
	foreach my $pos (@lenA) {
		$rand = int(rand(10));
		$res .= "$rand";
	}
	
	$droid->makeToast("Your password is: $res");
	print "Your password is: $res";
}