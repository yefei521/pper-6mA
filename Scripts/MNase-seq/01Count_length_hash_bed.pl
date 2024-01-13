#!/usr/bin/perl -w
#This script used for count the length for fragment in sam.
use strict;
my (@bed,$length,$squence,%hash,$keys);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "yf_$ARGV[0]_length");
{
		@bed= <IN1>;
		close IN1;
}
foreach $squence(@bed){
		if ($squence=~ /(scf_\d+?)\t(\d+)\t(\d+?)\t(.+?)\n/){
			
				$length=$3-$2+1;
				$hash{$length}++;
			
			}
		}

foreach $keys (sort {$a <=> $b} keys %hash){
		print OUT1"$keys\t$hash{$keys}\n";
		}
