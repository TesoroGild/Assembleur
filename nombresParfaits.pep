; *********************************************************************************************************
;       Programme: nombresParfiats.pep
;       PEP/8 version 8.2 sous Windows
;
;       Programme qui demande un nombre à l'utilisateur
;       puis affiche la somme et dit s'il s'agit d'un
;       nombre parfait ou non.
;       Lorsqu'il y a débordement, la somme n'est pas
;       affichée et le programme affiche directement
;       que le nombre n'est pas parfait.
;       L'entier 1 est particulier car il n'y a pas
;       de débordment mais on affiche pas la somme
;       de ses diviseurs. Le programme affiche
;       directemetn qu'il n'est pas un nombre parfait.
;
;       auteur:   BOSSOU Gildérick Elikem & BARBOSA DA SILVA ALVES Diana Carolina
;       codePerm: BOSG64080108 & BARD15568309
;       courriel: bossou.gilderick_elikem@courriel.uqam.ca & barbosa_da_silva_alves.diana@courrier.uqam.ca
;       session:  Hiver 2022
;       date dernière modification: 2022-02-16
;       cours:    INF2171
; *********************************************************************************************************

         ;T : signifie traitement

         LDA     cmpEss,d    ;
essai:   STRO    msgEssai,d  ; affiche le string msgEssai
         DECO    cmpEss,d    ; affiche le nombre d'essai
         STRO    entree,d    ; affiche message de solicitation
         DECI    entier,d    ; saisie de la valeur au clavier

         ;=======================
         ;VALIDATION DE LA SAISIE
         ;=======================
         LDA     entier,d    ;
         CPA     max,d       ; compare la valeur saisie avec la valeur max
         BRGT    comp        ;    si (entier > max) allez au T : entre  invalide
         CPA     min,d       ; si non, compare la valeur saisie avec la valeur min
         BRLT    comp        ;    si (entier < min) allez au T : entre  invalide
         CPA     1,i         ; si non, compare la valeur saisie avec 1 
         BREQ    non         ;    si (entier == 1) allez au T : nombre non parfait
         BR      loop2       ; T : entree valide

         ;=========================================
         ;TRAITEMENT SI L'ENTIER SAISI EST INVALIDE
         ;=========================================
comp:    STRO    invalid,d   ; affichage message invalide
         BR      fin         ; prochaine saisie

         ;==================
         ;CALCUL DE NOMBRE/2
         ;==================
         LDA     entier,d    ; resteM = entier - 2
loop2:   SUBA    2,i         ; do {
         STA     resteM,d    ;     resteM = resteM - 2
         LDA     cmpM,d      ;
         ADDA    1,i         ;
         STA     cmpM,d      ;     cmpM = cmpM +1;
         LDA     resteM,d    ;
         CPA     min,d       ;
         BRGT    loop2       ; } while (resteM > 1)

         ;=============================================
         ;RECHERCHE DES DIVISEURS ET CALCUL DE LA SOMME
         ;=============================================
