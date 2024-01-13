#!/usr/bin/perl -w
#This script used for extract the coverage in the original result.
#Sheng ya lan 20180312
use strict;
my (@Result,$line,$coverage,$frac,$ori,$dir);
$dir=$ENV{'PWD'};
open (IN1, "<", "$dir/Veg_6mA_raw_Cv77-Qv30.gff")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "Veg_6mA_raw_Cv77-Qv30.gff_coverage");
{
		@Result= <IN1>;
		close IN1;
}
foreach $line(@Result){
		if ($line=~/m6A\s+\d+\s+\d+\s+\d+\s+(.)\s+.+?coverage\=(\d+);/){
			$coverage=$2; $ori=$1; 
			print OUT1"$ori\t$coverage\n";
			}
		}
