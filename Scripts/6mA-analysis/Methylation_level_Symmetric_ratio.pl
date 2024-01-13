use strict;
my(%symmetric, %asymmetric, $asy_10, $asy_20, $asy_30, $asy_40, $asy_50, $asy_60, $asy_70, $asy_80, $asy_90, $asy_100,);
my($sy_10, $sy_20, $sy_30, $sy_40, $sy_50, $sy_60, $sy_70, $sy_80, $sy_90, $sy_100);
my$dir=$ENV{'PWD'};
open(IN1,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_10") or die;
open(IN2,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_20") or die;
open(IN3,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_30") or die;
open(IN4,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_40") or die;
open(IN5,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_50") or die;
open(IN6,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_60") or die;
open(IN7,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_70") or die;
open(IN8,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_80") or die;
open(IN9,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_90") or die;
open(IN10,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_100") or die;
open(IN11,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_symmetric") or die;
open(IN12,"<$dir/Veg_6mA_raw_Cv77-Qv30.gff_asymmetric") or die;
foreach(<IN11>){ chomp;  $symmetric{$_}=$_; }
foreach(<IN12>){ chomp;  $asymmetric{$_}=$_; }

foreach(<IN1>){ chomp; if(exists$symmetric{$_}){$sy_10++; }  if(exists$asymmetric{$_}){$asy_10++; } } my$sy_10_ratio=$sy_10/332142*100;   my$asy_10_ratio=$asy_10/332142*100;
foreach(<IN2>){ chomp; if(exists$symmetric{$_}){$sy_20++; }  if(exists$asymmetric{$_}){$asy_20++; } } my$sy_20_ratio=$sy_20/332142*100;   my$asy_20_ratio=$asy_20/332142*100;
foreach(<IN3>){ chomp; if(exists$symmetric{$_}){$sy_30++; }  if(exists$asymmetric{$_}){$asy_30++; } } my$sy_30_ratio=$sy_30/332142*100;   my$asy_30_ratio=$asy_30/332142*100;
foreach(<IN4>){ chomp; if(exists$symmetric{$_}){$sy_40++; }  if(exists$asymmetric{$_}){$asy_40++; } } my$sy_40_ratio=$sy_40/332142*100;   my$asy_40_ratio=$asy_40/332142*100;
foreach(<IN5>){ chomp; if(exists$symmetric{$_}){$sy_50++; }  if(exists$asymmetric{$_}){$asy_50++; } } my$sy_50_ratio=$sy_50/332142*100;   my$asy_50_ratio=$asy_50/332142*100;
foreach(<IN6>){ chomp; if(exists$symmetric{$_}){$sy_60++; }  if(exists$asymmetric{$_}){$asy_60++; } } my$sy_60_ratio=$sy_60/332142*100;   my$asy_60_ratio=$asy_60/332142*100;
foreach(<IN7>){ chomp; if(exists$symmetric{$_}){$sy_70++; }  if(exists$asymmetric{$_}){$asy_70++; } } my$sy_70_ratio=$sy_70/332142*100;   my$asy_70_ratio=$asy_70/332142*100;
foreach(<IN8>){ chomp; if(exists$symmetric{$_}){$sy_80++; }  if(exists$asymmetric{$_}){$asy_80++; } } my$sy_80_ratio=$sy_80/332142*100;   my$asy_80_ratio=$asy_80/332142*100;
foreach(<IN9>){ chomp; if(exists$symmetric{$_}){$sy_90++; }  if(exists$asymmetric{$_}){$asy_90++; } } my$sy_90_ratio=$sy_90/332142*100;   my$asy_90_ratio=$asy_90/332142*100;
foreach(<IN10>){ chomp; if(exists$symmetric{$_}){$sy_100++; }if(exists$asymmetric{$_}){$asy_100++; }} my$sy_100_ratio=$sy_100/332142*100; my$asy_100_ratio=$asy_100/332142*100;

print "10%\t$sy_10_ratio\t$asy_10_ratio\n";
print "20%\t$sy_20_ratio\t$asy_20_ratio\n";
print "30%\t$sy_30_ratio\t$asy_30_ratio\n";
print "40%\t$sy_40_ratio\t$asy_40_ratio\n";
print "50%\t$sy_50_ratio\t$asy_50_ratio\n";
print "60%\t$sy_60_ratio\t$asy_60_ratio\n";
print "70%\t$sy_70_ratio\t$asy_70_ratio\n";
print "80%\t$sy_80_ratio\t$asy_80_ratio\n";
print "90%\t$sy_90_ratio\t$asy_90_ratio\n";
print "100%\t$sy_100_ratio\t$asy_100_ratio\n";
