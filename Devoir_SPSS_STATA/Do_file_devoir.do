/* Fixation du dossier de travail */
cd "C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\"
/* Importation de la base */
use "PMA2020.dta", clear
/* Selection de la population d'étude */
keep if (FQ_age >= 15 & FQ_age <= 24)
keep if (FRS_result == 1 & last_night == 1)

/* Pondération */
svyset EA_ID [iw= FQweight], strata(strata) /* Déclaration du plan d'enquête*/
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

/*Labelisation de la variabl+e birth_events*/

/*recodage de la variable birth_events */

recode birth_events (0=0) (1/8=1)

label def yyy 0 "0 enfant né vivant" 1 " 1 enfant ou +"
label values birth_events yyy
label variable birth_events " Nombre d'enfants nés vivants "
ta birth_events [iw=FQweight]

/* Détermination de l'effectif total des femmes*/
gen effectif = 1
egen effectif_total =sum(effectif)
/* le nombre de femme et adolescante de la base ayant terminé le questionnaire féminin est*/ ta effectif_total [iw=FQweight]

/* Calcul de l'indice d'autonomisation */

/* Calcul du score d'autonomisation pour chaque femme */
egen autonomisation = rowmean(fp_aut_otherptr fp_aut_diffpreg fp_aut_conflict_will fp_aut_abchild fp_aut_disrupt fp_aut_switch fp_aut_confident fp_aut_conflict)
ta autonomisation [iw=FQweight]
gen indice = .
forvalues i=2/5{
	replace indice = 1 if (autonomisation >=1 & autonomisation <= 2)
	replace indice = `i' if (autonomisation >`i' & autonomisation <= `i'+1)
	replace indice = 5 if autonomisation == 5
}
label variable indice "Indice d'autonomisation pour chaque femme"
ta indice [iw=FQweight]

/* Qualité du cunselling */
egen cunselling = rowtotal(fp_side_effects fp_side_effects_instructions fp_told_other_methods fp_told_switch)
recode cunselling (1/3=0) (4=1)
replace cunselling = . if cunselling<0
label variable cunselling "Qualité du counseling pour les utilisatrices "
label def satis 0 "Non Satisfaite" 1 "Satisfaite"
label values cunselling satis
ta cunselling [iweight=FQweight]

/* Satisfaction des services de PF */
egen impression = rowtotal(return_to_provider refer_to_relative unmettot)
recode impression (0/1 =0) (2=1) (3=0)
replace impression = . if impression<0
label variable  impression "Satisfaction des services de PF reçu par les femmes"
label values impression satis
ta impression [iweight=FQweight]

/*Niveau de recherche*/
egen richesse = rowtotal(electricity radio tv mobile landline fridge tvantenna cable_subscription washmach gaselecstove improvestove dvdcd aircon computer internet wallclock charruees bicycle motorcycle animalcart canoe car motorboat owned_ask)
recode richesse (0/1=1) (2/3=2) (4/5=3) (6/7=4) (8/9=5) (10/11=6) (12/13=7) (14/15=8) (16/17=9) (18/19=10)
label variable richesse "Niveau de richesse du ménage"
ta richesse [iw=FQweight]

/* Continuation */
egen continue = rowtotal(fp_ever_use cp )
recode continue (0/1=0) (2=1)
replace continue = . if continue<0
label def continu 0 "continue" 1 "discontinue"
label values continue continu
ta continue [iw=FQweight]

/* pour calculer la continue des 12 derniers mois */ 

gen continuite=cond((stop_using_why==. & cp==1),1,0)
label def contin 0 "discontinue" 1 "continue"
label values continuite contin
ta continuite [iw=FQweight]

/* Sauvegarde de l base */
save "PMA2020_stata.dta",replace

/*Passage à SPSS pour la suite */
