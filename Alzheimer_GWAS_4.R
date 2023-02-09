# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 4 of 5: Logistic Regression
# status: in progress

setwd("C:/Users/chrys/Desktop/plink19")
library(dplyr)

##### Logistic regression #####

# ???
system("plink --bfile alzheimerQC --logistic --all-pheno --pheno residuals.pheno --covar covariates_plink.covar --out alzheimerLogReg1")

# tests all 3 covariates: diagnosis, age, APOE
system("plink --bfile alzheimerQC --logistic --covar covariates_plink.covar --out alzheimerLogReg2")


# select significant SNPs
alzheimerLogReg2.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLogReg2.assoc.logistic", sep="")
df_LogReg <- alzheimerLogReg2.assoc
LogReg_SNP <- df_LogReg %>% filter(P <= 0.05) %>% select(SNP, CHR, BP, TEST, OR, STAT, P)
LogReg_SNP

## note: no significant SNPs

###############################