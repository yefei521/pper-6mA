use strict;
my(%m6A, %Sy2Asy, %Cyst, %Cyst_m6A, %Veg, %Veg_m6A);
open(IN1,"<$ARGV[0]"); #temp.txt
open(IN2,"<$ARGV[1]"); #Cyst_6mA.bed
open(IN3,"<$ARGV[2]"); #Veg_6mA.bed
open(IN4,"<$ARGV[3]"); #12gene
foreach(<IN1>){
   if(/^(.+?)\s+sy\s+asy/){ $m6A{$1}++;   #print "$1\n";
  }
}

foreach(<IN2>){
   if(/^(.+?)\s+(\d+)\s/){
    $Cyst_m6A{"$1_$2"}++;
   }
}

foreach(<IN3>){
   if(/^(.+?)\s+(\d+)\s/){
    $Veg_m6A{"$1_$2"}++;
   }
}

foreach(<IN4>){
   if(/^(.+?)\s.+?gene\s+(\d+)\s+(\d+)\s.+?Name=(.+)\s/){
         foreach my$i($2 .. $3){
             if(exists $m6A{"$1_$i"}){ $Sy2Asy{$4}++;    }
             if(exists $Cyst_m6A{"$1_$i"}){ $Cyst{$4}++;    }
             if(exists $Veg_m6A{"$1_$i"}){ $Veg{$4}++;    }
             $i++;
         }
   }
}
open(OUT1,">Sy2Asy-gene.txt");
foreach(keys%Sy2Asy){
    print OUT1"$_\t$Sy2Asy{$_}\t$Veg{$_}\t$Cyst{$_}\n";
}
