#!/usr/bin/perl -w
#This script used for select sequence for weblogo
#Sheng ya lan 20181003
use strict;
my (@Result,$line,$scf,$location,$sequence);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_sequence_5");
{
		@Result= <IN1>;
		close IN1;
}

foreach $line(@Result){	
	if ($line=~/(tig.+?)\s.+?\tm6A\t(\d+)\t.+?context\=\w{15,15}(\w+)\w{15,15}\;/){
				$scf=$1;
				$location=$2;
				$sequence=$3;
				print OUT1">$scf\t$location\n$sequence\n";
			}
			}
