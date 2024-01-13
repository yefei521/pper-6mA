#!/usr/bin/perl -w
#This script used for statistic the distance between 6mA sites and called nucleosome dyad. (with the left nucleosome as prior)
#Sheng ya lan 20181226
#Usage: perl Statistic_6mA_nucleosome_dyad_distance.pl 6mA.gff Nucelsome_called.bed
use strict;
my (@m6A,@bed,$line,$scf,$location,@keys,$name,$mid,$distance,$n,%hash,%bed,$name2);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT2, ">", "$ARGV[0]_distance");
{
		@m6A= <IN1>;
		close IN1;
}
{
		@bed= <IN2>;
		close IN2;
}
#print OUT1"6mA distance to nucleosome dyad\n";
foreach $_(@bed){
     if($_=~/(tig.+?)\t(\d+?)\t(\d+?)\s+/){
	$mid=int(($2+$3)/2);
	$name="$1\t$mid";
	$bed{$name}=0;}
	}
foreach $n(0 ... 200){
		foreach $line(@m6A){
			if($line=~/(tig.+?)\t.+?m6A\t(\d+?)\t(\d+?)\s+/){
			$scf=$1;
			$location=$2-$n;
			$name2="$scf\t$location";
		         if(exists ($bed{$name2})){$hash{$n}++;}
		#        if (exists ($bed{$name2})){$distance=$n; print OUT1"$name2\t$distance\n";}
       	        #        if (exists ($bed{$name2})){$hash{$n}++ ; }
                 	}
               }
	$n=$n+1;
	}
print OUT2 "ID\t";
foreach(0 .. 200){
        print OUT2 "$_\t";}
print OUT2 "\n0-10\t";
@keys= sort {$a <=> $b}  keys(%hash);
foreach(0 .. 200){
	$n=$_;
	if (exists $hash{$_}){
			print OUT2"$hash{$_}\t";}
	else {print OUT2"0\t";}
	$_++;
}







