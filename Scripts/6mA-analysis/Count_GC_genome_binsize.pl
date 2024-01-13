use strict;
die "#usage:perl $0 <Genome.fasta>\n" unless @ARGV==1;
my $fa=shift;
my $bin=10000;
open IN,$fa||die;
$/=">";<IN>;$/="\n";
open OUT,">","${fa}_${bin}_GC" || die;
print OUT "#Chr\tStart\tEnd\tGC_num\tGC-Ratio\tAT-ratio\tAratio\n";
while(<IN>){
	my $chr=$1 if /^(\S+)/;
	$/=">";
	chomp(my $seq=<IN>);
	$/="\n";
	$seq=~s/\n+//g;
	my $len=length$seq;
	for (my $i=0;$i<$len/$bin;$i++){
		my $loc=$i*$bin;
		my $sub_fa=uc(substr($seq,$loc,$bin));
		my $GC=$sub_fa=~tr/GC//;
		my $GCratio=sprintf "%.4f",$GC/$bin;
                my $ATratio=1-$GCratio;
                my $A_num=$sub_fa=~tr/A//; my $Aratio=sprintf "%.4f",$A_num/$bin;
		my $start=$i*$bin+1;
		my $end=($i+1)*$bin;
		my $out=join "\t",$chr,$start,$end,$GC,$GCratio,$ATratio,$Aratio;
		print OUT $out,"\n";
	}	
}
close IN;
