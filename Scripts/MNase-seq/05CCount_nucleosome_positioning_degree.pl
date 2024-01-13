#!/usr/bin/perl -w
#This script used for count the Nucelsome positioning degree
#Sheng ya lan 20190112
#Usage: perl 1CCount_nucleosome_positioning_degree.pl SB210_MNase.bed_degree_dyad SB210_MNase.bed_degree_footprint
use strict;
my (@dyad,@footprint,$name,$dyad_number,$footprint_number,%degree,$sequence,$footprint_name);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_positioning");
{
		@dyad= <IN1>;
		close IN1;
}
{
		@footprint= <IN2>;
		close IN2;
}
print OUT1"chrosome name\tmid location\tdegree of positioning\n";
foreach $_(@dyad){
	if($_=~/(tig.+?)\s+(.+?)\s+(\d+?)\s/){
	$name="$1\t$2";
	$dyad_number=$3;
	$degree{$name}=$dyad_number;}
	}
foreach $sequence(@footprint){
		if($sequence=~/(tig.+?)\s+(.+?)\s+(\d+?)\s/){
		$footprint_name="$1\t$2";
		$footprint_number=$3;
		if (exists ($degree{$footprint_name})){$degree{$footprint_name}=$degree{$footprint_name}/$footprint_number;print OUT1"$footprint_name\t$degree{$footprint_name}\n";}
		}
		}
