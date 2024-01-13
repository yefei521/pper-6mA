#!/usr/bin/perl -w
#This script used for split files into series small files. 
#usage: perl perl.pl Chr_name.list MNase.bed
#Sheng ya lan 20190304
use strict;
my (@bed,$sequence,$name,@list,$dir);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
#open (TXT, ">", "$ARGV[1]_fragment_bin_distribution");
{
		@list= <IN1>;
		close IN1;
		@bed= <IN2>;
		close IN2;
}
$ARGV[1]=~/(.+?)\/accepted_hits_sorted_rmdup_120_260.bed/;
$dir=$1;
foreach $_(@list){
                $_=~/(tig.+?)\n/;
		$name=$1;
		open (TXT,">","$dir/bed/$name.txt")
		      or die "Can't open TXT : $!";
		foreach $sequence(@bed){
			if ($sequence=~/$name\t/){
				print TXT "$sequence";
				$sequence="";
				}
			}
       
close TXT;
}
