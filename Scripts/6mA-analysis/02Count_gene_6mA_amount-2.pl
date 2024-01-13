use strict;
my$dir=$ENV{'PWD'};
my(%m6A,%gene, $name, %Sm6A, %Asm6A );
open(IN1,"<$dir/veg_FPKM_10level.txt");
open(IN2,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff");
open(IN3,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_asymmetric");
open(IN4,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_symmetric");
open(OUT1,">$dir/veg_gene_6mA_amount.txt");
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
   if(/(tig.+?)\t(\d+)\t(\d+)\t(.+?)\t(.+?)\n/){
     $name="$1\t$2\t$3\t$4\t$5";
     foreach my$n($2 .. $3){
        if(exists$m6A{"$1\t$n"}){ $gene{$name}{"6mA"}++;  }
        if(exists$Sm6A{"$1\t$n"}){ $gene{$name}{"S6mA"}++; }
        if(exists$Asm6A{"$1\t$n"}){ $gene{$name}{"As6mA"}++; }
        $n++;
     }
   }
}

foreach my$n(keys%gene){
   my$a="6mA"; my$b="S6mA"; my$c="As6mA";
   if(!exists$gene{$n}{"6mA"}){ $gene{$n}{"6mA"}=0; }
   if(!exists$gene{$n}{"S6mA"}){ $gene{$n}{"S6mA"}=0; }
   if(!exists$gene{$n}{"As6mA"}){ $gene{$n}{"As6mA"}=0; }
   print OUT1"$n\t$a\t$gene{$n}{$a}\t$b\t$gene{$n}{$b}\t$c\t$gene{$n}{$c}\n";
#   print OUT1 "$n\t 6mA\t$gene{$n}{"6mA"}\t S6mA\t$gene{$n}{"S6mA"}\t As6mA\t$gene{$n}{"As6mA"}\n";
}



