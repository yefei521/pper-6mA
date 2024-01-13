use strict;
my$dir=$ENV{'PWD'};
my(%m6A, %py, @GO_gene, %GO_gene, %GO);
open(IN1,"<$dir/veg_total-gene_6mA_amount.txt");
open(IN2,"<$dir/01veg-cyst_assembly_orffinder-otf1_ATG2TGA_pep_GOanno.go_go-term2gene.list");
open(IN3,"<$dir/cyst_total-gene_6mA_amount.txt");

foreach(<IN1>){ my@temp=split; $m6A{"S"}{$temp[3]}=$temp[9];     }
foreach(<IN3>){ my@temp=split; $m6A{"AS"}{$temp[3]}=$temp[9];    }

foreach(<IN2>){ my@temp=split; my$py=shift@temp; my$n=@temp; 
                foreach my$a(@temp){ $py{$py}{"S"}+=$m6A{"S"}{$a} ; $py{$py}{"AS"}+=$m6A{"AS"}{$a} ; }  
                # $py{$py}{"AS"}=$py{$py}{"AS"}/$n;
}

open(OUT1,">$dir/veg-cyst_GOpathway-total-gene_AS6mA_amount.txt");
foreach(keys%py){
    print OUT1"$_\t$py{$_}{S}\t$py{$_}{AS}\n";
}
