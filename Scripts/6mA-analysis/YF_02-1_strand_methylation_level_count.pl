use strict;
my (@Annotation,@m6A_W,@m6A_C,%count_2,$position,$chr,$line,$level_W,$level_C,%count,$orientation,$zone,$start,$begin,$end,$exon_number,$five_UTR,$three_UTR,$intron,$n);
my(%WC, %W, %C);
open (IN1, "<", "$ARGV[0]")
	or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
        or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_WC_220210");
{
	@m6A_W= <IN1>;
	close IN1;
        @m6A_C=<IN2>;
        close IN2;
}
foreach(@m6A_W){
     if(/(tig\d+.+?)\s.+?m6A\s+?(\d+?)\s.+?frac=(\d.\d+);/){
            $level_W=$3;
            $n=0;
            $chr=$1;
            $zone="$chr"."\t$2";
            $W{$zone}=$3;
    }
}

foreach(@m6A_C){
     if(/(tig\d+.+?)\s.+?m6A\s+?(\d+?)\s.+?frac=(\d.\d+);/){
            $level_W=$3;
            $n=0;
            $chr=$1;
            $zone="$chr"."\t$2";
            $C{$zone}=$3;
    }
}
foreach(keys%W){
   if(/(tig.+)\t(\d+)/){$chr=$1; $position=$2+1; my$temp="$1\t$position";
      if(exists$C{"$1\t$position"}){   $WC{$temp}="$_\t$W{$_}\t$C{$temp}\n";    #print OUT1 "$_\t$W{$_}\t$C{$temp}\n";
      }else{ $WC{$temp}="$_\t$W{$_}\t0\n";     #print OUT1"$_\t$W{$_}\t0\n";
      }
   }
}
foreach(keys%C){
   if(/(tig.+)\t(\d+)/){$chr=$1; $position=$2-1; my$temp="$1\t$position";
      if(exists$W{"$1\t$position"}){   $WC{$temp}="$_\t$W{$temp}\t$C{$_}\n";   # print OUT1 "$_\t$W{$_}\t$C{$temp}\n";
      }else{ $WC{$temp}="$_\t0\t$C{$_}\n";   #print OUT1"$_\t0\t$C{$_}\n";
      }
   }
}

foreach(keys%WC){
 print OUT1"$WC{$_}";
}








