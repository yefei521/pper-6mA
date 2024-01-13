#!/usr/bin/perl -w
#This script used for analysis the 6mA location in the genome.
#Sheng ya lan 20180315
#perl perl.pl T_thermophila_SB210_181chr.gff3_gene 6mA.bed
use strict;
my (@Annotation,@Result,@Gene,$line,$scf,$start,$begin,$end,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_Genic");
#open (OUT2, ">", "$ARGV[0]_Gene");
{
		@Gene= <IN1>;
		close IN1;
		@Result= <IN2>;
		close IN2;
}
#foreach $_(@Annotation){
#	if($_=~ /(chr_\d+)\t\w+\t(gene)\t(\d+?)\t(\d+?)\t(.)\t/){push @Gene,$_;}
#	}
foreach $line(@Result){
	if($line=~/(tig.+?)\t(\d+?)\t(\d+?)\t/){
			$scf=$1;
			$start=$2;
			foreach $_(@Gene){
				if( $_=~ /$scf\t\w+\t(gene)\t(\d+?)\t(\d+?)\t(.)\t/){
					$begin=$2;
					$end=$3;
					if($begin<=$start && $start<=$end){
					print OUT1"$line";
					$n++;
					last;
					}
				}
			}
		}
}
print "Located in Gene zone number:$n";
#print OUT2"@Gene\n";
