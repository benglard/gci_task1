use Android;

my $droid = Android->new();

#purpose of program
$droid->makeToast('This program computes the real solutions to a quadratic equation'.);

# get values for a, b, and c
#	which correspond to the coefficients of the 
#	quadratic equation.

$a = $droid->dialogGetInput("Value for A", "Please enter a value for A:",
'');
$a = $a->{'result'};
$b = $droid->dialogGetInput("Value for B", "Please enter a value for B:",
'');
$b = $b->{'result'};
$c = $droid->dialogGetInput("Value for C", "Please enter a value for C:",
'');
$c = $c->{'result'};

 
# Below is the algorithm for finding real solutions.


if ($a == 0) 
{
	if ($b == 0)
	{
		if ($c != 0) {
			$droid->makeToast('No solution');
		}
		else {
			$droid->makeToast('All Real Numbers');
		}
	}
	else {
		$x = -1 * ($c/$b);
		$droid->makeToast("The equation is linear and its solution is $x");
	}
}
else {
	$rad = ($b*$b) - (4*$a*$c);
	
	if ($rad<0) {
		$droid->makeToast('There are no real solutions');
	}
	elsif ($rad == 0) {
		$x = (-1) * ($b/(2*$a));
		$droid->makeToast("One Solution: $x");
	}
	else {
		$s = sqrt($rad);
		$x1 = ((-1*$b) + $s)/(2*$a);
		$x2 = ((-1*$b) + $s)/(2*$a);
		$droid->makeToast("There are two solutions and they are: $x1 and $x2");
	}
}
