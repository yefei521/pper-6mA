#!/usr/bin/perl -w
#This scripts used for analysis the 6mA sites around nucleosome dyad (considering the oritation of mRNA )
#Usage: perl perl.pl MNase.bed m6A.bed
use strict;
my (@MNase,@bed,$sequence,$chr,$start,$anotation,$oritation,$TSS,$bin_size,%bin_number,@keys,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_$ARGV[1]_bin_distribution");
{
		@MNase= <IN1>;
		close IN1;
		@bed= <IN2>;
		close IN2;
}
foreach $sequence(@bed){
		$sequence=~/(chr_\d+)\t(\d+?)\t(\d+?)\t.+?\n/;
		$chr=$1;
		$start=$2;
		foreach $anotation(@MNase){
		#	if ($anotation=~/$chr\t(\d+?)\t(\d+?)\t.+?\t50\t(.)\n/){
		        if ($anotation=~/$chr\t(\d+?)\t(\d+?)\t(\w+?)\n/){
                		$TSS=int(($1+$2)/2);
				$oritation=$3;
				if ($oritation eq "zheng"){$bin_size=$start-$TSS;}
				elsif($oritation eq "fu"){$bin_size=$TSS-$start;}
				if($bin_size<201 && $bin_size>-201){$bin_number{$bin_size}++;}
				}
				}
			}
@keys= sort {$a <=> $b}  keys(%bin_number);
foreach $_(0 .. 400){
		$n=$_-200;
		if (exists $bin_number{$n}){
			print OUT1"$n\t$bin_number{$n}\n";}
		else {print OUT1"$n\t0\n";}
		$_++;
	}
