** FIXATION DU CHEMIN DE TRAVAIL
       cd "C:\Users\USER\Desktop\Multicolinearite"

** Importation de la base de données
import excel "database.xlsx", sheet("data2") firstrow clear

** Visualisation de la base de données
browse

** Statistiques descriptives
describe
codebook

** Regression linéaire multiple
** variable dépendante: tbn
regress tbn population femme rm rural icn isf pfi amp tgfg
** Interprétations: R2 ajusté=0.9860, P>|t|, Coefficients

** Tester la multicolinéarité
** vif >= 5, présence de multicolinéarité
vif

correlate population femme rm rural icn isf pfi amp tgfg
pwcorr population femme rm rural icn isf pfi amp tgfg
factor population femme rm rural icn isf pfi amp tgfg, correlation

** Retrait1 des variables trop corrélées: femme, population
regress tbn rm rural isf pfi amp icn tgfg

** Retester la multicolinéarité
vif

** Retrait2 des variables trop corrélées: tgfg, icn
regress tbn rm rural isf pfi amp

** Retester la multicolinéarité
vif

** Maintenant tous les VIF < 5, donc il n'y a plus de multicolinéarité entre ces variables

