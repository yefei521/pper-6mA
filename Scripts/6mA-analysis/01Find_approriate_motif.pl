#!/usr/bin/perl -w
#This script used for extract the coverage in the original result.
#Sheng ya lan 20180312
use strict;
my (@Result,$line,$coverage,$frac,$Qv,$number);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_appropriate");
{
		@Result= <IN1>;
		close IN1;
}
foreach $line(@Result){
		if ($line=~/m6A.+?coverage\=(\d+);.+?identificationQv\=(\d+?)\n/){
		        $coverage=$1;
                        $Qv=$2;
                        if($coverage>36 && $Qv>30){
                        	print OUT1"$line\n";
                                $number++;}
			}
                 else {print OUT1"$line";}
		}
print "$ARGV[0] cut-off: coverage>36, Qv>30, methylatied site number are $number\n";
