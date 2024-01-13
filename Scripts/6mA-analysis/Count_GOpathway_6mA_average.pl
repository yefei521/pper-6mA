use strict;
my$dir=$ENV{'PWD'};
my(%m6A, %py, @GO_gene, %GO_gene, %GO);
open(IN1,"<$dir/veg-cyst_total-gene_6mA_amount.txt");
open(IN2,"<$dir/01veg-cyst_assembly_orffinder-otf1_ATG2TGA_pep_GOanno.go_go-term2gene.list");

foreach(<IN1>){ if(/^(.+?)\s+(\d+)\s+(\d+)\s/){ $m6A{"veg"}{$1}=$2; $m6A{"cyst"}{$1}=$3;  }  }

foreach(<IN2>){ my@temp=split; my$py=shift@temp; my$n=@temp; 
                foreach my$a(@temp){ $py{$py}{"veg"}+=$m6A{"veg"}{$a} ; $py{$py}{"cyst"}+=$m6A{"cyst"}{$a} ; }  
                #$py{$py}{"veg"}=$py{$py}{"veg"}/$n; $py{$py}{"cyst"}=$py{$py}{"cyst"}/$n;
}

open(OUT1,">$dir/veg-cyst_GOpathway-total-gene_6mA_average.txt");
foreach(keys%py){
    print OUT1"$_\t$py{$_}{veg}\t$py{$_}{cyst}\n";
}
