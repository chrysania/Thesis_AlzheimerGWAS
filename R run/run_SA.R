# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 3 of 5: Simple Association
# status: completed

setwd("plink1.9/")
library(dplyr)

##### Simple association #####

system("plink --bfile alzheimerQC --assoc --adjust --out alzheimerSA")

# select significant SNPs
df_SA <- read.csv("C:/Users/chrys/Desktop/plink19/alzheimerSA.assoc", sep="")
SA_SNP <- df_SA %>% filter(P <= 0.00000005) %>% select(SNP, CHR, BP, A1, A2, P)
View(SA_SNP)

write.csv(SA_SNP, "data\\SA_SNP.csv", row.names=FALSE)
