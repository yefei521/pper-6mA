

use strict;
my (%hash,$name,@m6A,@Genic,$line,$scf,$start,$begin,$end,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (IN2, "<", "$ARGV[1]")
		or die "Can't open IN2 : $!";
open (OUT1, ">", "$ARGV[0]_Interenic");
{
		 @m6A= <IN1>;
		close IN1;
		 @Genic= <IN2>;
		close IN2;
}
while(@m6A){
       if(/(chr_\d+)\t.+?m6A\t(\d+?)\t(\d+?)\t(\d+?)\t(.)\t/){
            $scf=$1;
            $start=$2;
            $name="$scf"." $start";
            $hash{$name}=1;
       }
}
 foreach $line(@Genic){
       if($line=~/(chr_\d+)\t.+?m6A\t(\d+)\t(\d+?)\t(\d+?)\t(.)\t/){ 
              $scf=$1;
              $start=$2;
              $name="$scf"." $start";
              if(exists $hash{$name}){}
              else{print OUT1 "$line"; $n++;}
      }
 }

print "$ARGV[0] in intergenic 6mA number is $n\n";
