use strict;
my( $header, %chr_len, %m6A_W, %m6A_C, %bin_W, %bin_C);
my$dir=$ENV{'PWD'};
open(IN1,"<$dir/header.sam");
open(IN2,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_asymmetric");
open(IN3,"<$dir/Cyst-veg-clean_pilon.fasta_genome.fasta_10000_GC");
foreach(<IN1>){
   if(/SN:(tig.+?)\s.+?LN:(\d+)\s/){  $chr_len{$1}=$2;  }
}
my$bin=10000;
#tig00000011_pilon_pilon_veg_pilon       kinModCall      m6A     2844    2844    95      +       .
foreach(<IN2>){
  if(/^(tig.+?)\s.+?m6A\t(\d+)\t\d+\t\d+\t(.)\s.+?context=\w{20,20}AT\w{19,19}\;/){ if($3 eq "+"){$m6A_W{"$1\t$2"}=$3; }else{$m6A_C{"$1\t$2"}=$3; } }
}

my@IN3=<IN3>;
#tig00000011_pilon_pilon_veg_pilon       1       10000   1915    0.1915  0.8085  0.4249
foreach(@IN3){ chomp;
  if(/^(tig.+?)\t(\d+)\t(\d+)\t\d+\t.+?\t.+?\t(.+)/){my$line=$_; 
      my$n=$2;
      while($n<=$3 ){
         if(exists $m6A_W{"$1\t$n"}){ $bin_W{$line}++;  }
         if(exists $m6A_C{"$1\t$n"}){ $bin_C{$line}++;  }
         $n++;
      }
      #print "$bin_W{$_} \t$bin_C{$_}\n"; 
  }else{chomp; $header=$_;} 
}
open(OUT,">$dir/Veg_6mA_raw_Cv77-Qv30.gff_WCratio");
#print OUT"$header\tW_ratio\tC_ratio\n";
foreach(@IN3){
   chomp; 
   my $W_ratio=sprintf "%.6f",$bin_W{$_}/$bin; 
   my $C_ratio=sprintf "%.6f",$bin_C{$_}/$bin;
   print OUT"$_\t$W_ratio\t$C_ratio\n";
}
