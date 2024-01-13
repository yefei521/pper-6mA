use strict;
my(@FASTA,%fasta,%fasta2,$name,$Total_len,$G,$C,$GC_concent);
open (IN1, "<", "$ARGV[0]") or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_rmGC");
open (OUT2, ">", "$ARGV[0]_GCup30");
{
    @FASTA=<IN1>;  close IN1;
}

foreach(@FASTA){
    chomp;
    if(/>/){$name=$_;
    }else{$fasta{$name}.=$_; $fasta2{$name}.="$_\n";}
}

foreach(keys %fasta){
   $Total_len = length($fasta{$_});
   $G=$fasta{$_}=~tr/G/G/;
   $C=$fasta{$_}=~tr/C/C/;
   $GC_concent=($G+$C)/$Total_len*100;
   if($GC_concent<30){
     if(exists $fasta2{$_}){print OUT1 "$_\t$GC_concent\n$fasta2{$_}";}
   }else{print OUT2 "$_\t$GC_concent\n$fasta2{$_}";}
}


