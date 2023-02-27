# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 3 of 5: Simple Association
# status: completed

setwd("C:/Users/chrys/Desktop/plink19")
library(dplyr)
library(qqman)

##### Simple association #####

system("plink --bfile alzheimerQC --assoc --adjust --out alzheimerSA")

# select significant SNPs
df_SA <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerSA.assoc", sep="")
SA_SNP <- df_SA %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, A2, P)
View(SA_SNP)

# Manhattan plot & qqplot
manhattan(df_SA, annotatePval = 0.00000005)

qq(df_SA$P, main = "Q-Q plot of Simple Association p-values")

##############################
