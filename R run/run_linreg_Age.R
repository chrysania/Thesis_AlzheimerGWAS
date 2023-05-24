# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 5a of 5: Linear Regression APOE
# status: completed

setwd("plink1.9/")
library(dplyr)

##### Linear regression #####

## Age phenotype ##
system("plink --bfile alzheimerQC --linear --pheno pheno_age.pheno --allow-no-sex --out alzheimerLinReg_Age")

# select significant SNPs
alzheimerLinReg_Age.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLinReg_Age.assoc.linear", sep="")
df_LinReg_Age <- alzheimerLinReg_Age.assoc
LinReg_SNP_Age <- df_LinReg_Age %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, BETA, STAT, P)
LinReg_SNP_Age

write.csv(LinReg_SNP_Age, "data\\LinReg_SNP_Age.csv", row.names=FALSE)
