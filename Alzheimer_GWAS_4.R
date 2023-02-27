# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 4 of 5: Logistic Regression
# status: in progress

setwd("C:/Users/chrys/Desktop/plink19")
library(dplyr)
library(qqman)

##### Logistic regression #####

# all pheno setting
system("plink --bfile alzheimerQC --logistic --all-pheno --pheno residuals.pheno --covar covariates_plink.covar --out alzheimerLogReg1")

# tests all 3 covariates: diagnosis, age, APOE
system("plink --bfile alzheimerQC --logistic --covar covariates_plink.covar --out alzheimerLogReg2")

# test all default covariates
system("plink --bfile alzheimerQC --logistic --covar samples.covar --out alzheimerLogReg3")

# no covariates
system("plink --bfile alzheimerQC --logistic --out alzheimerLogReg4")

## note: only no covar succeeded


# select significant SNPs (no covar)
alzheimerLogReg4.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLogReg4.assoc.logistic", sep="")
df_LogReg <- alzheimerLogReg4.assoc
LogReg_SNP <- df_LogReg %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, TEST, OR, STAT, P)
LogReg_SNP

# Manhattan plot & qqplot
manhattan(df_LogReg, annotatePval = 0.00000005, ylim = c(0, 18))

qq(df_LogReg$P, main = "Q-Q plot of Logistic Regression p-values")

###############################
