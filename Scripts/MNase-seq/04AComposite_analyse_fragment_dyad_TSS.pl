#!/usr/bin/perl -w
#This scripts used for analysis the chip fragment in the genome,compare with genes. 
#Usage: perl perl.pl mRNA_well_modeled_Jie_1kb_up.gff3 MNase.sam
use strict;
my (@GFF,@sam,$anotation,$chr,$start,$mid,$length,$five,$three,$bin_mid,@keys,$sequence,$test,$temp,$ori,%bin_number,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[1]_fragment_bin_distribution");
{
		@GFF= <IN1>;
		close IN1;
		@sam= <IN2>;
		close IN2;
}
foreach $sequence(@sam)
            {
		if($sequence=~/(tig.+?)\s+(\d+).+?\=\s+(\d+)\s+(\d+)\s+(\w+?)\s/)
               {
		$chr=$1;
		$start=$2;
		$length=abs($4);
		$mid=$start+int($length/2);
		$test=0;
		foreach $anotation(@GFF)
                       {
			$temp=$test;
			if($anotation=~/($chr)\s+\w+\s+\w+\s+(\d+)\s+(\d+)\s+.\s+(.)\s/)
                               {
				$ori=$4;
				if ($ori eq "+")
                                    {
					$five=$2-2001;
					$three=$2+2001;
					if ($mid > $five && $mid < $three)
                                             {
						$test++;
						$bin_mid=$mid-$five;
						$bin_number{$bin_mid}++;
				             }
					}
				elsif($ori eq "-")
                                   {
					$five=$3+2001;
					$three=$3-2001;
					if ($mid> $three && $mid<$five)
                                            {
						$test++;
						$bin_mid=$five-$mid;
						$bin_number{$bin_mid}++;
						}
					}
				}
			if ($test>0 && $test == $temp){last;}
		}
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
