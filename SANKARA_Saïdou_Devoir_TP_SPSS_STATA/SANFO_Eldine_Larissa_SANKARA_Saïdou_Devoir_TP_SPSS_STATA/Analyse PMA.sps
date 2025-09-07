* Encoding: UTF-8.

/* Importation de la base PMA*/

GET
  STATA FILE='C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\PMA2020_stata.dta'.
DATASET NAME Jeu_de_données1 WINDOW=FRONT.


/* Pondération des observations */

WEIGHT BY FQweight.

**************** Répartition des adolescantes et jeunes selon:  **********
     
      /* Selon le groupe d'âge */
     
FREQUENCIES VARIABLES=AgeGr
  /ORDER=ANALYSIS.

     /* Le statut matrimonial */
     
     * Tableaux personnalisés.

CTABLES
  /VLABELS VARIABLES=AgeGr FQmarital_status DISPLAY=LABEL
  /TABLE AgeGr [C][LAYERPCT.COUNT PCT40.1] BY FQmarital_status [C]
  /CATEGORIES VARIABLES=AgeGr FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.
     
GRAPH
  /BAR(GROUPED)=COUNT BY FQmarital_status BY AgeGr.

    /* Selon le niveau d'éducation */
    
* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=school AgeGr DISPLAY=LABEL
  /TABLE school [C][LAYERPCT.COUNT PCT40.1] BY AgeGr [C]
  /CATEGORIES VARIABLES=school AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

GRAPH
  /BAR(GROUPED)=COUNT BY school BY AgeGr.

    /* Selon la région*/
    
* Tableaux personnalisés.

CTABLES
  /VLABELS VARIABLES=region AgeGr DISPLAY=LABEL
  /TABLE region [C][LAYERPCT.COUNT PCT40.1] BY AgeGr [C]
  /CATEGORIES VARIABLES=region AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

GRAPH
  /BAR(GROUPED)=COUNT BY region BY AgeGr.

    /* Selon l'ethnie */

CTABLES
  /VLABELS VARIABLES=ethnicity AgeGr DISPLAY=LABEL
  /TABLE ethnicity [C][LAYERPCT.COUNT PCT40.1] BY AgeGr [C]
  /CATEGORIES VARIABLES=ethnicity AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

GRAPH
  /BAR(GROUPED)=COUNT BY ethnicity BY AgeGr.

  /* Selon le niveau de vie */
  
* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=wealth AgeGr DISPLAY=LABEL
  /TABLE wealth [C][LAYERPCT.COUNT PCT40.1] BY AgeGr [C]
  /CATEGORIES VARIABLES=wealth AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

GRAPH
  /BAR(GROUPED)=COUNT BY wealth BY AgeGr.

/*Selon le milieu de résidence*/

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=ur AgeGr DISPLAY=LABEL
  /TABLE ur [C][LAYERPCT.COUNT PCT40.1] BY AgeGr  [C]
  /CATEGORIES VARIABLES=ur AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

GRAPH
  /BAR(GROUPED)=COUNT BY ur BY AgeGr.


/*Selon le lieu de travail de la femme pendant le 12 mois*/

CTABLES
  /VLABELS VARIABLES=work_12mo AgeGr DISPLAY=LABEL
  /TABLE work_12mo [C][LAYERPCT.COUNT PCT40.1] BY AgeGr  [C]
  /CATEGORIES VARIABLES=work_12mo AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

GRAPH
  /BAR(GROUPED)=COUNT BY work_12mo BY AgeGr.


/* Selon le nombre d'enfant né vivant*/

CTABLES
  /VLABELS VARIABLES=birth_events AgeGr DISPLAY=LABEL
  /TABLE birth_events [C][LAYERPCT.COUNT PCT40.1] BY AgeGr  [C]
/CATEGORIES VARIABLES=birth_events AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.
birth_events

GRAPH
  /BAR(GROUPED)=COUNT BY birth_events BY AgeGr.

************* répartition des utilisatrices  (Caractéristiques des utilisatrices) ***************

      /* Sélection des utilisatrices */

