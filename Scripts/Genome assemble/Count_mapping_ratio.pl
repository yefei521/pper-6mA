use strict;
my(%length,%ratio);
open(IN1,"<","P.persalinus.genome.fasta_length");
open(IN2,"<","MWblast140M170_otf7");
open(OUT1,">","MWblast140M170_otf7_result_MappingRatio");
while(<IN1>){
   if(/^(.+?)\t(\d+)\s/){$length{$1}=$2; }
}
my$n=keys%length;
print "$n\n";
#m54219_200310_053951/4194438/ccs        tig00000133_pilon_pilon_cyst-veg_pilon  99.988  8634    0       1       1       8634    220708  212076  0.0     15937
while(<IN2>){
   if(/^(scaffold.+?)\s+(tig.+?)\s.+?\s(\d+)\s/){
       $ratio{$1}+=$3;
   } 
}

foreach(keys%length){
  if(exists$ratio{$_}){ my$m=$ratio{$_}/$length{$_} ; print OUT1"$_\t$length{$_}\t$m\n";
  }else{ print OUT1"$_\t$length{$_}\t0\n"; }
}
