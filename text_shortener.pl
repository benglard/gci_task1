use Android;

my $droid = Android->new();

# purpose of program:
# shortens typical text messaging phrases
$droid->makeToast("This program shortens text using the SMS message style.");

my $input = $droid->dialogGetInput("Input Box", "Please enter a phrase: ",
'')->{'result'};

$orig_len = length $input;
$droid->makeToast("Original Message: $input");

$brb = "brb";
$k = "k";
$lol = "lol";
$l8r = "l8r";

#array of shortened words
@new = ($brb, $k, $lol, $l8r);

$brb_full = "be right back";
$ok = "ok";
$lol_full = "laugh out loud";
$later = "later";

#array of normal length words
@full = ($brb_full, $ok, $lol_full, $later);

$pos_brb = index($input, $brb_full);
$pos_ok = index($input, $ok);
$pos_lol = index($input, $lol);
$pos_later = index($input, $later);

#array of positions
@pos = ($pos_brb, $pos_ok, $pos_lol, $pos_later);

$counter = 0;

foreach my $p (@pos) 
{
	if ($p != -1) 
	{
		$len = length $full[$counter];
		$rep = $new[$counter];
		print "$len, $rep\n";
		$test = substr($input, $p, $len, $rep);
		$input = substr($input, $p, $len, $rep);
	}
	$counter++;
}

$new_len = length $input;

#Output
$droid->makeToast("Length of message was reduced from $orig_len to $new_len");
$droid->makeToast("New Message: $input");