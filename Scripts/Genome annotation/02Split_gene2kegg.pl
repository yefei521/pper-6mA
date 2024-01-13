use strict;
my$dir=$ENV{'PWD'};
my(@temp);
open(IN1,"<$dir/Pper_ORFfinder.emapper.annotations.kegg.tsv");
open(OUT1,">$dir/Pper_ORFfinder.emapper.annotations.kegg2gene");
foreach(<IN1>){
   if(/(.+?)\t(GO.+?)\t(.+?)\n/){
     @temp=split(/,/,$3);
     foreach my$n(@temp){print OUT1"$1\t$n\n";}
   }
}
