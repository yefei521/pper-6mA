use strict;
my();
open(IN1,"<$dir/");
open();
foreach(<IN1>){
   if(/gene\s+(\d+)\s+(\d+)\s.+?ID=(.+?);/){ $gene{$3}=$2-$1+1; $name=$3;
   }elsif(/exon\s+(\d+)\s+(\d+)\s.+?$name/){ $exon{$name}.=$_; }
}

