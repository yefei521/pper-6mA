use strict;
use threads;
use threads::shared;

my $in= $ARGV[0];
my $total_num = `wc -l < $in`;

my $thread_counts = 16;

my $size = (int($total_num / ($thread_counts * 16)) + 1)*16;

`awk -v sz=$size 'BEGIN{i=1}{ print > FILENAME "." i ".tmp"; if (NR>=i*sz){close(FILENAME "." i ".tmp");i++}}' $in`;

open (IN1, "<", "$ARGV[0]");
open (IN2, "<", "$ARGV[1]");
open (OUT1, ">", "$ARGV[0]_filtered");
my @FASTA;
my @Bacteria_list;
{
#   @FASTA= <IN1>;
#   close IN1;
   @Bacteria_list=<IN2>;
   close IN2;
}
my (@Sc_name,%Sc,$mark);
foreach( @Bacteria_list){
    if(/(.+?)\n/){
        $Sc{$1}=$1;
    }
}

my @files = glob ("$ARGV[0]*.tmp");
foreach (0 .. $thread_counts-1){
    print "Start one thread\n";
    my $thr = threads -> create(\&get_func, $files[$_]);
}

my %qc;
while(threads -> list()){
    foreach my $t(threads -> list(threads::joinable)){
        my $tmp = $t -> detach();
    }
}

unlink glob "$ARGV[0]*.tmp";
sub get_func {
    my (%RPKM,$c,$Sc_name,$c_name);
    while (<>){
       # chomp;
        if(/>(m.+?)\n/){
           if(!exists$Sc{$1}){$mark=1;print OUT1 "$_";}{$mark=0;} 
        }else{ if($mark==1){print OUT1 "$_";} }
    }
}
close OUT1;

