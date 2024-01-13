#!/usr/bin/perl -w
#This script used for find the motif for the modification result.
#Such as: GATC CATC GATG
#Sheng ya lan 20180315
#for GATC, foward and reverse are the same, total number is enough.
use strict;
my (@Result,$GATC,$CATC_foward,$CATC_reverse,$GATG_foward,$GATG_reverse,$line);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_GATC");
open (OUT2, ">", "$ARGV[0]_CATC");
open (OUT3, ">", "$ARGV[0]_GATG");
{
		@Result= <IN1>;
		close IN1;
}
foreach $line(@Result){
			if ($line=~/context=\w{19,19}GATC\w{18,18}\;/){
			print OUT1"$line";
			$GATC++;
			} elsif($line=~/(\+)\t.\s.+?context=\w{19,19}CATC\w{18,18}\;/){
			print OUT2"$line";
			$CATC_foward++;
			}elsif($line=~/(\-)\t.\s.+?context=\w{19,19}CATC\w{18,18}\;/){
			print OUT2"$line";
			$CATC_reverse++;
			}elsif($line=~/(\+)\t.+?context=\w{19,19}GATG\w{18,18}\;/){
			print OUT3"$line";
			$GATG_foward++;
			}elsif($line=~/(\-)\t.\t.+?context=\w{19,19}GATG\w{18,18}\;/){
			print OUT3"$line";
			$GATG_reverse++;
			}
		}
print "GATC number:$GATC\nGATG number:$GATG_foward\treverse:$GATG_reverse\nCATC number: $CATC_foward\treverse:$CATC_reverse\n";
