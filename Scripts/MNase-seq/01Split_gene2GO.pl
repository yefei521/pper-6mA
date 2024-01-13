use strict;
my$dir=$ENV{'PWD'};
my(@temp, %GO);
open(IN1,"<$dir/Pper_ORFfinder.emapper.annotations.kegg2gene");
#open(OUT1,">$dir/Pper_ORFfinder.emapper.annotations.GO2gene");
foreach(<IN1>){
   if(/^(.+?)\s+(.+?)\n/){
    # @temp=split(/,/,$2);
    # foreach my$n(@temp){print OUT1"$1\t$n\n";}
   # print OUT1"$1\t$2\n";
    $GO{$2}.="$1\t";
   }
}

open(OUT2,">","$dir/Pper_ORFfinder.emapper.annotations.kegg2gene.gmt");
foreach(keys%GO){
  print OUT2"$_\t$GO{$_}\n";
}
