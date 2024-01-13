use strict;
my$dir=$ENV{'PWD'};
my(%IPD_C, %Frac_C, %IPD_W, %Frac_W);
open(IN1,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_asymmetric") or die;
#open(IN2,"<$dir/");
#open(IN3,"<$dir/");

#70      -       .       coverage=94;context=CTATTTAAATTTAGTTTAAAATTATTTTTATATAGTAAGAA;IPDRatio=2.68;frac=0.620;fracLow
open(OUT1,">>$dir/Veg_6mA_raw_Cv77-Qv30.gff_S-asymmetric_IPD_Frac_WC");
print OUT1"Ori\tIPDratio\tFrac\n";
foreach(<IN1>){
  if(/\d+\s+(-)\t.\tcoverage.+?IPDRatio=(.+?);frac=(.+?);fracLow/){
        $IPD_C{$_}=$2; $Frac_C{$_}=$3; print OUT1 "Asymmetric\tCrick\t$2\t$3\n";
   }elsif(/\d+\s+(\+)\t.\tcoverage.+?IPDRatio=(.+?);frac=(.+?);fracLow/){
        $IPD_W{$_}=$2; $Frac_W{$_}=$3; print OUT1 "Asymmetric\tWatson\t$2\t$3\n";
   }
}
