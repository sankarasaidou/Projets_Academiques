use "C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\PMA2020.dta"
cd "C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\"
use "PMA2020.dta", clear
br
/* 	Extraction de la base sur laquelle tout le travai se porté nommée "baseFinale" 

keep FQmetainstanceID FQacquainted FRS_result birthdateSIF FQ_age school_grade FQmarital_status birthdateSIF first_birthSIF recent_birthSIF  birth_events  ever_preg_end FQstart FQend ur wealth FQweight eligible work_12mo fp_side_effects  fp_side_effects_instructions  fp_told_other_methods  fp_told_switch  return_to_provider  current_user */

/*import de la base baseFinale

cd"C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\"
use "PMA2020_Base_Finale",clear
br  */

/* Traitements des valeurs manquantes de la variable FQmarital_status */
drop if FQmarital_status==-99
tab FQmetainstanceID
drop if return_to_provider==-99
drop if return_to_provider==-88

drop if fp_told_other_methods==-88

drop if fp_side_effects_instructions==-99

drop if fp_side_effects==-99

drop if work_12mo==-99

drop if FQmarital_status==-99

drop if school_grade==-99

drop if birth_events == -99

/* labelisation des variables de la base "baseFinale"  */

recode FQmarital_status (1=1) (2=1) (3=2) (4=2) (5=2)
 
label def sitmat1 1 "En union" 2 "Pas en union" 
label value FQmarital_status  sitmat1 
tab FQmarital_status 


/* pour la variable ur */

label def vss 2 "Rural"  1 "Urbain"
label values ur vss
tab ur

/* pour la variable work_12mo */

label def aab 0 "Non" 1 "Oui"
label values work_12mo aab
tab work_12mo

/* pour la variable school_grade */

/* Recodons d'abord la variable*/
 recode  school_grade (0=0) (1=1)  (2/2020 =2)
br
label def dee 0 "Aucun" 1 "Primaire" 2 "Secondaire ou plus"
label values school_grade dee
tab  school_grade

/* pour la variable Weathl: niveau de vie */

label def sss 1 "Pauvre" 2 "Moyen" 3 "Riche"
label values wealth sss
tab wealth

/*Subdivision de la variable age en tranche 
use "PMA2020_Base_Finale0" ,clear
generate FQ_age_15_19ans=(FQ_age<=19)

tab FQ_age_15_19ans


generate FQ_age_20_24ans=(FQ_age<=24 & FQ_age>=20)

tab FQ_age_20_24ans
*/

/*reduction de la variable FQ_age à (15-24ans) */

keep if (FQ_age<=24 & FRS_result==1 & last_night==1)

/*recodage de la variable FQ_age (15/19 = 1) (20/24 = 2)*/


recode FQ_age (15/19 = 1) (20/24 = 2) 

/*recodage de la variable birth_events */

recode birth_events (0=0) (1/8=1)

/*Labelisation de la variable birth_events*/

label def yyy 0 "0 enfant né vivant" 1 " 1 enfant +"
label values birth_events yyy

label variable birth_events " Nombre d'enfants nés vivants "



/*Labelisation de la variable FQ_age*/

label def sasa 1 "Adolescente" 2 "Jeune"
label values FQ_age sasa

label variable FQ_age "Groupe d'âge des femmes"



/* calcul de la variable indice*/



/* sommes*/

recode fp_aut_otherptr (-99=0)  (-88=0)
recode fp_aut_diffpreg (-99=0)  (-88=0)
recode fp_aut_conflict (-99=0) (-88=0 )
recode fp_aut_conflict_will (-99=0 ) (-88=0)
recode fp_aut_abchild (-99=0 ) (-88=0)
recode fp_aut_disrupt (-99=0)  (-88=0)
recode fp_aut_switch (-99=0 ) (-88=0)
recode fp_aut_confident (-99=0)  (-88=0)

egen somme1=rsum(fp_aut_otherptr fp_aut_diffpreg fp_aut_conflict fp_aut_conflict_will fp_aut_abchild fp_aut_disrupt fp_aut_switch fp_aut_confident ) 

egen sommetotale=sum(somme1)
gen autonomie=(sommetotale/8)

gen indice_autonomie =(autonomie/2733)

label variable indice_autonomie "l'indice d'autonomie des femmes"

tab indice_autonomie
  /*Caractéristiques de la population */



/*Répartition des adolescentes et jeunes selon leurs caractéristiques 
sociodémographiques*/

*Selon ages

tab FQ_age

* Selon le Nombre d'enfants nés vivants

tab birth_events FQ_age
graph bar FQ_age , over(birth_events)

graph pie FQ_age , over(birth_events)

*Selon le Statut matrimonial de la femme

tab FQmarital_status FQ_age

graph bar FQ_age , over(FQmarital_status) 

graph pie FQ_age , over(FQmarital_status)

*Selon le  Milieu de résidence de la femme

tab ur FQ_age

graph bar FQ_age , over(ur)

graph pie FQ_age,over(ur)

*Selon  Niveau d'éducation de la femme
tab school_grade FQ_age

 graph bar FQ_age , over(school_grade)
 graph pie FQ_age,over(school_grade)
 
*Selon  A travaillé en dehors de la maison au cours des 12 derniers mois

tab  work_12mo
graph bar FQ_age , over(work_12mo)

*Selon le niveau de vie du ménage

tabulate wealth FQ_age
graph bar FQ_age , over(wealth)

graph pie FQ_age,over(wealth)

*Selon l'indice d'autonomie de la femme

tabulate  indice_autonomie FQ_age


/*Analyses bivariées */