loop3:   LDA     entier,d    ; do {
         LDA     div,d       ;
         CPA     1,i         ;    if (div == 1)
         BREQ    divise      ;        T : diviseur

         LDA     entier,d    ; resteD = entier - div
loop4:   SUBA    div,d       ; do {
         STA     resteD,d    ;     resteD = resteD - div
         CPA     0,i         ;
         BRLT    nonDiv      ;     if (resteD < 0)
         CPA     min,d       ;        T : non diviseur
         BRGT    loop4       ; } while (resteD < min)

         LDA     resteD,d    ;
         CPA     1,i         ;
         BREQ    nonDiv      ;    if (reste == 1)
         LDA     resteD,d    ;        T : non diviseur
         CPA     0,i         ;
         BREQ    divise      ;    else if (reste == 0) T : diviseur

         ;========================
         ;TRAITEMENT SI RESTE != 0
         ;========================
divise:  STRO    msgDiv,d    ;
         DECO    cmpD,d      ;
         CHARO   0x0020,i    ; espacement
         CHARO   ':',i       ;
         CHARO   0x0020,i    ; espacement
         DECO    div,d       ; message des diviseurs propres
         CHARO   0x000A,i    ; saut de ligne
         LDA     somme,d     ;
         ADDA    div,d       ;
         STA     somme,d     ; somme = somme + div
         LDA     cmpD,d      ;
         ADDA    1,i         ;
         STA     cmpD,d      ; cmpD = cmpD + 1
         LDA     div,d       ;
         ADDA    1,i         ;
         STA     div,d       ; div = div + 1
         CPA     cmpM,d      ;
         BRLE    loop3       ; while (div <= cmpM)

         ;=====================================
         ;TRAITEMENT POUR AUTRE VALEUR DE RESTE
         ;=====================================
nonDiv:  LDA     div,d       ;
         ADDA    1,i         ; div = div + 1
         STA     div,d       ;
         CPA     cmpM,d      ;
         BRLE    loop3       ; while (div <= cmpM)
         BR      nombre      

         ;========================
         ;VERIFICATION DE LA SOMME
         ;========================
nombre:  LDA     somme,d     ;
         CPA     0,i         ;
         BRLT    non         ;     if (somme < 0)
                             ;         T : nombre non parfait

         STRO    msgSum,d    ;     else {
         DECO    somme,d     ;         affichage de la somme
         CHARO   0x000A,i    ; saut de ligne
         LDA     entier,d    ;
         CPA     somme,d     ;
         BRNE    non         ;         if (entier != somme) T : non parfait
         BREQ    oui         ;         else T : parfait
                             ;     }
         BR      fin         

         ;=========================
         ;TRAITEMENT NOMBRE PARFAIT
         ;=========================
oui:     LDA     1,i         ;
         BR      affRes      

         ;=============================
         ;TRAITEMENT NOMBRE NON PARFAIT
         ;=============================
non:     LDA     0,i         ;
         BR      affRes      

         ;=============================
         ;AFFICHAGE RESULTAT
         ;============================= 
affRes:  STRO    msgNb,d     ; msg final
         DECO    entier,d    ; affiche le nombre dans la msg final
         CPA     1,i         ;  
         BREQ    affPar      ; si (entier == somme) allez a affichage nombre parfait
         STRO    nonParf,d   ; si non, affichage nombre non parfait
         BR      fin         
affPar:  STRO    parf,d      ; affichage nombre parfait
         BR      fin
         
         ;=============================
         ;VERIFIER COMPTEUR
         ;=============================
fin:     LDA     cmpEss,d    ;
         ADDA    1,i         ;
         STA     cmpEss,d    ;
         CPA     nbEssai,d   ;
         BRLE    init        
         STOP
                
         ;=============================
         ;INITIALISATION DES VARIABLES
         ;=============================
init:    LDA     0,i         ; initialisation à 0 des variables
         STA     somme,d     ; somme
         STA     cmpM,d      ; compteur de moitie
         LDA     1,i         ; initialisation à 1 des variables
         STA     cmpD,d      ; compteur de diviseur
         STA     div,d       ; diviseur
         CHARO   0x000A,i    ;
         BR      essai
       
msgEssai:.ASCII  "Essai#\x00"
entree:  .ASCII  "\x0A\x0ASaisissez un entier positif : \x0A\x00"
msgDiv:  .ASCII  "Diviseur propre \x00"
msgSum:  .ASCII  "Somme des diviseurs : \x00"
msgNb:   .ASCII  "\x0ALe nombre \x00"
parf:    .ASCII  " est parfait.\x0A\x00"
nonParf: .ASCII  " n'est pas parfait. \x0A\x00"
invalid: .ASCII  "\x0AEntrée est invalide.\x0A\x00"
entier:  .WORD   0           ; entier saisi au clavier
nbEssai: .WORD   5           ; nombre de tentatives
div:     .WORD   1           ; diviseur
cmpEss:  .WORD   1           ; compteur du nombre d'excécution
cmpM:    .WORD   0           ; compteur pour calcul de la moitie
cmpD:    .WORD   1           ; compteur des diviseurs
min:     .WORD   1           ; valeur min
max:     .WORD   32767       ; valeur max
resteM:  .WORD   0           ; reste du calcul de moitie
resteD:  .WORD   0           ; reste du calcul de diviseur
somme:   .WORD   0           ; somme des nombres parfaits
         .END                  