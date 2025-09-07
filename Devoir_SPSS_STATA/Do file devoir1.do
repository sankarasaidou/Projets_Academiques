/* Fixation du dossier de travail */
cd "C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\"

/* Importation de la base */
use "PMA2020.dta", clear
/* Selection de la population d'étude */
keep if (FQ_age >= 15 & FQ_age <= 24)
keep if (FRS_result == 1 & last_night == 1)

/* Elimination des valeurs manquantes */
foreach var in fp_aut_otherptr fp_aut_diffpreg fp_aut_conflict_will fp_aut_abchild fp_aut_disrupt fp_aut_switch fp_aut_confident fp_aut_conflict fp_side_effects fp_side_effects_instructions fp_told_other_methods fp_told_switch {
	keep if (`var' !=-99)
	keep if (`var' !=-88)
	keep if (`var' !=-77)
}

/* Pondération */
svyset EA_ID [iw= FQweight], strata(strata) /* Déclaration du plan d'enquête*/

tab EA_ID
/* Labelisation de la variable school*/
recode school (0=1) (1=2) (2/4=3)
label def etude 1 "Aucun" 2 "Primaire" 3 "Secondaire ou plus"
label value school etude 
label variable school "Niveau d'éducation de la femme "
ta school [iw=FQweight]

/* Labelisation de la variable FQmarital_status */
recode FQmarital_status (1/2=1) (3/5=2)
label def marital 1 "En union" 2 "Pas en union"
label value FQmarital_status marital
label variable FQmarital_status "Statut matrimonial de la femme"
ta FQmarital_status [iw=FQweight]

/* Création de la variable groupe d'âge*/
recode FQ_age (15/19=1) (20/24=2), gen(AgeGr)
label def groupe 1 "Adolescente" 2 "Jeune"
label value AgeGr groupe
label variable AgeGr "Groupe d'âge de la femme "
ta AgeGr [iw=FQweight]

/* Labelisation de la variable ur qui donne le milieu d'occupation */
label def occup 1 "Urbain" 2 "Rural"
label value ur occup
label variable ur "Milieu de résidence de la femme "
ta ur [iw=FQweight]

/* Labelisation de la variable wealth */
label def rich 1 "Pauvre" 2 "Moyen" 3 "Riche"
label value wealth rich
label variable wealth "Niveau de vie du ménage"
ta wealth [iw=FQweight]

/* Labelisation de la variable work_12mo */
label def work 0 "Non" 1 "Oui" 
label value work_12mo work
label variable work_12mo " A travaillé en dehors de la maison au cours des 12 derniers mois"
ta work_12mo [iw=FQweight]

/*Labelisation de la variable birth_events*/

/*recodage de la variable birth_events */

recode birth_events (0=0) (1/8=1)

label def yyy 0 "0 enfant né vivant" 1 " 1 enfant ou +"
label values birth_events yyy
label variable birth_events " Nombre d'enfants nés vivants "
ta birth_events [iw=FQweight]

/* Détermination de l'effectif total des femmes*/
gen effectif =1
egen effectif_total =sum(effectif)
/* le nombre de femme et adolescante de la base ayant terminé le questionnaire féminin est*/ svy: ta effectif_total

/* Calcul de l'indice d'autonomisation */

/* Calcul du score d'autonomisation pour chaque femme */
egen autonomisation = rowtotal(fp_aut_otherptr fp_aut_diffpreg fp_aut_conflict_will fp_aut_abchild fp_aut_disrupt fp_aut_switch fp_aut_confident fp_aut_conflict)
gen autonomisation1 =(autonomisation/ 8) /* Indice d'autonomisation pour chaque femme */
svy: ta autonomisation1
scalar sommetotale = sum(autonomisation1) 
gen indice_autonomisation = (sommetotale/effectif_total)
/* l'indice d'autonomisation globale est*/ svy: ta indice_autonomisation

egen cunselling = rsum (fp_side_effects fp_side_effects_instructions fp_told_other_methods fp_told_switch)
recode cunselling (1/3=0) (4=1)
egen qualite = sum(cunselling)
gen IIM = (qualite/effectif_total)
label variable IIM "Qualité du counseling"
svy: ta IIM 
egen use_moderne =sum(mcp)
gen qualite_cunselling = (qualite/use_moderne)
label variable qualite_cunselling "Qualité du counseling pour les utilisatrices de méthodes modernes"
svy: ta qualite_cunselling

/* Satisfaction des services de PF */
gen impression = cond((return_to_provider ==1 & refer_to_relative ==1 & unmettot ==0),1,0)
egen impression1 = sum(impression)
gen satisfaction = (impression1/effectif_total)
label variable  satisfaction "Satisfaction des services de PF reçu par les femmes"
svy: ta satisfaction
gen satisfaction1 = (impression1/use_moderne)
label variable satisfaction1 "Satisfaction des services de PF reçu par les utilisatrices de méthodes modernes"
ta satisfaction1 [iweight=FQweight]


/* Continuation */
gen continue = cond((fp_ever_use==1 & current_user==1),1,0)
label def continu 0 "continue" 1 "discontinue"
label values continue continu
svy: ta continue
foreach var in birth_events FQmarital_status ur school work_12mo  wealth {
	svy: tab `var' AgeGr
}
save "PMA2020_stata.dta",replace

/* Repartition des adolescantes et jeunes selon leurs caractéristiques socio demographiques*/

*Selon ages

tab AgeGr [iw=FQweight]

* Selon le Nombre d'enfants nés vivants

svy: tab birth_events AgeGr

graph pie AgeGr , over(birth_events)

*Selon le Statut matrimonial de la femme

svy: tab FQmarital_status AgeGr
 
graph pie AgeGr , over(FQmarital_status) 

*Selon le  Milieu de résidence de la femme

svy: tab ur AgeGr

graph bar AgeGr,over(ur) by(FQweight)

*Selon  Niveau d'éducation de la femme
svy: tab school AgeGr

 graph pie AgeGr ,over(school)
 
*Selon  A travaillé en dehors de la maison au cours des 12 derniers mois

svy: tab  work_12mo AgeGr
graph pie AgeGr , over(work_12mo)

*Selon le niveau de vie du ménage

svy: tabulate wealth AgeGr

graph pie AgeGr,over(wealth)

*Selon l'indice d'autonomie de la femme

svy: tabulate  indice_autonomisation AgeGr



*Selon la situation matrimoniale et Nombre d'enfants née vivants


graph pie AgeGr ,over(FQmarital_status birth_events AgeGr)


*Selon le mileu de residence et Nomdre d'enfants nés vivants

graph pie AgeGr ,over(ur birth_events AgeGr)


*Selon la variable region
svy: tab region AgeGr

graph pie AgeGr , over(region)



/* Passage à SPSS pour la suite*/

/*Analyses bivariées */

/*• Pourcentage d'utilisatrices actuelles ou récentes ayant été informées par un prestataire 
sur les effets secondaires, sur ce qu'il faut faire en cas d'effets secondaires, sur d'autres 
méthodes contraceptives, et sur la possibilité de changer de méthode, selon leurs 
caractéristiques sociodémographiques*/

/*Selon le statu matrimonial de la femme*/


gen cpq1= cunselling if(cp==1)


tab cpq1 FQmarital_status,row
graph bar cpq1 ,over(FQmarital_status)

* Selon le Nombre d'enfants nés vivants

tab cpq1 birth_events ,row

graph pie AgeGr , over(birth_events)

*Selon le Statut matrimonial de la femme

tab FQmarital_status AgeGr
 
graph pie AgeGr , over(FQmarital_status)

*Selon le  Milieu de résidence de la femme

tab ur AgeGr

graph pie AgeGr,over(ur)

*Selon  Niveau d'éducation de la femme
tab school AgeGr

 graph pie AgeGr ,over(school)
 
*Selon  A travaillé en dehors de la maison au cours des 12 derniers mois

tab  work_12mo AgeGr
graph pie AgeGr , over(work_12mo)

*Selon le niveau de vie du ménage

tabulate wealth AgeGr

graph pie AgeGr,over(wealth)

*Selon l'indice d'autonomie de la femme

tabulate  indice_autonomisation AgeGr



*Selon la situation matrimoniale et Nombre d'enfants née vivants


graph pie AgeGr ,over(FQmarital_status birth_events AgeGr)


*Selon le mileu de residence et Nomdre d'enfants nés vivants

graph pie AgeGr ,over(ur birth_events AgeGr)


*Selon la variable region
tab region AgeGr

graph pie AgeGr , over(region)

*SElon la variable ethnie
tab ethnicity AgeGr

graph bar AgeGr , over(ethnicity)
/*Relation entre la satisfaction des services PF reçus et les caractéristiques 
sociodémographiques des adolescentes et jeunes*/


* Selon le Nombre d'enfants nés vivants


correlate impression birth_events 

*Selon le  Milieu de résidence de la femme

correlate impression ur

*Selon  Niveau d'éducation de la femme

correlate impression school 
 
*Selon  A travaillé en dehors de la maison au cours des 12 derniers mois

correlate impression work_12mo 

*Selon le niveau de vie du ménage

correlate impression wealth 

*Selon la variable region
correlate impression region

*Selon la situation matrimoniale
correlate impression FQmarital_status,row

/*Taux de prévalence contraceptive des adolescentes et jeunes (toutes ou en union) selon 
leurs caractéristiques sociodémographiques*/

tabulate AgeGr, summarize(cp)
tabulate AgeGr,cp

tab cp


gen cpq2=cp if(cp==1)
tab (region FQ_age) cp ,row


/*Pourcentage d'adolescentes et jeunes utilisatrices de la contraception qui ont 
discontinué une méthode contraceptive au cours des 12 mois suivant le début de son 
utilisation, en fonction de la raison de discontinuation, selon la méthode*/

/*Taux de continuation de la contraception à 12 mois selon les caractéristiques 
sociodémographiques des adolescentes et jeunes*/








stata

/* Taux de prévalence contraceptive des adolescentes et jeunes en union selon leurs caractéristiques sociodémographiques */

/* Assurez-vous d'adapter les noms des variables selon votre base de données */

/* Par âge */
tabulate AgeGr, row contraceptive_prevalence

/* Par nombre d'enfants nés vivants */
tabulate region, row (cp)

table FQmarital_status, contents(cp) format(%11.2f)

table ur, contents(cp)

tabulate region cp, percent 






les variables pour discontinuation:

tab calendar_c2_full  
 ;calendar_c1_full


tabulate cunselling impression wealth, row
 
 tab wealth 
