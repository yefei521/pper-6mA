#!/usr/bin/perl -w
#This script used for count the length for fragment in sam.
use strict;
my (@sam,$length,$squence,%hash,$keys);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_length");
{
		@sam= <IN1>;
		close IN1;
}
foreach $squence(@sam){
		if ($squence=~ /(\d+?)M\t(.)\t(\d+?)\t(.+?)\t/){
				if ($2 eq "="  && $4 > 0){
				$length=$4;;
				$hash{$length}++;
				}
			}
		}

foreach $keys (sort {$a <=> $b} keys %hash){
		print OUT1"$keys\t$hash{$keys}\n";
		}