USE ALL.
COMPUTE filter_$=(cp=1).
VARIABLE LABELS filter_$ 'cp=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

   /* selon le niveau de vie et le groupe d'âge */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cp FQmarital_status DISPLAY=LABEL
  /TABLE cp BY FQmarital_status [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=cp FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


************************** Analyse bivariée *********************
     ******************1. Pourcentage des utilisatrices actuelles ou recentes ayant été informée****************
    /* Sélection des utilisatrices actuelle ou recentes de méthode comtraceptive*/
    
USE ALL.
COMPUTE filter_$=(cp = 1).
VARIABLE LABELS filter_$ 'cp = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Tableaux personnalisés.
  /*  Selon les régions */

CTABLES
  /VLABELS VARIABLES=region cunselling DISPLAY=LABEL
  /TABLE region [C][LAYERPCT.COUNT PCT40.1] BY cunselling [C]
  /CATEGORIES VARIABLES=region ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

  /* Selon le groupe d'âge */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=AgeGr cunselling DISPLAY=LABEL
  /TABLE AgeGr [C][LAYERPCT.COUNT PCT40.1] BY cunselling [C]
  /CATEGORIES VARIABLES=AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon le milieu de résidence */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=ur cunselling DISPLAY=LABEL
  /TABLE ur [C][LAYERPCT.COUNT PCT40.1] BY cunselling [C]
  /CATEGORIES VARIABLES=ur ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


/* Selon le niveau d'education de la femme */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=school cunselling DISPLAY=LABEL
  /TABLE school [C][LAYERPCT.COUNT PCT40.1] BY cunselling [C]
  /CATEGORIES VARIABLES=school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon la situation matrimoniale */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=FQmarital_status cunselling DISPLAY=LABEL
  /TABLE FQmarital_status [C][LAYERPCT.COUNT PCT40.1] BY cunselling [C]
  /CATEGORIES VARIABLES=FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

 /* Selon le niveau de vie */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=wealth cunselling DISPLAY=LABEL
  /TABLE wealth [C][LAYERPCT.COUNT PCT40.1] BY cunselling [C]
  /CATEGORIES VARIABLES=wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


   ************** 2. Relation entre la satisfaction des services de PF et les caractéristiques sociodémographique**************
  /* entre la satisfaction et le niveau de vie du ménage.*/
  
CROSSTABS
  /TABLES=wealth BY impression
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT
  /COUNT ROUND CELL.

  /* Entre la satisfaction et le milieu de résidence */

CROSSTABS
  /TABLES=ur BY impression
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT
  /COUNT ROUND CELL.

/* entre la satisfaction et la situation matrimoniale/*

CROSSTABS
  /TABLES=FQmarital_status BY impression
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT
  /COUNT ROUND CELL.

/* Entre la satisfaction et le niveaiu d'éducation */

CROSSTABS
  /TABLES=school BY impression
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT
  /COUNT ROUND CELL.

/* Entre la satisfaction et l'ethnie */

CROSSTABS
  /TABLES=ethnicity BY impression
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT
  /COUNT ROUND CELL.

/* Entre la satisfaction et la region d'habitation*/

CROSSTABS
  /TABLES=region BY impression
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI 
  /CELLS=COUNT
  /COUNT ROUND CELL.


**********************3)Taux de prévalence contraceptive des adolescentes et jeunes (toutes )  **************

/* Selon le groupe d'âge */

