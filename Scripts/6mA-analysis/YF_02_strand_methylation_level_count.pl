use strict;
my (@Annotation,@m6A_W,@m6A_C,%count_2,$position,$chr,$line,$level_W,$level_C,%count,$orientation,$zone,$start,$begin,$end,$exon_number,$five_UTR,$three_UTR,$intron,$n);
open (IN1, "<", "$ARGV[0]")
	or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
        or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_WC_2");
{
	@m6A_W= <IN1>;
	close IN1;
        @m6A_C=<IN2>;
        close IN2;
}
foreach(@m6A_W){
     if(/(tig\d+.+?)\s.+?m6A\s+?(\d+?)\s.+?frac=(\d.\d+);/){
            $level_W=$3;
            $position=$2+1;
            $n=0;
            $chr=$1;
            $zone="$chr"."$2";
            while(@m6A_C){
                if(/($chr)\s.+?m6A\s+($position)\s.+?frac=(\d.\d+);/){
                   $level_C=$3;
                   $count{$zone}=$level_C;
                   $count_2{$zone}=$level_W;
                   $n=1;
                   print OUT1"$zone\t$level_W\t$level_C\n";last;}
               }
               if($n==0){print OUT1 "$zone\t$level_W\t0\n";}
    }
}
#foreach(@m6A_W){
#       if(/(chr_\d+)\s+.+?m6A\s+(\d+)\s.+?frac=(\d.\d+);/){
#            $zone="$1"."$2";print "3";
 #           $level_W=$3;
 #            if(exists $count_2{$zone}){}
 #            else{print OUT1"$zone\t$level_W\t0\n";}
 #     }
#}
foreach(@m6A_C){
       if(/(tig\d+.+?)\s+.+?m6A\s+(\d+)\s.+?frac=(\d.\d+);/){
             $zone="$1"."$2";
             $level_C=$3;
             if(exists $count{$zone}){}
             else{print OUT1"$zone\t0\t$level_C\n";}
      }
}







