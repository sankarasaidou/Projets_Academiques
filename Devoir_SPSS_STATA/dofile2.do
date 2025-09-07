cd "C:\Users\HP\Desktop\ISS\SPSS et STATA\Stata\StataWD"  

import excel "lari.xlsx", sheet("lari") firstrow clear /*l'importation des données*/

* use reseau energie sexe using "data.dta", clear

save "data.dta", replace

use "data.dta", clear

* création de dofile 

browse 

edit

list sitmat if revenu<=500000

describe

codebook

summarize revenu

summarize revenu, detail

tabulate sexe

tabulate sexe educ


correlate revenu salaire

correlate revenu salaire, covariance

* les opérateurs arithmétiques, de relations, et de logiques
* les fonctions

* labelisation des variables
ta sexe

label def sexy 1 "Masculin" 2 "Féminin"
label value sexe sexy

ta sexe

ta sitmat

label def lari 1 "Marie" 2 " Vie avec quelqu'un" 3 "Divorce/Separe" 4 "Veuf/Veuve" 5 "Jamais marie"
label value sitmat lari

ta sitmat

* renommer une variable

rename sitmat marital

tab marital

label variable marital "La situation matrimoniale du répondant"

tab marital

* recoder ou remplacer
* recodage de domaine 1=1 2=2 3=3 4=4 (2000/9900=2) (10000/25000=4)
ta domaine
recode domaine (1=1) (2=2) (3=3) (4=4) (2000/9900=2) (10000/15000=4)
ta domaine
* recodage de info 1=1 2=2 3=3 4=4 (5000/9900=2) (10000/25000=4)
tab info
recode info (1=1) (2=2) (3=3) (4=4) (5000/9900=2) (10000/25000=4), gen (infos)

recode salaire (99999=.)

* gen sex=sexe
replace sexe=0 if sexe==2
label def sext 1 "Masculin" 0 "Féminin"
label value sexe sext

br
* garder ou supprimer des observations

drop cotis sex

keep revenu sexe

keep if sexe==0

keep if revenu>=2000000 | revenu <=400000

use "data.dta", clear

keep if revenu>=400000 & revenu <=500000

drop if _n<=30 /*suppression des 30 premières observations*/

drop if _n==_N /*suppression de la dernière observation*/

* trier les observations 
sort sexe revenu

gsort sexe -revenu

sort revenu by sexe 

use "data.dta", clear

* ordonner les variable
aorder /* ordonne toutes les variables*/

order cotis energie domaine

* création de nouvelles variables avec arithmétiques
gen rev=cotis+salaire                                     /*addition*/
 
gen cnss=0.055*salaire                                   /*multiplication*/
 
gen taux=(salaire/revenu)*100                                 /*division*/ 

gen logvar=log(revenu)                                 /*logarithme*/ 

gen var3=int(cotis/10000)                             /*partie entière*/ 

gen gender=sexe==1                                   /*(gender est une variable dichotomique prenant la valeur 1 si sexe est égale à 1, 0 sinon)*/ 
gen urbain=milieu==1 Ou bien tabulate var2, gen(var) /* créer des variables dichotomiques pour chaque modalité de la var2*/ 

tabulate sexe, gen(gender)

*  création de nouvelles variables avec des fonctions
egen reve=sum(revenu)                             /*somme de revenu*/ 
egen sdrev=sd(revenu)                                 /*écart type de la revenu*/ 
egen rev1=rsum(cotis salaire)       /*somme des variables cotis, et salaire*/ 

*  création des percentiles
xtile quintile=revenu, nq(5)                                    /*quintile */ 
xtile decile=revenu, nq(10)                                   /*décile */

*  création de variables avec cond(x,a,b)
generate moins1M=cond(revenu <1000000,1,0) 

* encode ID, gen(maritale) /*conversion alphanumérique en numérique*/

* decode sitmat, gen(marit) /*conversion numérique en alphanumérique*/

* destring sitmat, g(c_marit) 

* tostring

* format long et large

import excel "C:\Users\HP\Desktop\ISS\SPSS et STATA\Stata\StataWD\long_format.xlsx", sheet("Feuil1") firstrow clear

save "long_format.dta", replace

reshape wide var, i(i) j(j) /*j disparait */

save "wide_format.dta", replace

reshape long var, i(i) j(j) /*j se crée */

* combinaison observation
import excel "C:\Users\HP\Desktop\ISS\SPSS et STATA\Stata\StataWD\lari1.xlsx", sheet("lari1") firstrow clear

save "lari1.dta", replace

import excel "C:\Users\HP\Desktop\ISS\SPSS et STATA\Stata\StataWD\lari2.xlsx", sheet("lari2") firstrow clear

save "lari2.dta", replace

use "lari1.dta", clear 
append using "lari2.dta" 

* combinaison variables

import excel "C:\Users\HP\Desktop\ISS\SPSS et STATA\Stata\StataWD\lari3.xlsx", sheet("lari3") firstrow clear

save "lari3.dta", replace

import excel "C:\Users\HP\Desktop\ISS\SPSS et STATA\Stata\StataWD\lari4.xlsx", sheet("lari4") firstrow clear

save "lari4.dta", replace

use "lari3.dta", clear 
sort ID 
merge 1:1 ID using "lari4.dta" 
tab _merge 

* aggregation avec collapse

use "data.dta", clear

collapse (sum) revenu, by(sexe sitmat) 
rename revenu revd 

