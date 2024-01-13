#!/usr/bin/perl -w
#This scripts used for analysis the footprint (MNase dyad ± 75bp) in the genome,compare with genes. (occupy statistics)
#Usage: perl 20AComposite_analyse_dyad.pl mRNA_well_modeled_Jie_1kb_up.gff3 MNase.bed
use strict;
my (@GFF,@bed,$anotation,$chr,$start,$end,$length,$five,$three,$bin_start,$bin_end,@temp,@keys,$sequence,$gene_length,$test,$temp,$ori,%bin_number,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_footprint_bin_distribution");

{
		@GFF= <IN1>;
		close IN1;
		@bed= <IN2>;
		close IN2;
}
foreach $sequence(@bed){
		$sequence=~/(tig.+?)\s+(\d+?)\s+(\d+?)\s+?/;
		$chr=$1;
		$start=($2+$3)/2-75;
		$end=($2+$3)/2+75;
		$test=0;
		foreach $anotation(@GFF){
			$temp=$test;
			if($anotation=~/($chr)\s+.+?\s+(\d+?)\s+(\d+?)\s+(.)\s+(.)\s.+?\n/){
				$ori=$5;
				if ($ori eq "+"){
					$five=$2-2001;
					$three=$2+2001;
					if ($start > $five && $end < $three){
						$test++;
						$bin_start=$start-$five;
						$bin_end=$end-$five;
						foreach $_($bin_start .. $bin_end){
							$bin_number{$_}++;
							$_++;
							}
						}
					elsif ($start > $five && $start< $three && $end > $three){
						$test++;
						$bin_start=$start-$five;
						$bin_end=$three-$five;
						foreach $_($bin_start .. $bin_end){
							$bin_number{$_}++;
							$_++;
							}
						}
					elsif ($start < $five && $end > $five &&  $end < $three){
						$test++;
						$bin_start=$five-$five;
						$bin_end=$end-$five;
						foreach $_($bin_start .. $bin_end){
							$bin_number{$_}++;
							$_++;
							}
						}
					}
				elsif($ori eq "-"){
					$five=$3+2001;
					$three=$3-2001;
					if ($start> $three && $end<$five){
						$test++;
						$bin_start=$five-$end;
						$bin_end=$five-$start;
						foreach $_($bin_start .. $bin_end){
							$bin_number{$_}++;
							$_++;
							}
						}
					elsif ($start< $three && $end > $three && $end<$five){
						$test++;
						$bin_start=$five-$end;
						$bin_end=$five-$three;
						foreach $_($bin_start .. $bin_end){
							$bin_number{$_}++;
							$_++;
							}
						}
					elsif ($start> $three && $start < $five && $end>$five){
						$test++;
						$bin_start=$five-$five;
						$bin_end=$five-$start;
						foreach $_($bin_start .. $bin_end){
							$bin_number{$_}++;
							$_++;
							}
						}
					}
				}
			if ($test>0 && $test == $temp){last;}
		}
	}

@keys= sort {$a <=> $b}  keys(%bin_number);
foreach $_(0 .. 4000){
		$n=$_-2000;
		if (exists $bin_number{$_}){
			print OUT1"$n\t$bin_number{$_}\n";}
		else {print OUT1"$n\t0\n";}
		$_++;
	}
