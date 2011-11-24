use Android;
my $droid-> = Android->new();

#purpose of program
$droid->makeToast("This program allows users to enter grades and their corresponding weights,
and then calculates an average.");

#Usage alerts
sub alert {
	$title = "Alert 1";
	$message = "Usage:\n Enter a grade comma space wieght";
	$droid->dialogCreateAlert("$title", "$message");
	$droid->dialogSetPositiveButtonText('Confirm');
	$droid->dialogShow();
	sleep(10);
	
	$title = "Alert 2";
	$message = "Usage:\n Enter q to stop entering grades";
	$droid->dialogCreateAlert("$title", "$message");
	$droid->dialogSetPositiveButtonText('Confirm');
	$droid->dialogShow();
	return $droid->dialogGetResponse()->{'result'}->{'which'};
}

@grades = ();
@weights = ();

alert();
$input = getInput();

while ($input ne "q")
{
	$in = "$input";
	$posC = index($in, ',');
	
	$grade = substr($in, 0, $posC);
	print "$grade ";
	
	$weight = substr($in, $posC+2);
	print "$weight\n";
	
	enterGrade($grade, $weight);
	
	$input = getInput();
}

output();

sub output {
	$avg = average();
	$ret = "Your average is:\n$avg";
	$droid->makeToast("$ret");
	print "$ret";
	
	$title = "Text Average";
	$message = "Would you like to text your average to a friend?";
	$droid->dialogCreateAlert("$title", "$message");
	$droid->dialogSetPositiveButtonText('Yes');
	$droid->dialogSetNegativeButtonText('No');
	$droid->dialogShow();
	
	$choice = $droid->dialogGetResponse()->{'result'}->{'which'};
	
	if ($choice eq "positive")
	{
		textGrade($ret);
	}
	else {;}
}

sub textGrade {
	$message = $_[0];
	$num = $droid->dialogGetInput("Number to Text", "Please enter a number
	to text: ", '')->{'result'};
	
	if ($num ne "") 
	{
		$droid->smsSend($num, $message);
	}
}

sub getInput {
	$input = $droid->dialogGetInput("Input Box", "Enter a grade, weight: ", 
	'')->{'result'};
	return $input;
}

#put user's input into proper arrays
sub enterGrade {
	$grade = $_[0];
	$weight = $_[1];
	
	push(@grades, $grade);
	push(@weights, $weight);
}

sub sumGrades {
	$sum = 0;
	$counter = 0;
	
	foreach my $grade (@grades) {
		$sum += ($grade * $weights[$counter]);
		$counter++;
	}
	
	return $sum;
}

sub sumWeights {
	$sum = 0;
	
	foreach my $weight (@weights) {
		$sum += $weight;
	}
	
	return $sum;
}

#Calculates average, returns numerical and alphabetical grade
sub average {
	$ret = "";
	$sumG = sumGrades();
	$sumW = sumWeights();
	print "$sumG, $sumW\n";
	
	$avg = int($sumG/$sumW);
	$ret .= "$avg, ";
	$grade = "";
	
	if ($avg >= 90) {
		$grade = "A";
	}
	elsif ($avg >= 80 && $avg < 90) {
		$grade = "B";
	}
	elsif ($avg >= 70 && $avg < 80) {
		$grade = "C";
	}
	elsif ($avg >= 60 && $avg < 70) {
		$grade = "D";
	}
	else {
		$grade = "F"
	}
	
	$ret .= "$grade";
	return $ret;
}