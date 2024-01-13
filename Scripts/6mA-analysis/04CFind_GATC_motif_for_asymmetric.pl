#!/usr/bin/perl -w
#This script used for find the motif for the symmetric result.
#Such as: GATC CATC GATG
#Sheng ya lan 20180315
use strict;
my (@Result,$GATC,$CATC,$GATG,$line);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_GATC");
open (OUT2, ">", "$ARGV[0]_GATG");
open (OUT3, ">", "$ARGV[0]_CATC");
{
		@Result= <IN1>;
		close IN1;
}
foreach $line(@Result){
			if ($line=~/context\=\w{19,19}GATC\w{18,18}\;/){
			print OUT1"$line";
			$GATC++;
			} elsif ($line=~/context\=\w{19,19}GATG\w{18,18}\;/){
			print OUT2"$line";
			$GATG++;
			} elsif ($line=~/context\=\w{19,19}CATC\w{18,18}\;/){
			print OUT3"$line";
			$CATC++;
			}  
		}
print "GATC number:$GATC\n";
print "GATG number:$GATG\n";
print "CATC number:$CATC\n";
