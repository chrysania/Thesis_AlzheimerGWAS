# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 5 of 5: Linear Regression
# status: completed

setwd("C:/Users/chrys/Desktop/plink19")
library(dplyr)
library(qqman)

##### Linear regression #####

## Age phenotype ##
system("plink --bfile alzheimerQC --linear --pheno pheno_age.pheno --allow-no-sex --out alzheimerLinReg_Age")

# select significant SNPs
alzheimerLinReg_Age.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLinReg_Age.assoc.linear", sep="")
df_LinReg_Age <- alzheimerLinReg_Age.assoc
LinReg_SNP_Age <- df_LinReg_Age %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, BETA, STAT, P)
LinReg_SNP_Age

# Manhattan plot
manhattan(df_LinReg_Age, annotatePval = 0.00000005)

qq(df_LinReg_Age$P, main = "Q-Q plot of Linear Regression (Age) p-values")

###################


## APOE phenotype ##
system("plink --bfile alzheimerQC --linear --pheno pheno_APOE.pheno --allow-no-sex --out alzheimerLinReg_APOE")

# select significant SNPs
alzheimerLinReg_APOE.assoc <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerLinReg_APOE.assoc.linear", sep="")
df_LinReg_APOE <- alzheimerLinReg_APOE.assoc
LinReg_SNP_APOE <- df_LinReg_APOE %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, BETA, STAT, P)
LinReg_SNP_APOE

# Manhattan plot
manhattan(df_LinReg_APOE, annotatePval = 0.00000005)

qq(df_LinReg_APOE$P, main = "Q-Q plot of Linear Regression (APOE) p-values")

####################

#############################