#!/usr/bin/perl -w
#This scripts used for count the positioning in bin size.
#Usage: perl perl.pl MNase.positioning
use strict;
my (@positioning,$sequence,$number,$n,$start,$end,%bin_number,@keys);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_bin_distribution");
{
		@positioning= <IN1>;
		close IN1;
}
foreach $sequence(@positioning){
		if($sequence=~/(tig.+?)\s+(.+?)\s+(.+?)\s/){
		$number=$3;
		foreach $n(0 .. 9){
			$start=$n*0.1;
			$end=$start+0.1;
			if ($number >= $start && $number<$end){
				$bin_number{$n}++;
				}
			$n++;
			}
	}}

@keys= sort {$a <=> $b}  keys(%bin_number);
foreach $_(@keys){
		if (exists $bin_number{$_}){
			print OUT1"$_\t$bin_number{$_}\n";}
		else {print OUT1"$_\t0\n";}
		$_++;
	}
