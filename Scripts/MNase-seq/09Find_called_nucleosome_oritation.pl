#!/usr/bin/perl -w
#This scripts used for find the oritation of nucleosome in the genome(after TSS)
#Usage: perl perl.pl MNase.bed mRNA.gff
use strict;
my (@MNase,@gff,$sequence,$chr,$start,$end,$anotation,$oritation,$mid);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_oritation");
{
		@MNase= <IN1>;
		close IN1;
		@gff= <IN2>;
		close IN2;
}
foreach $sequence(@MNase){
				$sequence=~/(tig.+?)\t(\d+?)\t(\d+?)\s/;
				$chr=$1;
				$mid=int($2+$3)/2;
				chomp($sequence);
				foreach $_(@gff){
					if($_=~/$chr\t.+?gene\t(\d+?)\t(\d+?)\t.+?\t(.)\t/){
						$start=$1;
						$end=$2;
						$oritation=$3;
						if ($mid > $start && $mid < $end){
							if ($oritation eq "+"){$anotation="zheng";}
							elsif($oritation eq "-"){$anotation="fu";}
							last;
						}else{next;}
						}
					}
				print OUT1"$sequence\t$anotation\n";
			}

