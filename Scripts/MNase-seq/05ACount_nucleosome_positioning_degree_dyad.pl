#!/usr/bin/perl -w
#This scripts used for count the positioning degree of Nucleosome dyad.
#Usage: perl Count_nucleosome_positioning_degree.pl MNase_called.bed MNase_zheng.sam
use strict;
my (@bed,@sam,$sequence,$chr,$mid,$mid_bed,$n,$degree,%sam,%bed,$name,$name1,$name2,$location1,$location2,$keys,$bed_name);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_degree_dyad");
{
		@bed= <IN1>;
		close IN1;
		@sam= <IN2>;
		close IN2;
}
#tig00000011_pilon_pilon_veg_pilon       544     50      131M    =       588     176     GATTCAATATTAAA
foreach(@sam){
		if($_=~/(tig.+?)\s+(\d+?)\s.+?=\s+(.+?)\s+(\d+?)\s+(\w+)/){
		$mid=$2+int($4/2);
		$name="$1\t$mid";
		$sam{$name}=0;
	}
}
foreach $n(0 ... 20){
		  foreach$sequence (@bed){
			$sequence=~/(tig.+?)\s+(\d+?)\s+(\d+?)\s+/;
			$chr=$1;
			$mid_bed=int(($2+$3)/2);
			$location1=$mid_bed-$n;
			$location2=$mid_bed+$n;
			$name1="$chr\t$location1";
			$name2="$chr\t$location2";
			$bed_name="$chr\t$mid_bed";
			if (exists ($sam{$name1})){$bed{$bed_name}++;}
			elsif(exists ($sam{$name2})){$bed{$bed_name}++;}
			}
		$n=$n+1;
		}
print OUT1"chrosome name\tNucleosome mid\tfragment number in ±20 dyad\n";
foreach $keys (keys %bed){
		print OUT1 "$keys\t$bed{$keys}\n";
}
