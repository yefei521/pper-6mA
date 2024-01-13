#!/usr/bin/perl -w
#This scripts used for analysis the 6mA sites around TSS.
#Usage: perl 20BComposite_analyse.pl mRNA_well_modeled_Jie_1kb_up.gff3 m6A.gff
use strict;
my (@GFF,@m6A,$sequence,$chr,$start,$anotation,$oritation,$TSS,$bin_size,%bin_number,@keys,$n,$level);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_bin_distribution");
{
		@GFF= <IN1>;
		close IN1;
		@m6A= <IN2>;
		close IN2;
}
foreach $sequence(@m6A){
   if($sequence=~/(tig.+?)\t.+?m6A\t(\d+?)\t.+?frac=(.+?);.+?\n/){
		$chr=$1;
		$start=$2;
		$level=$3;
		foreach $anotation(@GFF){
			if ($anotation=~/$chr.+?gene\s+?(\d+)\s+?(\d+)\s+?(.+?)\s+?(.)\s/){
				$oritation=$4;
				if ($oritation eq "+"){$TSS=$1;$bin_size=$start-$TSS;if($bin_size<2001 && $bin_size>-2001){$bin_number{$bin_size}=$bin_number{$bin_size}+$level;}}
				elsif ($oritation eq "-"){$TSS=$2;$bin_size=$TSS-$start;if($bin_size<2001 && $bin_size>-2001){$bin_number{$bin_size}=$bin_number{$bin_size}+$level;}}
				}
			}
			
	}
}
@keys= sort {$a <=> $b}  keys(%bin_number);
foreach $_(0 .. 4000){
		$n=$_-2000;
		if (exists $bin_number{$n}){
			print OUT1"$n\t$bin_number{$n}\n";}
		else {print OUT1"$n\t0\n";}
		$_++;
	}
