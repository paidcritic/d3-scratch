#!/usr/bin/perl -w

use warnings;
use strict;

use DateTime;

main(@ARGV);
my $et = ();            # script timer variable

my $mytime = ();
my $out = ();
my @in = ();
my $header = ();

my $dt = ();
my $epoch = ();
my $hms = ();


sub main
{
    start_timer($et);
    
    # file handles
    open(MAIN, "<$ARGV[0]") or die $!;	
    ## open(MAIN, "<test600-3col.txt") or die "cannot open test600 $! \n";	
	
    my $name = $ARGV[0];
    ## my $name = "test600-3col.txt";
    $name =~ s{\.[^.]+$}{};	
    $out = $name . "-time.txt";
    print "output filename is  ", $out, "\n";

    open(OUT, ">$out") or die $!; 			# output is input .time.txt

    # write out header line
    my $header = <MAIN>;
    chomp $header;
    print OUT $header, "\n";

    # process time variable in file
    while (<MAIN>) {
	   ## Handle dos & unix EOL
        s/\r?\n?$//;
    
	   my @line = split("\t", $_);
	   # split col0 to pull off the microseconds
	   my $temp = $line[0];
	   @in = split('\.', "$line[0]");       # need "\." instead of just "." in split; odd
   
	   # convert epoch to $epoch
	   getepoch($in[0]);
	   # append microsecond part
	   $line[0] = $mytime .".". $in[1];

	   # and write back into file
	   print OUT join("\t", @line, "\n");
        #	print "new time variable is  ", join("\t", @line), "\n";
    }
    end_timer($et);
}   # end MAIN

sub getepoch
{
    $dt 	= DateTime->from_epoch( epoch => $in[0] );
    # print " input value is $dt \n\n";

    # use DateTime in this subroutine;
    # $year   = $dt->year;
    # $month  = $dt->month; 			# 1-12 - you can also use '$dt->mon'
    # $day    = $dt->day; 			# 1-31 - also 'day_of_month', 'mday'
    # $dow    = $dt->day_of_week; 	# 1-7 (Monday is 1) - also 'dow', 'wday'
    # $hour   = $dt->hour; 			# 0-23
    # $minute = $dt->minute; 			# 0-59 - also 'min'
    # $second = $dt->second; 			# 0-61 (leap seconds!) - also 'sec'
    # $doy    = $dt->day_of_year; 	# 1-366 (leap years) - also 'doy'
    # $doq    = $dt->day_of_quarter; 	# 1.. - also 'doq'
    # $qtr    = $dt->quarter; 		# 1-4
    # $ymd    = $dt->ymd; 			# 1974-11-30
    ##$ymd    = $dt->ymd('/'); 		# 1974/11/30 - also 'date'
    $hms    = $dt->hms; 			# 13:30:00
    ##$hms    = $dt->hms('|'); 		# 13|30|00 - also 'time'

    # save only HH:MM:SS
    $mytime = $hms;
    # print "my time is: $mytime \n";
    return $mytime;
} # end getepoch


### template subroutines here ################################
sub start_timer
{
## start timers
print "Start: ", time(), "\n";
$et = time();
return $et;
}

sub end_timer
{
## print elapsed time
print "\nFinished: ", time(), "\n";
$et = time() - $et;
print "elapsed time: $et\n";
}

