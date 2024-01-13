#!/usr/bin/perl -w
#This script used for operate series files.
#usage: perl perl.pl $dir/bed
#Sheng ya lan 20190305
#glob 用于批量文件识别的时候，因为perl不能直接识别linux
use strict;
use File::Spec;
my (@file,$soft_path);
$soft_path="/apps/users/yefei/biosoft/NucPosSimulator_linux64";
my$dir=$ARGV[0];
@file=glob"$dir/*";
foreach $_(@file){
		system("$soft_path/NucPosSimulator $_ $soft_path/params.txt");
		close $_;
		}
