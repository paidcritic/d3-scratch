#!/usr/bin/perl -w

# template by Tim Boeve
# 
#

use warnings;
use strict;
# use Text::CSV;


# declare global variables



main(@ARGV);
my $et = ();            # script timer variable

sub main
{
    start_timer($et);

	## Open files using handles
	my $in = $ARGV[0];
	my $name = $in;
	my $out = ();
	$name =~ s{\.[^.]+$}{};	
	$out = $name . "-3col.txt";

	open (IN, "<$in") or die "cannot open IN $! \n";
	open (OUT, ">$out") or die "cannot open OUT $! \n";
		# one liner might be perl -F/\\t/ -ane  'print join("\t", @F[0..66,68..$#F])'

	# process file
	while(<IN>) {
		chomp;
		my @fields = split ("\t", $_);
		print OUT join ("\t", @fields[0..2]), "\n";
	}

    end_timer($et);
}	# end main
	


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