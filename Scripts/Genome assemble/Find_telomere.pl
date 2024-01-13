#!/usr/bin/perl -w
#This script used for find the telomere 4C2A in the genome.
#perl perl.pl Tetrahymena.genome
#Sheng ya lan 20190328
use strict;
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_telomere");
my (@fasta,$fasta,$n,$sequence,$name,$covStat,$suggestRepeat,$suggestCircular,$left,$right,$length);
{
		local$/=undef;
		$fasta=<IN1>;
		close IN1;
}
$fasta=~s/>/!>/sg;
@fasta=split/!/,$fasta;
shift@fasta;
foreach $_(@fasta){
		$_=~/>(tig\d+?)\slen=(.+?)\sreads=(.+?)\s.+?suggestRepeat=(\w+?)\s.+?suggestCircular=(\w+?)\s/;
		$name=$1;
		$length=$2;
		$covStat=$3;
		$suggestRepeat=$4;
		$suggestCircular=$5;
		$sequence=$_;
		$sequence=~s/>.+?\n//sg;
		$sequence=~s/\n//sg;
		$left="none";
		$right="none";
		if ($sequence ~~/^([AC]+CCCCAA[AC]+?)/i){$left="5'telomere";}
		if ($sequence ~~/(GGGGTT[GT]+[GT]+)$/i){$right="3'telomere";}
		print OUT1"$name\t$length\t$covStat\t$suggestRepeat\t$suggestCircular\t$left\t$right\n";
		}
