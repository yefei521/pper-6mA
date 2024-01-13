#!/usr/bin/perl -w
#This scripts used for seperate nucleosome into kinds:+1 +2 +3 +4
#Usage: perl Seperate_Nucleosome_into_kinds.pl mRNA_well_modeled_Jie_1kb_up.gff3 MNase.bed
use strict;
my (@GFF,@bed,$anotation,$chr,$start,$end,$length,$five,$three,$bin_start,$bin_end,@temp,@keys,$sequence,$gene_length,$test,$temp,$ori,%bin_number,$n,$mid,$distance);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_+1_0_243.bed");
open (OUT2, ">", "$ARGV[1]_+2_244_446.bed");
open (OUT3, ">", "$ARGV[1]_+3_447_624.bed");
open (OUT4, ">", "$ARGV[1]_+4_625_876.bed");
open (OUT5, ">", "$ARGV[1]_+5_877_1051.bed");
{
		@GFF= <IN1>;
		close IN1;
		@bed= <IN2>;
		close IN2;
}
foreach $sequence(@bed){
		$sequence=~/(tig.+?)\s+(\d+?)\s+(\d+?)\s.+?\n/;
		$chr=$1;
		$mid=($2+$3)/2;
		$test=0;
		foreach $anotation(@GFF){
			$temp=$test;
			if($anotation=~/($chr)\s.+?\s+(\d+?)\s+(\d+?)\s+(.+?)\s+(.)\s.+?\n/){
				$ori=$5;
				$distance=0;
				if ($ori eq "+" && $mid>$2){
					$distance=$mid-$2;}
				elsif ($ori eq "-" && $mid<$3){
					$distance=$3-$mid;}
				if ( $distance ==0){}else{
						if ( $distance > 0 && $distance < 244){
							print OUT1"$sequence";
							$test++;
							}
						elsif ( $distance > 243 && $distance < 447){
							print OUT2"$sequence";
							$test++;
							}
						elsif ( $distance > 446 && $distance < 625){
							print OUT3"$sequence";
							$test++;
							}
						elsif ( $distance > 624 && $distance < 877){
							print OUT4"$sequence";
							$test++;
							}
						elsif ($distance > 876 && $distance < 1052){
							print OUT5"$sequence";
							$test++;
							}
						}
					}
			if ($test>0 && $test == $temp){last;}
		}
         }






