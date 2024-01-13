/apps/users/yefei/biosoft/subread-1.6.1/bin/featureCounts -T 10 -O -t transcript -g transcript_id -a /apps/users/yefei/learning/pper_genome/RNA-seq/05ORFfinder/12veg-cyst_assembly_orffinder-otf0_longest.gtf -o 04Feature_count/Pper_count.csv 03Hisat2_align/SB210-SP-1align2Pper_rmdup.bam 03Hisat2_align/SB210-SP-2align2Pper_rmdup.bam 03Hisat2_align/SB210-SP-3align2Pper_rmdup.bam 03Hisat2_align/A1-KO-SP-1align2Pper_rmdup.bam 03Hisat2_align/A1-KO-SP-2align2Pper_rmdup.bam 03Hisat2_align/A1-KO-SP-3align2Pper_rmdup.bam


/apps/users/yefei/biosoft/subread-1.6.1/bin/featureCounts -T 10 -t gene -g Name -a /apps/users/yefei/learning/TGD_Reference/TGD2020_latest/2-upd-Genome-GFF3-latest-2.gff3 -o 04Feature_count/Tthe_count.csv 03Hisat2_align/SB210-SP-1align2Tthe_rmdup.bam 03Hisat2_align/SB210-SP-2align2Tthe_rmdup.bam 03Hisat2_align/SB210-SP-3align2Tthe_rmdup.bam 03Hisat2_align/A1-KO-SP-1align2Pper_rmdup.bam 03Hisat2_align/A1-KO-SP-2align2Pper_rmdup.bam 03Hisat2_align/A1-KO-SP-3align2Pper_rmdup.bam


