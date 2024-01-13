use strict;
my$dir=$ENV{'PWD'};
my(%m6A,%gene, $name, %Sm6A, %Asm6A,$start, $end );
open(IN1,"<$dir/12veg-cyst_assembly_orffinder-otf0_longest.gff3_gene");
open(IN2,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff");
open(IN3,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_asymmetric");
open(IN4,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_symmetric");
open(OUT1,">$dir/veg_total-gene_6mA_amount.txt");
#tig00000011_pilon_pilon_veg_pilon       kinModCall      m6A     13177   13177   59      -       .       coverage=45
foreach(<IN2>){
    if(/(tig.+?)\t.+?m6A\t(\d+)\t(\d+)\t\d+\t(.)\t/){
     $m6A{"$1\t$2"}=$_;
    }
}
foreach(<IN3>){
    if(/(tig.+?)\t.+?m6A\t(\d+)\t(\d+)\t\d+\t(.)\t/){
     $Asm6A{"$1\t$2"}=$_;
    }
}
foreach(<IN4>){
    if(/(tig.+?)\t.+?m6A\t(\d+)\t(\d+)\t\d+\t(.)\t/){
     $Sm6A{"$1\t$2"}=$_;
    }
}
#tig00000199_pilon_pilon_veg_pilon       147226  148812  0       0-10
foreach(<IN1>){
   if(/(tig.+?)\s.+?gene\s+(\d+)\t(\d+)\s.+?Name=(.+?)\s/){
     $name="$1\t$2\t$3\t$4"; $gene{$name}{"6mA"}=0; $gene{$name}{"S6mA"}=0; $gene{$name}{"As6mA"}=0;
    # if($3-$2<=1000){$start=$2; $end=$3; }else{$start=$2; $end=$2+1000;}
     foreach my$n($2 .. $3){
        if(exists$m6A{"$1\t$n"}){ $gene{$name}{"6mA"}++; }
        if(exists$Sm6A{"$1\t$n"}){ $gene{$name}{"S6mA"}++; }
        if(exists$Asm6A{"$1\t$n"}){ $gene{$name}{"As6mA"}++; }
        $n++;
     }
   }
}

foreach my$n(keys%gene){
   print OUT1"$n\t";
   foreach my$m6A(sort keys%{$gene{$n}}){
      print OUT1"$m6A\t$gene{$n}{$m6A}\t";
   }
   print OUT1"\n";
}
