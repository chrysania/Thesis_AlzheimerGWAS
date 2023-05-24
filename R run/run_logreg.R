# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 4 of 5: Logistic Regression
# status: completed

setwd("./plink1.9")
library(dplyr)

##### Logistic regression #####

# Diagnosis phenotype
system("plink --bfile alzheimerQC --logistic --pheno pheno_diagnosis.pheno --allow-no-sex --out alzheimerLogReg")

# select significant SNPs
alzheimerLogReg.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLogReg.assoc.logistic", sep="")
df_LogReg <- alzheimerLogReg.assoc
LogReg_SNP <- df_LogReg %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, TEST, OR, STAT, P)
LogReg_SNP

write.csv(LogReg_SNP, "data\\LogReg_SNP.csv", row.names=FALSE)
