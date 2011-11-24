use Android;

my $droid = Android->new();

#purpose of program
$droid->makeToast('This program provides information on the battery.');

#first three battery info options
$title = "Options";
$message = "Click on the button which corresponds to the information you would like to know.");
$droid->dialogCreateAlert("$title", "$message");
$droid->dialogSetPositiveButtonText('Health');
$droid->dialogSetNegativeButtonText('Level');
$droid->dialogSetNeutralButtonText('Plug Type');
$droid->dialogShow();

my $choice = $droid->dialogGetResponse()->{'result'}->{'which'};

if ($choice eq "positive")
{
	health();
}
elsif ($choice eq "negative")
{
	level();
}
else 
{
	plug();
}

#second three battery info options
$droid->dialogCreateAlert("$title", "$message");
$droid->dialogSetPositiveButtonText('Status');
$droid->dialogSetNegativeButtonText('Temperature');
$droid->dialogSetNeutralButtonText('Voltage');
$droid->dialogShow();

$choice = $droid->dialogGetResponse()->{'result'}->{'which'};

if ($choice eq "positive")
{
	status();
}
elsif ($choice eq "negative")
{
	temp();
}
else 
{
	voltage();
}

sub health {
	$res = $droid->batteryGetHealth();
	$res = $res->{'result'};
	$droid->makeToast("Battery Health: $res");
}

sub level {
	$res = $droid->batteryGetLevel();
	$res = $res->{'result'};
	$droid->makeToast("Battery Level: $res");
}

sub plug {
	$res = $droid->batteryGetPlugType();
	$res = $res->{'result'};
	$droid->makeToast("Battery Plug Type: $res");
}

sub stauts {
	$res = $droid->batteryGetStatus();
	$res = $res->{'result'};
	$droid->makeToast("Battery Status: $res");
}

sub temp {
	$res = $droid->batteryGetTemperature();
	$res = $res->{'result'};
	$droid->makeToast("Battery Temperature: $res");
}

sub voltage {
	$res = $droid->batteryGetVoltage();
	$res = $res->{'result'};
	$droid->makeToast("Battery Voltage: $res");
}

#Note: this was somewhat hard to test on the Android Emulator, however,
#This should still work on an phone.