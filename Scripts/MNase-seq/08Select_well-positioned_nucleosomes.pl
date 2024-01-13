#!/usr/bin/perl -w
#This scripts used for select the well-positioned nucleosomes.
#Usage: perl perl.pl MNase_called.bed MNase_called.bed.positioning
use strict;
my (@bed,@positioning,%positioning,$sequence,$chr,$mid,$name,$name1,$cut_off);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN1 : $!";
{
		@bed= <IN1>;
		close IN1;
}
{
		@positioning= <IN2>;
		close IN2;
}
print "Enter your select degree:\n";
#$cut_off= <STDIN>;
#chomp($cut_off);
$cut_off="0.6";
foreach $_(@positioning){
		if($_=~/(tig.+?)\s+(.+?)\s+(.+?)\s/){
			if ($3 >= $cut_off){
			$name="$1\t$2";
			$positioning{$name}=0;
			}
		}
	}

open (OUT1, ">", "$ARGV[0]_$cut_off");
foreach $sequence (@bed){
			if($sequence=~/(tig.+?)\s+(\d+?)\s+(\d+?)\s/){
			$chr=$1;
			$mid=int(($2+$3)/2);
			$name1="$chr\t$mid";
			if (exists ($positioning{$name1})){print OUT1"$sequence";}
		}
 }
