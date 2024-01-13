#!/usr/bin/perl -w
#This scripts used for analysis the 6mA sites around TSS.
#Usage: perl perl.pl T_thermophila_SB210_181_chromosomes_TSS_1kb_up m6A.bed
use strict;
my (@GFF,@bed,$sequence,$chr,$start,$anotation,$oritation,$TSS,$bin_size,%bin_number,@keys,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_bin_distribution");
{
		@GFF= <IN1>;
		close IN1;
		@bed= <IN2>;
		close IN2;
}
foreach $sequence(@bed){
     if($sequence=~/(tig.+?)\t(\d+?)\t(\d+?)\t.+?\n/){
		$chr=$1;
		$start=$2;
		foreach $anotation(@GFF){
			if ($anotation=~/$chr.+?gene\s+?(\d+)\s+?(\d+)\s+?(.+?)\s+?(.)/){
				$oritation=$4;
				if ($oritation eq "+"){$TSS=$1;$bin_size=$start-$TSS;if($bin_size<2001 && $bin_size>-500){$bin_number{$bin_size}++;}}
				elsif ($oritation eq "-"){$TSS=$2;$bin_size=$TSS-$start;if($bin_size<2001 && $bin_size>-500){$bin_number{$bin_size}++;}}
				}
			}		
	}
}
@keys= sort {$a <=> $b}  keys(%bin_number);
foreach $_(0 .. 2500){
		$n=$_-500;
		if (exists $bin_number{$n}){
			print OUT1"$n\t$bin_number{$n}\n";}
		else {print OUT1"$n\t0\n";}
		$_++;
	}
