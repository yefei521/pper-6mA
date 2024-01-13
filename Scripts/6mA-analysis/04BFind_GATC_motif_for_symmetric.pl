#!/usr/bin/perl -w
#This script used for find the motif for the symmetric result.
#Such as: GATC CATC GATG
#Sheng ya lan 20180315
use strict;
my (@Result,$GATC,$CATC_zheng,$CATC_fan,$GATG_zheng,$GATG_fan,$line);
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
			if ($line=~/context=\w{19,19}GATC\w{18,18}\;/){
			print OUT1"$line";
			$GATC++;
			} elsif ($line=~/(\+)\t.+?context=\w{19,19}GATG\w{18,18}\;/){
			print OUT2"$line";
			$GATG_zheng++;
			} elsif ($line=~/(\-)\t.\t.+?context=\w{19,19}CATC\w{18,18}\;/){
			print OUT2"$line";
			$GATG_fan++;
			} elsif ($line=~/(\+)\t.\t.+?context=\w{19,19}CATC\w{18,18}\;/){
			print OUT3"$line";
			$CATC_zheng++;
			}  elsif ($line=~/(\-)\t.\t.+?context=\w{19,19}GATG\w{18,18}\;/){
			print OUT3"$line";
			$CATC_fan++;
			} 
		}
print "GATC number:$GATC\n";
print "GATG_zheng number:$GATG_zheng\tGATG_fan number:$GATG_fan\n";
print "CATC_zheng number:$CATC_zheng\tCATC_fan number:$CATC_fan\n";
