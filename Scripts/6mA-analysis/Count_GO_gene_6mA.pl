use strict;
my$dir=$ENV{'PWD'};
my(%m6A, %gene, @GO_gene, %GO_gene, %GO);
open(IN1,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff");
open(IN2,"<$dir/cyst-veg-clean_sorted_rmdup_count.csv");
open(IN3,"<$dir/down_DEG_GO.xls");

foreach(<IN1>){ if(/^(.+?)\s+.+?m6A\s+(\d+)\s+(\d+)\s/){ $m6A{"$1\t$2"}++;  }  }

foreach(<IN2>){ if(/^(.+?)\s+(tig.+?)\s+(\d+)\s+(\d+)\s/){$gene{"$1"}="$2\t$3\t$4";   }  }

foreach(<IN3>){ if(/\s(veg-cyst.+?)\s+/){  my@temp=split(/,/,$1); foreach my$n(@temp){$GO{$n}++; } }  }
my$n=keys%GO; print"$n\n";
foreach my$n(keys%GO){ if($gene{$n}=~/^(.+?)\s+(.+?)\s+(.+)/){
      foreach my$m($2 .. $3){if(exists$m6A{"$1\t$m"}){$GO_gene{$n}++; }$m++;  }
  }
}

foreach(keys%GO_gene){
   my$n=int($GO_gene{$_}*1000000/114611); print "$_\t$GO_gene{$_}\t$n\tveg\n";
}
