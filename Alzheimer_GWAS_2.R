# Alzheimer GWAS Thesis Project - Chrysania Lim
# R file 2 of 5: PCA & IBS Visualization
# status: PCA done, IBD in progress

setwd("C:/Users/chrys/Desktop/plink19")
library(tidyverse)
library(ggplot2)
library(magrittr)
library(dplyr)
library(ggpubr)

##### MDS (from IBD) #####

# IBD MDS plot
m <- read.table("alzheimerQC3.genome", header = TRUE)
head(m)

## Compute MDS
## note: processing time for this looong
mds <- m %>%
  dist() %>%          
  cmdscale() %>%
  as_tibble()
colnames(mds) <- c("Dim.1", "Dim.2")

## Plot MDS
## note: weird result, probably cut and replace w --ibs-test/--het
ggscatter(mds, x = "Dim.1", y = "Dim.2", 
          label = rownames(m),
          size = 1,
          repel = TRUE)

ggscatter(mds, x = "Dim.1", y = "Dim.2",
          size = 1,
          repel = TRUE)

# --ibs-test
system("plink --bfile alzheimerQC --read-genome alzheimerQC3.genome --cluster --ibs-test --out IBS_test1")

# inbreeding coefficient calculation
system("plink --bfile alzheimerQC --het --out het_test1")

##########################



##### PCA #####

# read in result files
eigenValues <- read_delim("alzheimer_QC4.eigenval", delim = " ", col_names = F)
eigenVectors <- read_delim("alzheimer_QC4.eigenvec", delim = " ", col_names = F)

# Proportion of variation captured by each vector
eigen_percent <- round((eigenValues / (sum(eigenValues))*100), 2)

# PCA plot
ggplot(data = eigenVectors) +
  geom_point(mapping = aes(x = X3, y = X4, color = X1), size = 3, show.legend = TRUE ) +
  geom_hline(yintercept = 0, linetype="dotted") +
  geom_vline(xintercept = 0, linetype="dotted") +
  labs(title = "PCA of Late-onset Alzheimer's Disease",
       x = paste0("Principal component 1 (",eigen_percent[1,1]," %)"),
       y = paste0("Principal component 2 (",eigen_percent[2,1]," %)"))+
  theme_minimal()

###############