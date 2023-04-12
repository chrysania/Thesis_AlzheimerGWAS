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
mt_rf = mt

covariates = [mt_rf.labels.Age, mt_rf.labels.APOE]
rf_model = vshl.random_forest_model(y=mt_rf.labels.Diagnosis,
                    x=mt_rf.GT.n_alt_alleles(),
                    covariates=covariates, 
                    seed=13, mtry_fraction=0.05,
                    min_node_size=5, max_depth=10, imputation_type="mode")
rf_model.fit_trees(500, 100)

# Capture variant importances
print(rf_model.oob_error())
impTable = rf_model.variable_importance()
impTable.show(5)

# Show the covariates importances
covImpTable = rf_model.covariate_importance()
covImpTable.show(5)

# Manhattan plot
import varspark.hail.plot as vshlplt

p = vshlplt.manhattan_imp(gwas_with_imp.importance, 
                             hover_fields=dict(ri=gwas_with_imp.rsid),
                             significance_line = None)
show(p)

# Compare logistc regression values vs. rf importance
p2 = hl.plot.scatter(x=-hl.log10(gwas_with_imp.p_value),
                    y=gwas_with_imp.importance, 
                    xlabel = '-log10(p-value)',
                    ylabel = 'gini importance',
                    hover_fields=dict(rs=gwas_with_imp.rsid, loc=gwas_with_imp.locus))
show(p2)