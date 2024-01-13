#perl conut_fai_chr_density.pl P.persalinus.genome.fasta.fai P.persalinus.genes.gff3
use strict;
my(%len, $sum, $name, $n, %density,%tig_gene_num,%num,%gene_len, %exon, %exon_num);
my$dir=$ENV{'PWD'};
open(IN1,"<$ARGV[0]") or die;
open(IN2,"<$ARGV[1]") or die;
open(OUT1,">$ARGV[0]_density")or die;

foreach(<IN1>){
  if(/^(sca.+?)\s+(\d+)\s/){ $len{$1}=$2;  $name=$4;}
}
my$i=1; 
foreach(<IN2>){ if(/^(.+?)\s+TFGD\s+gene\s+(\d+)\s+(\d+)\si.+?Name=(.+?);/){$tig_gene_num{$1}++; my$a=$3-$2+1; $gene_len{$a}++; $name=$4;
                }elsif(/(scaff.+?)\s.+?exon\s+(\d+)\s+(\d+)\s.+?Note=$name/){my$a=$3-$2+1; $exon{$a}++;   } 
}
my$i=1; while($i<11){ my$j=2+$i/10; my$m=10**($j); my$n=10**($j-0.1); foreach(keys%gene_len){if($n<$_ && $_<$m){$num{$m}+=$gene_len{$_};} } $i++; }
my$i=1; while($i<11){ my$j=3+$i/10; my$m=10**($j); my$n=10**($j-0.1); foreach(keys%gene_len){if($n<$_ && $_<$m){$num{$m}+=$gene_len{$_};} } $i++; }
foreach(keys%gene_len){if(10000<$_){$num{"15000"}+=$gene_len{$_};} }
#foreach(sort{$a<=>$b}keys%num){ if($num{$_}){print "$_\t$num{$_}\n";}else{print"$_\t0\n";} }

my$i=1; while($i<31){ my$j=1+$i/10; my$m=10**($j); my$n=10**($j-0.1); foreach(%exon){ if($n<$_ && $_<$m){ $exon_num{$m}+=$exon{$_};  } } $i++; }
foreach(sort{$a<=>$b}keys%exon_num){ my$a=$exon_num{$_}/187160; print "$_\t$exon_num{$_}\t$a\n"; }

my$max_len=56578960;
my$i=50000;
while($i<$max_len){  foreach(keys%len){ if($len{$_}<$i && $len{$_}>$i-50000){ $density{$i}+=$tig_gene_num{$_}; } }  $i+=50000;  }
foreach(sort{$a<=>$b}keys%len){
   $sum+=$_; $n++; print OUT1"$n\t$sum\n";
}
my$n=keys%density; 
#foreach(sort{$a<=>$b}keys%density){ my$a=$density{$_}/13186; print "$_\t$density{$_}\t$a\n";}
