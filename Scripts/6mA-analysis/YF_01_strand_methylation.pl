use strict;
my (@AT,$else_number, $sequence,@m6A,@Result,@Gene,$line,$scf,$start,$begin,$end,$n);
open (IN1, "<", "$ARGV[0]")
		or die "Can't open IN1 : $!";
open (OUT1, ">", "$ARGV[0]_Watson");
open (OUT2, ">", "$ARGV[0]_Crick");
{
		@m6A= <IN1>;
		close IN1;
}

foreach $sequence(@m6A){
                if ($sequence=~/m6A\s+(\d+)\s+(\d+?)\s+(\d+?)\s+(.)\s+(.)\s+.+?context=\w{20,20}AT\w{19,19}\;/){
                        push @AT,$sequence;}
                elsif($sequence=~/m6A\s+(\d+?)\s+(\d+?)\s+(\d+?)\s+(.)\s+(.)\s+.+?context=\w+/){
                        $else_number++;
                        }
        }
my$mm=@AT; print "$mm\n";
print "non-ApT\t$else_number\n";

foreach(@AT){
      if(/(tig\d+.+?)\t.+?m6A\t(\d+?)\t(\d+?)\t(\d+?)\t(.)\t.+?frac=/){
         if($5 eq "+"){print OUT1 "$_";}
      elsif($5 eq "-"){print OUT2 "$_";}
     }
}
