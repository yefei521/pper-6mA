#!/usr/bin/perl -w
##This script used for statistic the distance between 6mA sites and called nucleosome dyad. (with the left nucleosome as prior)
##Sheng ya lan 20181226
##Usage: perl Statistic_6mA_nucleosome_dyad_distance.pl 6mA.gff Nucelsome_called.bed

use strict;
my (@m6A,@bed,$line,$scf,$location,$name,$mid,$distance,$n,%bed,$name2);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_$ARGV[1]_distance_nucleosome_methylevel");
{
		@m6A= <IN1>;
		close IN1;
}
{
		@bed= <IN2>;
		close IN2;
}
print OUT1"chr\tposition\tdistance\tlevel\n";
foreach $_(@bed){
	$_=~/(tig.+?)\t(\d+?)\t(\d+?)\s/;
	$mid=int(($2+$3)/2);
	$name="$1\t$mid";
	$bed{$name}=0;
	}

foreach $n(0...200){
#foreach $n(-100 ... 100){
		foreach $line(@m6A){
			$line=~/(tig.+?)\t.+?m6A\t(\d+?)\t.+?frac=(.+?);/;
			$scf=$1; my$m=-1;
			$location=$2-$n;
			$name2="$scf\t$location";
                        if($3>=0 && $3<0.1){$m="0-10\t$3"; }elsif($3>=0.1 && $3<0.2){$m="10-20\t$3"; 
                        }elsif($3>=0.2 && $3<0.3){$m="20-30\t$3";}elsif($3>=0.3 && $3<0.4){$m="30-40\t$3";
                        }elsif($3>=0.4 && $3<0.5){$m="40-50\t$3";
                        }elsif($3>=0.5 && $3<0.6){$m="50-60\t$3";}elsif($3>=0.6 && $3<0.7){$m="60-70\t$3";
                        }elsif($3>=0.7 && $3<0.8){$m="70-80\t$3";}elsif($3>=0.8 && $3<0.9){$m="80-90\t$3";
                        }elsif($3>=0.9 && $3<=1){$m="90-100\t$3";}
			if (exists ($bed{$name2})){$distance=$n; if($n>100){my$a=200-$n;}else{my$a=$n;} print OUT1"$1\t$2\t$distance\t$m\t$a\n";}
		}
	$n=$n+1;
	}
