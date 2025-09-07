***Importation de la base de donnée***
import excel "G:/Mon Drive/LICENCE II/SEMESTRE 4/Econométrie des varibles qualitatives/Logit conditionnel/demoCondLogitf.xls", sheet("Données") firstrow clear

save data1_CondLogit,replace

use data1_CondLogit, clear

***Résumé des données***
summarize

***
tab modes choix



***Créer des variables indicatrices pour les modes de transport
tabulate modes, generate(mode)

*** Renommer les variables indicatrices
rename mode1 modeavion
rename mode2 modetrain
rename mode3 modebus
rename mode4 modevoiture

* Estimer le modèle logit conditionnel
clogit choix temps cout modebus modetrain modevoiture , group(sujets)
estimates store Complet

* Récupérer la log-vraisemblance du modèle estimé
scalar lnL_M = e(ll)

* Estimer le modèle réduit à la constante
clogit choix temps modebus modetrain modevoiture , group(sujets)
estimates store Restreint

**********
* Récupérer la log-vraisemblance du modèle nul
scalar lnL_0 = e(ll)

*** Effectuer le test de rapport de vraisemblance ***
lrtest Complet Restreint

* Calculer le pseudo R² de McFadden
scalar McFadden_R2 = 1 - (lnL_M / lnL_0)

* Afficher le résultat
di "Pseudo R² de McFadden : " %5.3f McFadden_R2

****************************
**Choix du meilleur modèle**
****************************

clogit choix temps cout modebus modetrain modevoiture , group(sujets)

**********************
*** Interpretation ***
**********************

***Coefficients***

***Si le coefficient est négative (-r) pour un variable explicative donnée, cela signifie pour chaque augmentation d'une unité de cette variables, la log-odds (logarithme du rapport de probabilités) de choisir cette alternative diminue de r.
***Sinon cela voudrait signifier que chaque augmentation d'une unité de cette variables, la log-odds (logarithme du rapport de probabilités) de choisir cette alternative dimunie de r.

***Odd Ratio (Exponentiel du coefficient)***
***Si l'Exponentiel du coefficient est R<1 alors une augmentation d'une unité de la variable explicative réduit la probabilité de choisir cette alternative de 1-R.        Sinon une augmentation d'une unité de la variable explicative augmente la probabilité de choisir cette alternative de R-1.

***Statistiques de Concordance: Elle définie si le modèle a une bonne capacité prédictive et elle varie entre 0.5 et 1 . si elle est egale à 0.5 elle n'assure pas une bonne capacité prédictive.

***Tests Globaux : Pour tous les trois tests, si la p_valu < 0.05 alors ,significatif, cela nous indique qu'il y'a un effet de la variable explicative sur le choix qui est statistiquement significatif.


***Normalité des residus
predict residus , residuals

swilk residus

***Odd ration***
clogit, or

***Prédire les probabilités***
predict p_choix
