#!/usr/bin/perl -w
#This script used for statistic the methylation level for the modification result.
#Sheng ya lan 20180312
use strict;
my (@Result,$orientation,$scafford,$location,$total,$frac,$number_0,$number_10,$number_20,$number_30,$number_40,$number_50,$number_60,$number_70,$number_80,$number_90,$line,$low,$inter,$high,$high_number,$inter_number,$low_number);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_low");
open (OUT2, ">", "$ARGV[0]_intermediate");
open (OUT3, ">", "$ARGV[0]_high");
open (OUT4, ">", "$ARGV[0]_methylation_level_result");
{
		@Result= <IN1>;
		close IN1;
}
foreach $line(@Result){
		if ($line=~/\d+.+?m6A\t.+?\;frac\=(\d.\d+)\;/){
			$frac=$1;
			if ($frac<=0.1){$number_0++;}
			elsif($frac<=0.2){$number_10++;print OUT1"$line";}
			elsif($frac<=0.3){$number_20++;print OUT2"$line";}
			elsif($frac<=0.4){$number_30++;print OUT2"$line";}
			elsif($frac<=0.5){$number_40++;print OUT2"$line";}
			elsif($frac<=0.6){$number_50++;print OUT2"$line";}
			elsif($frac<=0.7){$number_60++;print OUT2"$line";}
			elsif($frac<=0.8){$number_70++;print OUT2"$line";}
			elsif($frac<=0.9){$number_80++;print OUT3"$line";}
			else{$number_90++;print OUT3"$line";}
			}
		}
$total=$number_0+$number_10+$number_20+$number_30+$number_40+$number_50+$number_60+$number_70+$number_80+$number_90;
$high_number=$number_80+$number_90;
$inter_number=$number_20+$number_30+$number_40+$number_50+$number_60+$number_70;
$low_number=$number_10;
$low=$number_10/$total;
$inter=($number_20+$number_30+$number_40+$number_50+$number_60+$number_70)/$total;
$high=($number_80+$number_90)/$total;
print OUT4"Total:$total\n";
print OUT4"0~10:$number_0\n10~20:$number_10\n20~30:$number_20\n30~40:$number_30\n40~50:$number_40\n50~60:$number_50\n60~70:$number_60\n70~80:$number_70\n80~90:$number_80\n90~100:$number_90\n";
print OUT4"The methylation level is:\nlow 10%~20%:$low_number\t$low\nintermediate 20~80%:$inter_number\t$inter\nhigh 80%~100%:$high_number\t$high\n";
