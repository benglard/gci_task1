use Android;
use strict;
use warnings;

=pod

-This script allows users to enter grades with their corresponding weights, and computes the
average. It also turns the average into an alphabetical grade (ex. "A" if average > 90). The code 
also allows users to text the calculated average to a friend.
-Android functionality used includes:
	a. Creating alert pop-ups to notify users of important usage information
	b. Getting user input through an input dialog
	c. Pop-up dialogs displaying results
	d. Asking user whether they would like to text their average, determining user's choice,
	   prompting user for phone number if user chooses to text, sending SMS message to provided
	   phone number
	   
=cut

my $droid-> = Android->new();

#purpose of program
$droid->makeToast("This program allows users to enter grades and their corresponding weights,
and then calculates an average.");

#Usage alerts
sub alert {
	my $title = "Alert 1";
	my $message = "Usage:\n Enter a grade comma space wieght";
	$droid->dialogCreateAlert("$title", "$message");
	$droid->dialogSetPositiveButtonText('Confirm');
	$droid->dialogShow();
	sleep(5);
	
	$title = "Alert 2";
	$message = "Usage:\n Enter q to stop entering grades";
	$droid->dialogCreateAlert("$title", "$message");
	$droid->dialogSetPositiveButtonText('Confirm');
	$droid->dialogShow();
	return $droid->dialogGetResponse()->{'result'}->{'which'};
}

my @grades = ();
my @weights = ();

alert();
my $input = getInput();

while ($input ne "q")
{
	my $in = "$input";
	my $posC = index($in, ',');
	
	my $grade = substr($in, 0, $posC);
	print "$grade ";
	
	my $weight = substr($in, $posC+2);
	print "$weight\n";
	
	enterGrade($grade, $weight);
	
	$input = getInput();
}

output();

sub output {
	my $avg = average();
	my $ret = "Your average is:\n$avg";
	$droid->makeToast("$ret");
	print "$ret";
	
	my $title = "Text Average";
	my $message = "Would you like to text your average to a friend?";
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
}

sub textGrade {
	my $message = $_[0];
	my $num = $droid->dialogGetInput("Number to Text", "Please enter a number
	to text: ", '')->{'result'};
	
	if ($num ne "") 
	{
		$droid->smsSend($num, $message);
	}
}

sub getInput {
	my $input = $droid->dialogGetInput("Input Box", "Enter a grade, weight: ", 
	'')->{'result'};
	return $input;
}

#put user's input into proper arrays
sub enterGrade {
	my $grade = $_[0];
	my $weight = $_[1];
	
	push(@grades, $grade);
	push(@weights, $weight);
}

sub sumGrades {
	my $sum = 0;
	my $counter = 0;
	
	foreach my $grade (@grades) {
		$sum += ($grade * $weights[$counter]);
		$counter++;
	}
	
	return $sum;
}

sub sumWeights {
	my $sum = 0;
	
	foreach my $weight (@weights) {
		$sum += $weight;
	}
	
	return $sum;
}

#Calculates average, returns numerical and alphabetical grade
sub average {
	my $ret = "";
	my $sumG = sumGrades();
	my $sumW = sumWeights();
	print "$sumG, $sumW\n";
	
	my $avg = int($sumG/$sumW);
	$ret .= "$avg, ";
	my $grade = "";
	
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