#bin/bash
#build index
# mapp to index  
#AMT1KO-homo_homo-1_1.clean.fq.gz

for i in 01Raw_data/*_1.clean.fq.gz;do
{
name=${i#*/}
name=${name%_1.clean.fq.gz*}
~/biosoft/TrimGalore-0.6.6/trim_galore -q 20 -length 36 --fastqc -j 6 --clip_R1 10 --clip_R2 10 --paired 01Raw_data/${name}_1.clean.fq.gz 01Raw_data/${name}_2.clean.fq.gz -o 02Clean_data/ > 02Clean_data/Trim_Galore.log 2>&1
}&
done

#wait
#nohup hisat2 -p 4 --dta --summary-file 03Hisat2_align/WT_C4_2_summary.txt -x 00Hisat2_index/1-Genome_assembly_new -S 03Hisat2_align/WT_C4_2.sam -1 02Clean_data/WT_C4_2_1_val_1.clean.fq.gz -2 02Clean_data/WT_C4_2_2_val_2.clean.fq.gz > WT_C4_2.log 2>&1 &
#AMT1KO-homo_homo-1_1_val_1.clean.fq.gz
#s3_1.clean_val_1.fq
#for i in 02Clean_data/s*_1.fq;do
#{
#name=${i#*/}
#name=${name%%_1.clean*}
#sample=${name} w1_1.clean_val_1.fq
#hisat2 -p 6 --dta --summary-file 03Hisat2_align/${name}_summary.txt -x 00Hisat2_index/1-Genome_assembly_new -S 03Hisat2_align/${name}.sam  -1 02Clean_data/${name}_1.clean_val_1.fq -2 02Clean_data/${name}_2.clean_val_2.fq  2>&1 >03Hisat2_align/${name}_error.ht2.log 
#hisat2 -p 6 --dta --summary-file 03Hisat2_align/${name}_2_summary.txt -x 00Hisat2_index/1-Genome_assembly_new -S 03Hisat2_align/${name}_1.sam  -1 03Hisat2_align/${name}_2_1_val_1.clean.fq.gz -2 03Hisat2_align/${name}_2_2_val_2.clean.fq.gz  2>&1 03Hisat2_align/${name}_2_error.ht2.log 
#}&
#done
#wait
#it combine summary.txt file
#cat ./1_samfiles/*_summary.txt > ./1_samfiles/all_summary.txt

#for i in 03Hisat2_align/s1.sam 03Hisat2_align/s2.sam 03Hisat2_align/s3.sam;do
##{
#name=${i#*/}
#name=${name%.*}
#    grep 'NH:i:1\b' ${i}  > 03Hisat2_align/${name}_unique.sam  
#    grep '@SQ'  ${i} > 03Hisat2_align/${name}_header_unique.sam  
#    cat  03Hisat2_align/${name}_header_unique.sam 03Hisat2_align/${name}_unique.sam  > 03Hisat2_align/${name}_all.sam 
#    rm 03Hisat2_align/${name}_unique.sam 03Hisat2_align/${name}_header_unique.sam
#    samtools view -bS  03Hisat2_align/${name}_all.sam  > 03Hisat2_align/${name}_all.bam
#    rm 03Hisat2_align/${name}_all.sam
#    java -jar /home/software/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar  SortSam -I 03Hisat2_align/${name}_all.bam -O 03Hisat2_align/${name}_sorted.bam -SORT_ORDER coordinate > 03Hisat2_align/${name}_sort.log 2>&1 
#    rm 03Hisat2_align/${name}_all.bam 
#     java -jar /home/software/gatk-4.1.2.0/gatk-package-4.1.2.0-local.jar  MarkDuplicates -I 03Hisat2_align/${name}_sorted.bam -O 03Hisat2_align/${name}_rmdup.bam -REMOVE_DUPLICATES true -M 03Hisat2_align/${name}_marked_dup_metrics.txt > 03Hisat2_align/${name}_rmdup.log 2>&1
#   rm 03Hisat2_align/${name}_sorted.bam
#}&
#done
#wait
##it
#
#for i in 03Hisat2_align/s1_rmdup.bam 03Hisat2_align/s2_rmdup.bam 03Hisat2_align/s3_rmdup.bam;do
#{
#name=${i#*/}
#name=${name%.*}
#    /apps/users/yefei/biosoft/subread-1.6.1/bin/featureCounts -T 2  -t gene -g Name -a ~/learning/TGD_Reference/TGD2020_latest/2-Genome_GFF3_new.gff3  -o 04Feature_count/${name}_count.csv $i  >04Feature_count/${name}.log 2>&1
#}&
#done
#wait
#
#for i in 04Feature_count/s1_rmdup_count.csv 04Feature_count/s2_rmdup_count.csv 04Feature_count/s3_rmdup_count.csv;do
#{
#name=${i#*/}
#name=${name%_rm*}
#sed  '1,2d' $i >${name}.txt
#awk 'BEGIN{OFS="\t"} NR==FNR{a[$1]=0;} NR>FNR {a[$1]=$7} END{for(i in a){print i,a[i]}}' Gene_name_list  ${name}.txt > ${name}.txt-2
#mv ${name}.txt-2 ${name}.txt
#}&
#done
#wait
#
#




#for i in s1 s2 s3 w1 w2 w3 ;do
#  grep '00301770' ./gtf-counts_files/${i}_TJg.counts | cut -f 7 >>AMT.counts
#done
#for sample in s1 s2 s3 w1 w2 w3 ;do
#  awk -F '\t' '{print $1,$7,$8}' OFS='\t' ./gtf-counts_files/${sample}_py.counts > ./gtf-counts_files/${sample}_py.counts.txt
#done

#remeber shift out the blank line which result from stringtie --merge 




