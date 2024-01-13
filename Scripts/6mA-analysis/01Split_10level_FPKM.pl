use strict;
my(%gene,%gene1,%gene2,%gene3,%ID,);
my$dir=$ENV{'PWD'};
open(IN1,"<$dir/Pper4_sorted_rmdup.gtf");
open(IN2,"<$dir/Pper5_sorted_rmdup.gtf");
open(IN3,"<$dir/Pper6_sorted_rmdup.gtf");
open(OUT1,">$dir/veg_FPKM_10level.txt");

#tig00000011_pilon_pilon_veg_pilon       StringTie       transcript      507     3216    1000    -       .       gene_id "STRG.1"; transcript_id "STRG.1.1"; reference_id "veg-cyst.7314.1"; cov "15.084358"; FPKM "5.095131"; TPM "8.471843";
foreach(<IN1>){
   if(/^(tig.+?)\t.+?transcript\t(\d+)\t(\d+)\t\d+\t(.)\t.+?reference_id "(.+?)";.+?FPKM (".+?)";/){
      $gene1{$5}=$6; $ID{$5}="$1\t$2\t$3\t$4";
   }
}

foreach(<IN2>){
   if(/^(tig.+?)\t.+?transcript\t(\d+)\t(\d+)\t\d+\t(.)\t.+?reference_id "(.+?)";.+?FPKM (".+?)";/){
      $gene2{$5}=$6;
   }
}

foreach(<IN3>){
   if(/^(tig.+?)\t.+?transcript\t(\d+)\t(\d+)\t\d+\t(.)\t.+?reference_id "(.+?)";.+?FPKM (".+?)";/){
      $gene3{$5}=$6;
   }
}

foreach(keys%gene1){
    $gene{$_}=($gene1{$_}+$gene2{$_}+$gene3{$_})/3;
}
my$n=keys%gene;
my$m=0;
foreach(sort{$gene{$a}<=>$gene{$b}}keys%gene){
   if($m/$n<0.1){    print OUT1"$ID{$_}\t$gene{$_}\t0-10\t$_\n";  
  }elsif($m/$n<0.2){ print OUT1"$ID{$_}\t$gene{$_}\t10-20\t$_\n";
  }elsif($m/$n<0.3){ print OUT1"$ID{$_}\t$gene{$_}\t20-30\t$_\n";
  }elsif($m/$n<0.4){ print OUT1"$ID{$_}\t$gene{$_}\t30-40\t$_\n";
  }elsif($m/$n<0.5){ print OUT1"$ID{$_}\t$gene{$_}\t40-50\t$_\n";
  }elsif($m/$n<0.6){ print OUT1"$ID{$_}\t$gene{$_}\t50-60\t$_\n";
  }elsif($m/$n<0.7){ print OUT1"$ID{$_}\t$gene{$_}\t60-70\t$_\n";
  }elsif($m/$n<0.8){ print OUT1"$ID{$_}\t$gene{$_}\t70-80\t$_\n";
  }elsif($m/$n<0.9){ print OUT1"$ID{$_}\t$gene{$_}\t80-90\t$_\n";
  }elsif($m/$n<=1){ print OUT1"$ID{$_}\t$gene{$_}\t90-100\t$_\n";
  }
  $m++;
}