CTABLES
  /VLABELS VARIABLES=AgeGr cp DISPLAY=LABEL
  /TABLE AgeGr [C] BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cp [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Taux de prévalence par région */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=region cp DISPLAY=LABEL
  /TABLE region [C] BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=region ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cp [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Par milieu de résidence */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=ur cp DISPLAY=LABEL
  /TABLE ur BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=ur ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cp [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

 /* Par Niveau d'éducation */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=school cp DISPLAY=LABEL
  /TABLE school BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cp [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du niveau de vie */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=wealth cp DISPLAY=LABEL
  /TABLE wealth BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cp [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/***** 4) Pourcentage d’adolescentes et jeunes utilisatrices de la contraception qui ont discontinué une méthode contraceptive au cours des 12 mois suivant le début de son utilisation, en fonction de la raison de discontinuation, selon la méthode*/

USE ALL.
COMPUTE filter_$=(continuite=0).
VARIABLE LABELS filter_$ 'continuite=0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=AgeGr stop_using_why DISPLAY=LABEL
  /TABLE AgeGr [C] BY stop_using_why [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=AgeGr stop_using_why ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=AgeGr current_methodnum DISPLAY=LABEL
  /TABLE AgeGr [C] BY current_methodnum [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=AgeGr current_methodnum ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/*  5)Taux de continuation de la contraception à 12 mois selon les caractéristiques sociodémographiques des adolescentes et jeuness*/


/*Selon le groupe d'âge */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=continuite AgeGr DISPLAY=LABEL
  /TABLE continuite BY AgeGr [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=continuite AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon du milieu de residence*/

CTABLES
  /VLABELS VARIABLES=continuite ur DISPLAY=LABEL
  /TABLE continuite BY ur [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=continuite ur ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon le niveau d'education*/

CTABLES
  /VLABELS VARIABLES=continuite school DISPLAY=LABEL
  /TABLE continuite BY school [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=continuite school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon le statut matrimonial*/

CTABLES
  /VLABELS VARIABLES=continuite FQmarital_status DISPLAY=LABEL
  /TABLE continuite BY FQmarital_status [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=continuite FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon le niveau de vie du ménage*/

CTABLES
  /VLABELS VARIABLES=continuite wealth DISPLAY=LABEL
  /TABLE continuite BY wealth [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=continuite wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.



****************** Analyses mutivariées *******************
*************** 1) Effet de la qualité du counseling sur la satisfaction des services PF reçus, en contrôlant ***************
        /* Enlever la sélection des variables */

FILTER OFF.
USE ALL.
EXECUTE.
DATASET ACTIVATE Jeu_de_données1.

      /* En fonction du niveau de vie */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=impression cunselling wealth DISPLAY=LABEL
  /TABLE impression [C] > cunselling [C][LAYERPCT.COUNT PCT40.1] BY wealth [C]
  /CATEGORIES VARIABLES=impression cunselling wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction de la région */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=impression cunselling region DISPLAY=LABEL
  /TABLE impression [C] > cunselling [C][LAYERPCT.COUNT PCT40.1] BY region
  /CATEGORIES VARIABLES=impression cunselling region ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

   /* En fonction de l'ethnie */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression ethnicity DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C] BY ethnicity [SUBTABLEPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du milieu de résidence */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=impression cunselling ur DISPLAY=LABEL
  /TABLE impression [C] > cunselling [C][LAYERPCT.COUNT PCT40.1] BY ur
  /CATEGORIES VARIABLES=impression cunselling ur ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du statut matrimonial*/

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=impression cunselling FQmarital_status DISPLAY=LABEL
  /TABLE impression [C] > cunselling [C][LAYERPCT.COUNT PCT40.1] BY FQmarital_status
  /CATEGORIES VARIABLES=impression cunselling FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Enfonction du nombre d'enfant*/

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression birth_events DISPLAY=LABEL
  /TABLE cunselling > impression [C] BY birth_events [S][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du niveau d'étude des jeunes et adolescentes */
 
 *Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=impression cunselling school DISPLAY=LABEL
  /TABLE impression [C] > cunselling [C][LAYERPCT.COUNT PCT40.1] BY school
  /CATEGORIES VARIABLES=impression cunselling school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/********** Régression logistique multinomiale ******

NOMREG impression (BASE=LAST ORDER=ASCENDING) BY cunselling AgeGr wealth ur FQmarital_status school 
    region
  /CRITERIA CIN(95) DELTA(0) MXITER(100) MXSTEP(5) CHKSEP(20) LCONVERGE(0) PCONVERGE(0.000001) 
    SINGULAR(0.00000001)
  /MODEL
  /STEPWISE=PIN(.05) POUT(0.1) MINEFFECT(0) RULE(SINGLE) ENTRYMETHOD(LR) REMOVALMETHOD(LR)
  /INTERCEPT=INCLUDE
  /PRINT=PARAMETER SUMMARY LRT CPS STEP MFI.

/* 2 Effet de la qualité du counseling sur la continuation de la contraception */

DATASET ACTIVATE Jeu_de_données1.

FILTER OFF.
USE ALL.
EXECUTE.

**** *****2) Effet de la qualité du counseling sur la continuation de la contraception, ***********

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling continue AgeGr DISPLAY=LABEL
  /TABLE cunselling > continue [LAYERPCT.COUNT PCT40.1] BY AgeGr
  /CATEGORIES VARIABLES=cunselling ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=continue AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

DATASET ACTIVATE Jeu_de_données1.

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling continue wealth DISPLAY=LABEL
  /TABLE cunselling > continue [C][LAYERPCT.COUNT PCT40.1] BY wealth [C]
  /CATEGORIES VARIABLES=cunselling ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=continue wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling continue region DISPLAY=LABEL
  /TABLE cunselling [C] > continue [C][LAYERPCT.COUNT PCT40.1] BY region
  /CATEGORIES VARIABLES=cunselling ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=continue region ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling continue FQmarital_status DISPLAY=LABEL
  /TABLE cunselling [C] > continue [C][LAYERPCT.COUNT PCT40.1] BY FQmarital_status
  /CATEGORIES VARIABLES=cunselling ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=continue FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling continue school DISPLAY=LABEL
  /TABLE cunselling [C] > continue [C][LAYERPCT.COUNT PCT40.1] BY school
  /CATEGORIES VARIABLES=cunselling ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=continue school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.
/***FIN  ***/

