use strict;
open (IN1, "<", "$ARGV[0]");
open (IN2, "<", "$ARGV[1]");
open (OUT1, ">", "$ARGV[1]_filtered");
my @FASTA;
my @Bacteria_list;
my %Sc;
my $mark;
my $line;
#{
#   @FASTA= <IN1>;
 #  close IN1;
#   @Bacteria_list=<IN1>;
#   close IN1;
#}

foreach(<IN1>){
    if(/(.+?)\n/){ my$line=$1;
        $line=~s/\//_/g;
       $Sc{$line}=$1;
    }
}
while(<IN2>){
    if(/>(m.+?)\n/){
         $line=$1; $line=~s/\//_/g;
         if(!exists$Sc{$line}){ $mark=1;print OUT1 "$_";}else{$mark=0;delete $Sc{$line};}
    }else{ if($mark==1){print OUT1 "$_";} }
}
close IN1;
close IN2;
print "111\n";
