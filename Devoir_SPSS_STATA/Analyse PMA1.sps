* Encoding: UTF-8.
/* Importation de la base PMA*/


GET
  STATA FILE='C:\Users\SANKARA\Desktop\Devoir_SPSS_STATA\PMA2020_stata.dta'.
DATASET NAME Jeu_de_données2 WINDOW=FRONT.


/* Pondération des observations */

WEIGHT BY FQweight.

/* Caractéristiques socio-économique des jeunes et adolescantes */
     
   /* Repartition de la population en fonction des groupe d'âge*/
   DATASET ACTIVATE Jeu_de_données2.
FREQUENCIES VARIABLES=AgeGr
  /ORDER=ANALYSIS.

     /* Selon le statut matrimonial */
     
GRAPH
  /BAR(GROUPED)=COUNT BY FQmarital_status BY AgeGr.

    /* Selon le niveau d'éducation */

GRAPH
  /BAR(GROUPED)=COUNT BY school BY AgeGr.

    /* Selon la région*/

GRAPH
  /BAR(GROUPED)=COUNT BY region BY AgeGr.
    /* Selon l'ethnie */

GRAPH
  /BAR(GROUPED)=COUNT BY ethnicity BY AgeGr.

  /* Selon le niveau de vie */

GRAPH
  /BAR(GROUPED)=COUNT BY wealth BY AgeGr.

   /* Selon le milieu de résidence */

GRAPH
  /BAR(GROUPED)=COUNT BY ur BY AgeGr.


/* Analyse bivariée */
   /* 1. Pourcentage des utilisatrices actuelles ou recentes ayant été informée*/
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
  /TABLE AgeGr BY cunselling [C][COUNT F40.0]
  /CATEGORIES VARIABLES=AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon le milieu de résidence */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=ur cunselling DISPLAY=LABEL
  /TABLE ur BY cunselling [C][COUNT F40.0]
  /CATEGORIES VARIABLES=ur ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.


/* Selon le niveau d'education de la femme */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=school cunselling DISPLAY=LABEL
  /TABLE school BY cunselling [C][COUNT F40.0]
  /CATEGORIES VARIABLES=school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Selon la situation matrimoniale */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=FQmarital_status cunselling DISPLAY=LABEL
  /TABLE FQmarital_status BY cunselling [C][COUNT F40.0]
  /CATEGORIES VARIABLES=FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

 /* Selon le niveau de vie */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=wealth cunselling DISPLAY=LABEL
  /TABLE wealth BY cunselling [C][COUNT F40.0]
  /CATEGORIES VARIABLES=wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=cunselling [1] EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* 2. Relation entre la satisfaction des services de PF et les caractéristiques sociodémographique*/
  /* entre la satisfaction et la région. Ce coefficient est de */

CORRELATIONS
  /VARIABLES=impression region
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE. /* 0.026 */
NONPAR CORR
  /VARIABLES=impression region
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE. /* -0.060*/
  
  /* entre la satisfaction et le niveau de vie */

CORRELATIONS
  /VARIABLES=impression wealth
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE. /* -0.1 */
NONPAR CORR
  /VARIABLES=impression wealth
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE. /* 0.065 */
   /* Entre la satisfaction et le groupe d'âge */
  
CORRELATIONS
  /VARIABLES=impression AgeGr
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE. /* 0.047 /*
NONPAR CORR
  /VARIABLES=impression AgeGr
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE. /* 0.025 */
  
  /* Entre la satisfaction et le milieu de résidence */

CORRELATIONS
  /VARIABLES=impression ur
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=impression ur
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.

/*   Entre la satisfaction et le niveau d'éducation */

CORRELATIONS
  /VARIABLES=impression school
  /PRINT=TWOTAIL NOSIG
  /STATISTICS DESCRIPTIVES
  /MISSING=PAIRWISE.
NONPAR CORR
  /VARIABLES=impression school
  /PRINT=SPEARMAN TWOTAIL NOSIG
  /MISSING=PAIRWISE.

  /* Sélection des jeunes et adolescantes en union */

USE ALL.
COMPUTE filter_$=(FQmarital_status = 1).
VARIABLE LABELS filter_$ 'FQmarital_status = 1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

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

 /* Par groupe d'âge */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=AgeGr cp DISPLAY=LABEL
  /TABLE AgeGr BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=AgeGr ORDER=A KEY=VALUE EMPTY=INCLUDE
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

/* En fonction du nombre d'enfant */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=birth_events cp DISPLAY=LABEL
  /TABLE birth_events BY cp [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=birth_events ORDER=A KEY=VALUE EMPTY=INCLUDE
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



/* Analyses mutivaluées /*
/* 1) Effet de la qualité du counseling sur la satisfaction des services PF reçus, en contrôlant */
  /* En fonction du niveau de vie */

FILTER OFF.
USE ALL.
EXECUTE.
DATASET ACTIVATE Jeu_de_données1.
* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression wealth DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C] BY wealth [C][LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=wealth ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction de la région */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression region DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C][LAYERPCT.COUNT PCT40.1] BY region
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=region ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction de l'ethnie */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression ethnicity DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C] BY ethnicity [COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du milieu de résidence */

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression ur DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C][LAYERPCT.COUNT PCT40.1] BY ur
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=ur ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du statut matrimonial*/

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression FQmarital_status DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C][LAYERPCT.COUNT PCT40.1] BY FQmarital_status
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=FQmarital_status ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* Enfonction du nombre d'enfant*/

* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression birth_events DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C] BY birth_events [LAYERPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95.

/* En fonction du niveau d'étude des jeunes et adolescentes */
* Tableaux personnalisés.
CTABLES
  /VLABELS VARIABLES=cunselling impression school DISPLAY=LABEL
  /TABLE cunselling [C] > impression [C][LAYERPCT.COUNT PCT40.1] BY school
  /CATEGORIES VARIABLES=cunselling impression ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=school ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/* 2 Effet de la qualité du counseling sur la continuation de la contraception */

/* Caractéristiques socio-économique des jeunes et adolescantes */
     /* Le statut matrimonial */
     
GRAPH
  /BAR(GROUPED)=COUNT BY FQmarital_status BY AgeGr.

    /* Selon le niveau d'éducation */

GRAPH
  /BAR(GROUPED)=COUNT BY school BY AgeGr.

    /* Selon la région*/

GRAPH
  /BAR(GROUPED)=COUNT BY region BY AgeGr.
    /* Selon l'ethnie */

GRAPH
  /BAR(GROUPED)=COUNT BY ethnicity BY AgeGr.

  /* Selon le niveau de vie */
GRAPH
  /BAR(GROUPED)=COUNT BY wealth BY AgeGr.

/* Selon le milieu de résidence */
GRAPH
  /BAR(GROUPED)=COUNT BY ur BY AgeGr.




