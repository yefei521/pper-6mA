use strict;
my$dir=$ENV{'PWD'};
my(%fasta,$name);
open(IN1,"<","$dir/4-upd-Protein-fasta-2021.fasta");
open(IN2,"<","$dir/conjugation_specific-exp_gene.txt");
open(OUT1,">","$dir/conjugation_specific-exp_gene.fasta");
foreach(<IN1>){
   if(/>(.+?)\s/){ $name=$1; 
   }else{$fasta{$name}.=$_;}
}
foreach(<IN2>){ chomp;
  if(exists$fasta{$_}){print OUT1">$_\n$fasta{$_}"; }
}
