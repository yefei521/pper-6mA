#!/bin/bash
#include<stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
start_time=`date +%s`
[ -e /tmp/fd1 ] || mkfifo /tmp/fd1
exec 3<>/tmp/fd1 
rm -rf /tmp/fd1
for ((i=1; i<=4; i++))
do
        echo >&3 
done

for j in 01Raw_data/*_1.fq.gz;
do
read -u3 
{ j=${j#*/}
  name=${j%_1.fq.gz}
#  ~/biosoft/TrimGalore-0.6.6/trim_galore -q 20 -length 36 --fastqc -j 6 --clip_R1 10 --clip_R2 10 --paired 01Raw_data/${name}_1.fq.gz 01Raw_data/${name}_2.fq.gz -o 02Clean_data/ > 02Clean_data/Trim_Galore.log 2>&1
#_1.clean_val_1.fq.gz
# if [[ $name =~ "RNA" ]];then
     name1=${name}"align2Pper"
     hisat2 -p 6 --dta --summary-file 03Hisat2_align/${name1}_summary.txt -x 00Hisat2_index/Cyst-clean_veg -S 03Hisat2_align/${name1}.sam  -1 02Clean_data/${name}_1_val_1.fq.gz -2 02Clean_data/${name}_2_val_2.fq.gz  2>&1 >>03Hisat2_align/${name1}_error.ht2.log  
    name=$name1
    grep 'NH:i:1\b' 03Hisat2_align/${name}.sam  > 03Hisat2_align/${name}_unique.sam  
    grep '@SQ' 03Hisat2_align/${name}.sam  > 03Hisat2_align/${name}_header_unique.sam  
    cat  03Hisat2_align/${name}_header_unique.sam 03Hisat2_align/${name}_unique.sam  > 03Hisat2_align/${name}_all.sam 
    rm 03Hisat2_align/${name}_unique.sam 03Hisat2_align/${name}_header_unique.sam
    rm 03Hisat2_align/${name}.sam
    samtools view -bS  03Hisat2_align/${name}_all.sam  > 03Hisat2_align/${name}_all.bam
    rm 03Hisat2_align/${name}_all.sam
    java -jar /home/software/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar  SortSam -I 03Hisat2_align/${name}_all.bam -O 03Hisat2_align/${name}_sorted.bam -SORT_ORDER coordinate > 03Hisat2_align/${name}_sort.log 2>&1 
    rm 03Hisat2_align/${name}_all.bam 
    java -jar /home/software/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar  MarkDuplicates -I 03Hisat2_align/${name}_sorted.bam -O 03Hisat2_align/${name}_rmdup.bam -REMOVE_DUPLICATES true -M 03Hisat2_align/${name}_marked_dup_metrics.txt > 03Hisat2_align/${name}_rmdup.log 2>&1
    rm 03Hisat2_align/${name}_sorted.bam
# else
#    hisat2 -p 6 --dta --summary-file 03Hisat2_align/${name}_summary.txt -x 00Hisat2_index/1-Genome_assembly_new.fasta -S 03Hisat2_align/${name}.sam  -1 02Clean_data/${name}_1.clean_val_1.fq.gz -2 02Clean_data/${name}_2.clean_val_2.fq.gz  2>&1 >>03Hisat2_align/${name}_error.ht2.log  
#    name1=${name}"align2Tthe"
#    mv 03Hisat2_align/${name}.sam 03Hisat2_align/${name1}.sam
#    name=$name1
#    grep 'NH:i:1\b' 03Hisat2_align/${name}.sam  > 03Hisat2_align/${name}_unique.sam  
#    grep '@SQ' 03Hisat2_align/${name}.sam  > 03Hisat2_align/${name}_header_unique.sam  
#    cat  03Hisat2_align/${name}_header_unique.sam 03Hisat2_align/${name}_unique.sam  > 03Hisat2_align/${name}_all.sam 
#    rm 03Hisat2_align/${name}_unique.sam 03Hisat2_align/${name}_header_unique.sam
#    rm 03Hisat2_align/${name}.sam
#    samtools view -bS  03Hisat2_align/${name}_all.sam  > 03Hisat2_align/${name}_all.bam
#    rm 03Hisat2_align/${name}_all.sam
#    java -jar /home/software/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar  SortSam -I 03Hisat2_align/${name}_all.bam -O 03Hisat2_align/${name}_sorted.bam -SORT_ORDER coordinate > 03Hisat2_align/${name}_sort.log 2>&1 
#    rm 03Hisat2_align/${name}_all.bam 
#    java -jar /home/software/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar  MarkDuplicates -I 03Hisat2_align/${name}_sorted.bam -O 03Hisat2_align/${name}_rmdup.bam -REMOVE_DUPLICATES true -M 03Hisat2_align/${name}_marked_dup_metrics.txt > 03Hisat2_align/${name}_rmdup.log 2>&1
#    rm 03Hisat2_align/${name}_sorted.bam 
#fi
   echo >&3 
}&
done
wait

stop_time=`date +%s`
echo "TIME:`expr $stop_time - $start_time`"
exec 3<&-
exec 3>&-
