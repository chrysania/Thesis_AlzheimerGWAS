# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 4 of 5: Logistic Regression
# status: completed

setwd("C:/Users/chrys/Desktop/plink19")
library(dplyr)
library(qqman)

##### Logistic regression #####

# Diagnosis phenotype
system("plink --bfile alzheimerQC --logistic --pheno pheno_diagnosis.pheno --allow-no-sex --out alzheimerLogReg")

# select significant SNPs
alzheimerLogReg.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLogReg.assoc.logistic", sep="")
df_LogReg <- alzheimerLogReg.assoc
LogReg_SNP <- df_LogReg %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, TEST, OR, STAT, P)
LogReg_SNP

# Manhattan plot & qqplot
manhattan(df_LogReg, annotatePval = 0.00000005, ylim = c(0, 18))

qq(df_LogReg$P, main = "Q-Q plot of Logistic Regression p-values")

###############################