use "data.dta", clear 
preserve                                             /*garder le fichier existant*/ 

collapse (sum) revenu, by(sexe sitmat) 
rename revenu var3 

* restore                                         /*récupérer le fichier*/

* boucles pour repetitives

use "data.dta", clear

foreach var in sitmat sexe info { 
recode `var' (.=1) 
} 

foreach var in sexe info date { 
rename `var' `var'_1 
} 


forvalues i=1/4 { 
use data.dta, clear 
keep if energie==`i'                    /* (energie est une variable codée de 1 à 4 pour l’ensemble des energies utilisées) */
save dataEnergie`i', replace 
} 

forvalues valeur=#1(#d)#2 {
instructions
} 
  

egen moyen=mean(cotis)
local x=1 
local ecart=0 
local ecarcum=0
while `x'<=_N { 
local ecart=abs(cotis[`x']-moyen) 
scalar ecarcum= `ecarcum' + `ecart'
local x=`x'+1 
}   
scalar B=_N
scalar ecarmoy= ecarcum/B

display B 
display ecarcum 
display ecarmoy

egen sigma=sd(revenu)
egen moyenne=mean(revenu)
gen depcr=(revenu-moyenne)/sigma

** Pondération

use "PMA2021_BFP2_HQFQ_v1.0_1Oct2021.dta", clear

anova relationship gender [aweight=EAweight]

regress age birth_events [aweight=FQweight] 
regress age birth_events [pweight=1/FQweight] 
scatter age gender [aweight=HHweight], mfcolor(none) 

svyset metainstanceID [pw=HHweight], strata(ur)    /*Declaration*/ 

svy: mean age, over(gender)           /*Estimation de la moyenne de age suivant le sexe*/ 
svy : tabulate gender                           /*tabulation pondérée de la variable sexe*/ 
svy : reg age birth_events            

* Tableau 
summarize age birth_events [aw=FQweight], detail 
tabstat age [aw=HHweight], stat(mean median min max N) by(gender)
  
tab gender /*tableau simple : avec une seule variable*/ 
tab gender marital_status /*les n seulement d’un tableau de croisemen*/ 
tab gender marital_status, row /*les n+% lignes*/ 
tab gender marital_status, row col /*les n+%lignes+%colonnes*/ 
tab gender marital_status, nofreq row col /*%lignes+%colonnes*/ 
table gender marital_status mcp /*les n seulement d’une table à 3 entrées*/ 
* tab gender marital_statu [aw=FQweight], row col format(%12.0g) /*tableau pondéré*/ 

use "data.dta", clear

tab sexe sitmat, sum(revenu) nofreq /*moyenne de revenu (Quantitative) vs 2 var qualitative*/ 
table sexe sitmat energie, c (mean revenu median revenu ) row col scol /*les stat des d’une variable quantitative (revenu) en fonction de 3 var qualitatives*/

  
* Test d’indépendance entre deux variables qualitatives 
table sexe sitmat, chi2       /*relation d’indépendance entre deux variables*/
* Test de corrélation de Pearson 
corr revenu salaire cotis       /*coefficient de corrélation entre les variables*/
pwcorr revenu salaire cotis, sig    /*coef. corrél. entre les variables + degré de sig*/ 
* Test de différences de moyennes 
ttest cotis=salaire            /*comparaison de la moyenne de 2 échantillons*/ 
ttest cotis=3000000        /*comparaison de la moyenne d’une variable*/ 
ttest cotis, by(sexe)     /*comparaison de la moyenne de deux groupes*/


* putexcel set "Art1_Table1_description.xls", modify sheet("Table0_caract")

logout, save(table1) excel replace : table sexe sitmat /*format Excel*/ 
logout, save(table1) word replace : table sexe sitmat /*format Word*/ 
logout, save(table1) tex replace : table sexe sitmat /*format texte*/ 
logout, save(table1) excle word ex replace : table sexe sitmat /*tous les formats*/ 
logout, save(mystuff) excel replace: table revenu salaire, c(n mpg mean mpg sd mpg median mpg)


tabout sexe sitmat energie ///
using "table3.xls", replace c(freq row col) f(0c 1p 1p) /// 
layout(cb) h1(nil) h3(nil) npos(row)
* [iw=fqwe]

local tabout "Tableau1.xls"

foreach var in sexe sitmat {
tabout `var' using `tabout', append /// 
		c(freq col) f(0 1) clab(n %) npos(row)
}

hist revenu, width(20) start(30) fraction
hist revenu, freq normal /*Ajouter la courbe de distribution normale*/ 

graph bar revenu , over(sexe) /*donne graphe de moyenne de la revenu en fonction de sexe (qualitative) (vertical) */  
graph bar (median) revenu, over(sexe) /*donne graphe de la médiane de la revenu en fonction de sexe (qualitative) (vertical) */
graph hbar revenu, over(sexe) /*donne graphe de moyenne de la revenu en fonction de sexe (qualitative) (horizontal) */

graph pie sitmat, over(sexe)    /*donne graph en secteur de la sitmat selon la sexe*/ 
graph pie revenu, over(sexe) by(sitmat energie) /*donne graph ventilé par la sitmat de la energie en fonction de sexe (qualitative)*/ 


 
twoway (scatter revenu cotis) /*donne graph de la revenu en fonct de la var sitmat*/ 
twoway (scatter revenu cotis) (lfit revenu cotis) /*donne en plus du graph de la var1 en fonction de la var2, la droite de régression */
