# perl pl 
use strict;
my(@Reads2Tig,@fastaID,%reads,%list,$fasta,@ReadsInfo,$TigID,$readsID,%list,%length,$name,$Total_len,$G,$C,$GC_concent);
open (IN1, "<", "$ARGV[0]") or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]") or die "Can't open IN2 : $!";
open (IN3, "<", "$ARGV[2]") or die "Can't open IN3 : $!";
open (OUT1, ">", "$ARGV[0]_reads2Tig");
{
    @Reads2Tig=<IN1>;  close IN1;
    @ReadsInfo=<IN2>;  close IN2;
    @fastaID=<IN3>; close IN3;
}

foreach(@ReadsInfo){
      if(/(\d+)\s+(m.+?)\s/){$reads{$1}=$2; }
}

#5606797 4       22903   0
foreach(@Reads2Tig){
      if(/(\d+)\s+(\d+)\s/){ $TigID=$2; if(exists $reads{$1}){$readsID=$reads{$1}; $list{$TigID}.=">$readsID\t";}}
}

#m54219_200310_053951/4194376/18123_18693
my@a;
foreach(keys%list){
     @a=split(/\t/,$list{$_});
     my$i=0;while($i<@a){if($a[$i]=~/>m.+\/(\d+)_(\d+)/){
                              $length{$_}+=$2-$1; $i++;
                              if(($2-$1)==0){print "error";}
                         #     printf OUT1"tig%08d\t", $list{$_};
                         }
             }
}
print "$length{4}\n";
#>tig00000002 len=37078 reads=10
my(%fasta_len,$coverage,%num);
my$i=3;
foreach(@fastaID){
    if(/>tig0+(\d+)\s+len=(\d+)\s+reads=(\d+)\s+?/){$fasta_len{$1}=$2; $num{$1}=$3;  if($i>0){print "$1\t$2\n"; $i--;}} 
}

foreach(keys%fasta_len){
     #$coverage=round($length{$_}/$fasta_len{$_});
     printf OUT1 "tig%08d\t$fasta_len{$_}\t$length{$_}\t$num{$_}\n",$_;
}

