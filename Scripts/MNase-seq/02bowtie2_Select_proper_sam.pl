#!/usr/bin/perl -w
#This script used for select the suitable sam result for future analysis. 
#Including Fragment size 120~260 if this sam file made from bowtie2,"AS:i:" mean the unique mapped reads.
#Sheng ya lan 20190120
use strict;
my (@Result,$line,$n,$length);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_120_260");
{
		@Result= <IN1>;
		close IN1;
}
$n=0;
foreach $line(@Result){
		$n++;
		if ($line=~/^@.+?\n/){
			print OUT1"$line";
				}
		if ($line=~/(\d+?)M\t(\=)\t(.+?)\t(.+?)\t.+?AS\:i\s/){
			$length=$4;
			if ($length<260 && $length>120){
			print OUT1"$line";
				}}
		}
print "$n\n";
