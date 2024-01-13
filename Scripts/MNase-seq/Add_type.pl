#!/usr/bin/perl -w
#This script used for find the contaminated contigs for blast result.
#Sheng ya lan 20170925
use strict;
my (@list,@TPM,$sequence,$contig_length,$type);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_added");
{
		@list= <IN1>;
		close IN1;
}
print "Enter your type:\n";
$type= <STDIN>;
chomp($type);
foreach $sequence(@list){
		if ($sequence=~/(\d+?)\n/){
			chomp ($sequence);
			print OUT1"$sequence\t$type\n";
			}
		}
