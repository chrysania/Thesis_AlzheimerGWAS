# Alzheimer GWAS Thesis Project - Chrysania Lim
# Python file 3 of 4: Linear Regression Age
# status: completed

import hail as hl
from hail.plot import show
hl.init()

# data set up
data = hl.import_vcf('alzheimer_vcf_2.vcf', contig_recoding={'23': 'X', '24' : 'Y', '25': 'MT'})
data.describe()

labels = hl.import_table('covariates_hail3.csv', delimiter=';',
                        types={'FID_IID':'str', 'FID':'str', 'IID':'str', 'Diagnosis':'float64', 'Age':'float64', 'APOE':'float64', 'Region':'float64', 'PMI':'float64', 'Site':'float64', 'HybridizationDate':'float64'},
                        key='FID_IID')
labels.describe()

mt = data.annotate_cols(labels = labels[data.s])
mt.describe()
mt.count()

# Linear regression: Age
gwas_linreg_Age = hl.linear_regression_rows(y=mt.labels.Age,
                                 x=mt.GT.n_alt_alleles(),
                                 covariates=[1.0, mt.labels.Diagnosis, mt.labels.APOE],
                                 pass_through=[mt.rsid])

gwas_linreg_Age.show()