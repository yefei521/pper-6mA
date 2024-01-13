use strict;
my($name,%protein,$n,$m);
my$dir=$ENV{'PWD'};

open(IN2,"<","$dir/4-upd-Protein-fasta-2021.fasta") or die ;
while(<IN2>){
    $m++;
    if(/^>(.+?)\s+(.+)\n/){ $name=$1; $n++; 
   }else{ chomp; $protein{$name}.=$_; }
}
print "n\t$n\nm\t$m\n";
close IN2;
open(OUT1,">$dir/Tet_protein.txt");
open(IN1,"<$dir/T_thermophila_t1.gff3_CDS_right.list");
foreach(<IN1>){
   if(/^(g\d+)\s+(.+?)\n/){ if(exists$protein{$2}){print OUT1">$2\n$protein{$2}*\n";} }
}
