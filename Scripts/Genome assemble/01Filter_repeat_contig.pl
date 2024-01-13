#perl pl fasta
##remove contig mareked suggestRepeat=yes suggestBubble=yes
use strict;
my(@FASTA,@list,$mark,$name);
open (IN1, "<", "$ARGV[0]") or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_rmRep");
open (OUT2, ">", "$ARGV[0]_Rep");
{
    @FASTA=<IN1>;  close IN1;
}

foreach(@FASTA){
   if(/^>(tig\d+)\s+len=(\d+)\s+reads=(\d+)\s+class=contig\s+suggestRepeat=(.+?)\s+suggestBubble=(.+?)\s+suggestCircular=(.+?)\s+/){
    if($4 eq "yes" && $5 eq "yes"){$mark="yes"; $name=$_;}else{$mark="no"; $name=$_;}
    if($mark eq "no"){ print OUT1 "$_";}else{print OUT2 "$_";}
  }elsif($mark eq "no"){ print OUT1 "$_"; 
  }elsif($mark eq "yes"){print OUT2 "$_";}
}
