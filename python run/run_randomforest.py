# Alzheimer GWAS Thesis Project - Chrysania Lim
# Python file 4 of 4: Random Forest
# status: in progress

import hail as hl
import varspark.hail as vshl
vshl.init()

from hail.plot import show

# data set up
data = hl.import_vcf('alzheimer_vcf_2.vcf', contig_recoding={'23': 'X', '24' : 'Y', '25': 'MT'})
data.describe()

labels = hl.import_table('covariates_hail3.csv', delimiter=';',
                        types={'FID_IID':'str', 'FID':'str', 'IID':'str', 'Diagnosis':'float64', 'Age':'float64', 'APOE':'float64', 'Region':'float64', 'PMI':'float64', 'Site':'float64', 'HybridizationDate':'float64'},
                        key='FID_IID')

mt = data.annotate_cols(labels = labels[data.s])
mt.describe()
mt.count()


# Logistic regression
gwas_logreg_diagnosis = hl.logistic_regression_rows(test='score',
                                y=mt.labels.Diagnosis,
                                 x=mt.GT.n_alt_alleles(),
                                 covariates=[1.0, mt.labels.Age, mt.labels.APOE],
                                 pass_through=[mt.rsid])
gwas_logreg_diagnosis.show(5)


# Random Forest
rf_model = vshl.random_forest_model(y=mt.labels.Diagnosis,
                    x=mt.GT.n_alt_alleles(), 
                    covariates={'age':mt.labels.Age, 'APOE':mt.labels.APOE},
                    seed=13, mtry_fraction=0.05,
                    min_node_size=5, max_depth=10, imputation_type="mode")
rf_model.fit_trees(500, 100)

# Capture variant importances
impTable = rf_model.variable_importance()
impTablePD = impTable.to_pandas()
filepath = Path('out1.csv')
impTablePD.to_csv(filepath)

# Show the covariates importances
covImpTable = rf_model.covariate_importance()
covTablePD = covImpTable.to_pandas()
filepath = Path('out2.csv')
covTablePD.to_csv(filepath)
