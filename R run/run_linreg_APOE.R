# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 5b of 5: Linear Regression
# status: completed

setwd("plink1.9/")
library(dplyr)

##### Linear regression #####

## APOE phenotype ##
system("plink --bfile alzheimerQC --linear --pheno pheno_APOE.pheno --allow-no-sex --out alzheimerLinReg_APOE")

# select significant SNPs
alzheimerLinReg_APOE.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLinReg_APOE.assoc.linear", sep="")
df_LinReg_APOE <- alzheimerLinReg_APOE.assoc
LinReg_SNP_APOE <- df_LinReg_APOE %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, BETA, STAT, P)
LinReg_SNP_APOE

write.csv(LinReg_SNP_APOE, "data\\LinReg_SNP_APOE.csv", row.names=FALSE)
