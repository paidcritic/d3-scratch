#!/usr/bin/perl -w

use strict; 
use warnings;

my $last = '';
open (OUT, ">scatch.txt") or die "cannot open scratch $! \n";
while(<>)
{
   my @columns = split; 
   next if $columns[0] eq $last;
   $last = $columns[0];
   print OUT join("\t", @columns[0..2]), "\n";
}


#If the duplicate records don't necessarily follow each other, then use a hash to determine which ones you've already seen.
#use strict; use warnings;
#my %seen;
#while (<>)
#{
#   my @columns = split;
#   next if exists $seen{$columns[0]};
#   $seen{$columns[0]} = 1;
#   print;
#}