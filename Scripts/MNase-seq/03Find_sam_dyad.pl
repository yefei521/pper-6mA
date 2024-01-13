#!/usr/bin/perl -w
#This script used for find the dyad sam for nucleosome sam result.
#Sheng ya lan 20180315
#perl perl.pl  nucleosome.sam
use strict;
my (@sam,$line,$fasta,$quality,$length,@fasta,@quality,$mid,$begin,$end,$location,$dyad_location,$dyad_fasta,$dyad_quality);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_dyad");
{
		@sam= <IN1>;
		close IN1;
}

foreach $line(@sam){
			if($line=~/(.+?\t\d+?\t.+?\d+?)\t(\d+?)\t(.+?)\t(\d+?)M\t(.\t.+?)\t(.+?)\t(\w+)\t(.+?)\t(.+?)\n/){
			$location=$2;
			$fasta=$7;
			$quality=$8;
			$length=length($fasta);
			$mid=sprintf "%.f",$length/2;
			$mid=$mid+1;
			$begin=$mid-1;
			$end=$mid;
			$dyad_location=$location+int(abs($6)/2)-1;
			@fasta=split//,$fasta;
			@quality=split//,$quality;
			$dyad_fasta="";
			$dyad_quality="";
			foreach $_($begin-1 ... $end-1){
				$dyad_fasta=$dyad_fasta."$fasta[$_]";
				$dyad_quality=$dyad_quality."$quality[$_]";
				$_++;
				}
			print OUT1"$1\t$dyad_location\t$3\t2M\t$5\t2\t$dyad_fasta\t$dyad_quality\t$9\n";}
		else{print OUT1"$line";}
		}
