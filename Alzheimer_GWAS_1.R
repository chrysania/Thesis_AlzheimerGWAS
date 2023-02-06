# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 1 of 5: Data set up & Quality control
# status: completed

setwd("C:/Users/chrys/Desktop/plink19")

##### Data set up #####

system("plink --file adgwas --make-bed --out alzheimer")

#######################



##### Quality control calculations #####

# Main QC: genotyping, hwe, maf
system("plink --bfile alzheimer --geno 0.1 --hwe 0.05 --maf 0.01 --make-bed --out alzheimerQC")

# QC1: Allele frequency
system("plink --bfile alzheimerQC --freq --out alzheimerQC1")

# QC2: Sex discrepancy
system("plink --bfile alzheimerQC --check-sex --out alzheimerQC2")

# QC3: IBD calculation
system("plink --bfile alzheimerQC --genome rel-check --out azlheimerQC3")

# QC4: PCA calculation
system("plink --bfile alzheimerQC --pca --out alzheimer_QC4")

########################################



##### PLINK Binary to VCF conversion #####
# note: coversion to .vcf is for importing to hail

system("plink --bfile alzheimerQC --recode vcf --out alzheimer_vcf")

##########################################
