use Android;
use strict;
use warnings;

=pod

-This script provides information and metrics on the battery of your Android device.
-Information/Metrics provided include: 
	a. battery health
	b. battery charge level (as a percent)
	c. battery plug information (unplugged? AC charger? USB?)
	d. battery status (charging? full? etc.)
	e. battery temperature
	f. battery voltage
-Android functionality used includes:
	a. Pop-up alerts with text
	b. Alerts created with a positive, negative, and neutral button where each buttton provides
	   a different piece of information on the battery (figuring out which button user clicks on).
	c. Generating battery 'events'
		=> Battery events include gathering data on the different metrics shown above

=cut

my $droid = Android->new();

#purpose of program
$droid->makeToast('This program provides information on the battery.');

#first three battery info options
my $title = "Options";
my $message = "Click on the button which corresponds to the information you would like to know.");
$droid->dialogCreateAlert("$title", "$message");
$droid->dialogSetPositiveButtonText('Health');
$droid->dialogSetNegativeButtonText('Level');
$droid->dialogSetNeutralButtonText('Plug Type');
$droid->dialogShow();

my $choice = $droid->dialogGetResponse()->{'result'}->{'which'};

$droid->batteryStopMonitoring();
$droid->makeToast("Gathering battery data...");
sleep(10);

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

$droid->batteryStopMonitoring();

sub health {
	my @health = qw(unknown good overheat dead over-voltage unspecified-failure);

	my $res = $droid->batteryGetHealth()->{'result'};
	$res = $health[$res-1];
	$droid->makeToast("Battery Health: $res");
}

sub level {
	my $res = $droid->batteryGetLevel()->{'result'};
	$droid->makeToast("Battery Level: $res%");
}

sub plug {
	my @plugs = qw(unplugged AC-charger USB-port);

	my $res = $droid->batteryGetPlugType()->{'result'};
	if ($res ne "-1") {
		$res = $plugs[$res];
	}
	else {
		$res = "unknown":
	}
	
	$droid->makeToast("Battery Plug Type: $res");
}

sub status {
	my @stats = qw(unknown charging discharging not-charging full);

	my $res = $droid->batteryGetStatus()->{'result'};
	$res = $stats[$res-1];
	$droid->makeToast("Battery Status: $res");
}

sub temp {
	my $res = $droid->batteryGetTemperature()>{'result'};
	$droid->makeToast("Battery Temperature: $res");
}

sub voltage {
	my $res = $droid->batteryGetVoltage()->{'result'};
	$droid->makeToast("Battery Voltage: $res");
}