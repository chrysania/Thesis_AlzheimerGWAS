# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 5 of 5: Linear Regression
# status: in progress

setwd("C:/Users/chrys/Desktop/plink19")
library(dplyr)

##### Linear regression #####

# tests all 3 covariates: diagnosis, age, APOE
system("plink --bfile alzheimerQC --linear --pheno residuals.pheno --covar covariates_plink.covar --out alzheimerLinReg1")

# select significant SNPs
alzheimerLinReg1.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLinReg1.assoc.linear", sep="")
df_LinReg <- alzheimerLinReg1.assoc
LinReg_SNP <- df_LinReg %>% filter(P <= 0.05) %>% select(SNP, CHR, BP, TEST, STAT, P)
LinReg_SNP

## note: too many SNPs with P<=0.05, but none with P<=5e-8

#############################