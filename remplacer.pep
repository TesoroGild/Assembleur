; ****************************************************************;
;       Programme: remplacer.pep                                  ;
;       PEP/8 version 8.2 sous Windows                            ;
;                                                                 ;
;       Programme qui forme un nouveau texte � partir du          ;
;       texte initial en rempla�ant une s�quence de caract�res    ;
;       sp�cifique par une autre s�quence de caract�res           ;                                     ;
; ****************************************************************;

         ;T : signifie traitement

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fonction MAIN faisnant appel � toutes les autre
; focntions pour l'exc�cution du programme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main:    CALL    SAISIR      ; SAISIR()

         LDA     buffTxtI,i 
         CHARO   0x000A,i
         CALL    AFFICHER    ; AFFICHER(nbOctets, adresse buffTxtI)

         LDA     txt1,i
         LDX     txt2,i
         CALL    REMPLACE    ; REMPALCE(txt1, txt2)
         STOP


;;;;;;;;;;;;;
; FONCTIONS
;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VARIABLES LOCALES FONTION SAISIR
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nbOctets:.EQUATE 0         ; #2d longueur de texte initial
compteur:.EQUATE 2         ; #2d verifier longeur max des textes
tampon:  .EQUATE 4         ; #2d stocker un caractere


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; nbOctets saisir()
; La fonction permettant de saisir les 3 tests
;
; In:  A=Adresse du tampon
;      X=Taille du tampon en octet
; Out: X=Nombre d?octets utilis�s dans le tampon
;        de saisie du texte.  
; Err: D�s qu?on d�tecte les d�bordements des 
;      tampons de saisie, on termine l?ex�cution
;      du programme en affichant un message
; Cas Sp�cial: Si l'un des 3 textes est vide, 
;      on sort affiche aucune modification
;      effectu�e et le programme s'arr�te
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SAISIR:  SUBSP   6,i         ; #tampon #compteur #nbOctets 

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Texte Initial
; Saisie du texte initial
;;;;;;;;;;;;;;;;;;;;;;;;;;;
SaisTxtI:LDA     0,i 
         LDX     0,i 
         STA     tampon,s    ; tampon = ''
         STA     compteur,s  ; compteur = 0
         STRO    msgTxtI,d   ; affichage message de sollicitation texte initial
         CHARO   0x000A,i
txtILoop:CHARI   buffTxtI,x  ; while (!buffTxtI.charAt(X).equals(null)) {
         LDA     compteur,s  ;    saisie du texte initial
         ADDA    1,i
         STA     compteur,s  ;    compteur += 1
         STA     nbOctets,s  ;    nbOctets += 1
         CPA     50,i        ;    if (nbOctets > 50)
         BRGT    deb         ;        break
         LDBYTEA buffTxtI,x  ;    A = buffTxtI.chatAt(X)
         CPA     '\n',i
         BRNE    txtISuit    ;    if (buffTxtI.charAt(X).equals('\n'))
         CPA     tampon,s    ;        if (buffTxtI.charAt(X).equals(tampon))
         BREQ    txtIFin     ;            buffTxtI.charAt(X) = null
txtISuit:LDBYTEA buffTxtI,x
         STA     tampon,s    ;    tampon = buffTxtI.chatAt(X)
         ADDX    1,i         ;    X += 1
         BR      txtILoop
txtIFin: LDBYTEA 0,i         
         STBYTEA buffTxtI,x  ;    modification du 2eme '\n' consecutif en null
         LDX     nbOctets,s
         SUBX    1,i         
         STX     nbOctets,s  ;    nbOctets -= 1
         BR      SaisTxt1    ; }

;;;;;;;;;;;;;;;;;;;;;;;
; Texte 1
; Saisie du texte 1
;;;;;;;;;;;;;;;;;;;;;;;
SaisTxt1:LDA     0,i 
         LDX     0,i 
         STA     compteur,s  ; compteur = 0
         CHARO   0x000A,i
         STRO    msgTxt1,d   ; affichage message de sollicitation txt1
         CHARO   0x000A,i
txt1Loop:CHARI   txt1,x      ; saisie du txt1
         LDA     compteur,s  ; while (!txt1.charAt(X).equals(null)) {
         ADDA    1,i         
         STA     compteur,s  ;    compteur += 1
         CPA     10,i        ;    if (compteur > 10)
         BRGT    deb         ;       break
         LDBYTEA txt1,x
         CPA     '\n',i
         BRNE    txt1Suit    ;    if (txt1.charAt(X).equals('\n'))
         LDBYTEA 0,i         ;       modification de '\n' par null
         STBYTEA txt1,x 
         BREQ    SaisTxt2
txt1Suit:LDBYTEA txt1,x
         ADDX    1,i         ;    X += 1
         BR      txt1Loop    ; }

;;;;;;;;;;;;;;;;;;;;;;;
; Texte 2
; Saisire du texte 2
;;;;;;;;;;;;;;;;;;;;;;;
SaisTxt2:LDA     0,i 
         LDX     0,i 
         STA     compteur,s  ; compteur = 0
         CHARO   0x000A,i
         STRO    msgTxt2,d   ; affichage message de sollicitation txt2
         CHARO   0x000A,i
txt2Loop:CHARI   txt2,x      ; saisie du txt2
         LDA     compteur,s  ; while (!txt2.charAt(X).equals(null)) {
         ADDA    1,i
         STA     compteur,s  ;    compteur += 1
         CPA     10,i        ;    if (compteur > 10)
         BRGT    deb         ;       break
         LDBYTEA txt2,x
         CPA     '\n',i
         BRNE    txt2Suit    ; if (txt2.charAt(X).equals('\n'))
         LDBYTEA 0,i         ;    modification de '\n' par null
         STBYTEA txt2,x 
         BREQ    finSaisi
txt2Suit:LDBYTEA txt2,x 
         ADDX    1,i         ;    X += 1
         BR      txt2Loop    ; }

finSaisi:LDX     nbOctets,s  ;    nbOctets = X
         ADDSP   6,i         ; #compteur #tampon #nbOctets
         RET0 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; affTxt(nbOctets, adresse buffTxtI)
; Fonction permettant l'affichage du texte initial
;
; In:  A=Adresse du texte initial
;      X=Taille du texte initial en octets
; Out: X=Nombre d?octets utilis�s dans le tampon
;        de saisie du texte.  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AFFICHER:LDX     0,i
         STRO    buffTxtI,d  ; affichage du texte intial
         RET0                ; return 0

     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; nbOctets rempl(txt1, txt2)
; Fonction permettant de remplacer le texte 2 par
; le text 1 si celui-ci existe dans le texte
; initial afin de donner un texte final
;
; In:  A=Adresse du texte 1
;      X=Adresse du texte 2
; Out: X=Nombre d?octets utilis�s dans le tampon
;        de saisie du texte. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
REMPLACE:LDA     buffTxtI,d
         LDX     txt1,d
         CALL    SPLIT       ; SPLIT(txtInit, txt1)

         LDA     txt2,i
         CALL    JOIN        ; JOIN(txt2)
         RET0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VARIABLES LOCALES FONTION SPLIT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp1TxtI:.equate 0           ; #2d 1er compteur du buffTxtI
cmpTxt1: .equate 2           ; #2d compteur du txt1
nbSousCh:.equate 4           ; #2d nombre de sous chaines
cmp2TxtI:.equate 6           ; #2d 2eme compteur du buffTxtI
adSousCh:.equate 8           ; #2d adresse des sous chaines
longTxt1:.equate 10          ; #2d longeur du txt1
obtChar: .equate 12          ; #1c tampon pour stocker caractere
match:   .equate 14          ; #2d 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;split(txtInit, txt1)
;Fonction permettant de trouver les correspondances
;du texte � remplacer s'il y en a et de stocker
;dans un tableau, le nombre de caract�res dans le
;texte � remplacer, le deuxi�me �l�ment doit 
;sp�cifier le nombre des sous-cha�nes issus d?un
;d�coupage du texte initial au s�parateur suivie
;enfin par les adresses de ces sous-cha�nes.
;
; In:  A=Texte initial
;      X=Texte 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SPLIT:   SUBSP   15,i        ; #match #obtChar #longTxt1 #adSousCh #cmp2TxtI #nbSousCh #cmpTxt1 #cmp1TxtI 
         LDX     6,i
         STX     adSousCh,s  ; adSousCh = 6
         LDA     buffTxtI,i
         LDX     4,i
         STA     tabSJ,x     ; tabSJ[2] = adresse de buffTxtI
         LDA     txt1,i      ; A = adresse de txt1
         LDX     txt1,i      ; X = adresse de txt1

;;;;;;;;;;;;;;;;;;;;;;
; Longeur du texte 1
;;;;;;;;;;;;;;;;;;;;;;
spltLoop:LDA     0,i         ; while (!txt1.charAt(X).equals(null)) {
         LDBYTEA 0,x         ;    A = txt1.charAt(X)
         CPA     '\x00',i
         BREQ    splitFin
         ADDX    1,i         ;    X += 1
         BR      spltLoop    ; }
splitFin:SUBX    txt1,i
         STX     longTxt1,s  ; longTxt1 = X
         LDA     longTxt1,s  ; A = longTxt1
         LDX     0,i 
         STA     tabSJ,x     ; tabSJ[0] = X
         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Nombres et adresses des sous chaines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
         LDX     0,i 
         LDBYTEA buffTxtI,x
         CPA     '\n',i      ; if (buffTxtT.charAt(0).equals('\n'))
         BREQ    noChang     ;    message aucun changement; break
         LDBYTEA txt1,x      
         CPA     '\x00',i    ; if (txt1.charAt(0).equals(null))
         BREQ    noChang     ;    message aucun changement; break
         LDBYTEA txt2,x      
         CPA     '\x00',i    ; if (txt2.charAt(0).equals(null))
         BREQ    noChang     ; message aucun changement; break
         LDA     0,i
sepLoop: LDBYTEA buffTxtI,x  ; while (!buffTxtI.charAt(X).equals(null)) {
         CPA     '\x00',i    ;    if (buffTxtI.charAt(X).equals(null))
         BREQ    addresse    ;        return 0
         STA     obtChar,s   ;    obtChar = buffTxtI.charAt(X)
         STX     cmp1TxtI,s  ;    X = cmp1TxtI
         STX     cmp2TxtI,s  ;    X = cmp2TxtI
         LDX     0,i         ;    X = 0
         STX     cmpTxt1,s   ;    cmpTxt1 = X
         LDBYTEA txt1,x      ;    A = txt1.charAt(X)
         CPA     obtChar,s   ;    if (obtChar.equals(A))
         BREQ    sepInc      ;        T : sepInc
sepSuite:LDX     cmp2TxtI,s  ;    while (!txt1.charAt(X).equals(obtChar)) {
         ADDX    1,i
         STX     cmp2TxtI,s  ;        cmp2TxtI += 1
         BR      sepLoop 
sepInc:  LDX     cmp1TxtI,s  ;        X = cmp1TxtI
         ADDX    1,i         
         STX     cmp1TxtI,s  ;        X += 1
         LDBYTEA buffTxtI,x  ;        A = buffTxtI.charAt(X)
         LDX     cmpTxt1,s   ;        X = cmpTxt1
         ADDX    1,i
         STX     cmpTxt1,s   ;        X + = 1
sepVerif:CPX     longTxt1,s  ;        while (X != longTxt1) {
         BREQ    oui          
         LDX     cmp1TxtI,s  ;            X = cmp1TxtI
         LDBYTEA buffTxtI,x  
         STA     obtChar,s   ;            obtChar = buffTxtI[X]
         LDX     cmpTxt1,s   ;            X = cmpTxt1
         LDBYTEA txt1,x      ;            A = txt1[X]
         CPA     obtChar,s   ;
         BRNE    sepSuite    ;    }

         LDX     cmp1TxtI,s  
         ADDX    1,i
         STX     cmp1TxtI,s  ;            cmp1TxtI += 1
         LDX     cmpTxt1,s
         ADDX    1,i
         STX     cmpTxt1,s   ;            cmpTxt1 += 1
         BR      sepVerif    ;        }

oui:     LDX     cmp1TxtI,s  ;    X = cmp1TxtI
         SUBX    longTxt1,s  ;    X -= longTxt1
         CPX     0,i         ;    if (X == 0)
         BREQ    casSpe      ;       T : casSpe
         LDX     nbSousCh,s  ;
         ADDX    1,i
         STX     nbSousCh,s  ;        nbSousCh += 1

         LDX     adSousCh,s  ;        X = adSousCh
         LDA     cmp1TxtI,s  ;        A = cmp1TxtI
         CALL    rempTab     ;        rempTab(adSousCh,cmp1TxtI)
         STX     adSousCh,s  ;        X = adSousCh
         LDX     cmp1TxtI,s  ;        X = cmp1TxtI
         BR      sepLoop     ; }

casSpe:  LDA     -1,i        ;            A = -1
         LDX     4,i         ;            X = 4
         STA     tabSJ,x     ;            tabSJ[2] = A
         LDA     0,i         ;            A = 0
         LDX     adSousCh,s  ;            X = adSousCh
         LDA     -1,i        ;            A = -1
         STA     tabSJ,x     ;            tabSJ[3] = A
         ADDX    2,i         ;            X += 2
         LDA     buffTxtI,i  ;            A = adresse buffTxtI
         ADDA    longTxt1,s  ;            A += longTxt1
         STA     tabSJ,x     ;            tabSJ[4] = A
         ADDX    2,i         ;            X += 2
         STX     adSousCh,s  ;            adSousCh += 2
         LDA     0,i         ;            A = 0
         LDX     cmp1TxtI,s  ;            X = cmp1TxtI
         BR      sepLoop     ;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Modification des �lements de tabSJ
;
; In:  A=Position actuelle du compteur
;        du texte initial
;      X=Indicie o� remplacer
; Out: A=Position de A avant modifiaction
;      X=Indice suivant o� sera
;        effectu� le remplacement
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rempTab: ADDA    buffTxtI,i  
         STA     tabSJ,x     ;            tabSJ[X] = A
         SUBA    buffTxtI,i 
         ADDX    2,i         ;            X += 2
         RET0                ;            return 0


noChang: LDX     0,i
         STRO    buffTxtI,d 
         CHARO   0x000A,i
         CHARO   0x000A,i
         STRO    msgChang,d  ; affichage message aucun changement
         STOP         

addresse:LDX     2,i         ; X = 2
         LDA     nbSousCh,s  ; A = nbSousCh
         ADDA    1,i         ; A += 1
         STA     tabSJ,x     ; tabSJ[1] = A
         ADDSP   15,i        ; #match #obtChar #longTxt1 #adSousCh #cmp2TxtI #nbSousCh #cmpTxt1 #cmp1TxtI 
         RET0                ; return 0
         STOP  


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES POUR JOIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
adTxtI:  .equate 0           ; #2d adresse debut du buffTxtI
adTxtF:  .equate 2           ; #2d adresse fin du buffTxtI
longTxt2:.equate 4           ; #2d longeur du txt2
adrD:    .equate 6           ; #2d adresse debut de copie buffTxtI
adrF:    .equate 8           ; #2d adresse fin de copie buffTxtI
adrEcri: .equate 10          ; #2d adresse buffTxtF o� ecrire
cmpT2:   .equate 12          ; #2d compteur txt2
eltTabSJ:.equate 14          ; #2d compteur parcourir tabSJ


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; nbOctets join(text2)
; Focntion permettant de former le texte final
;
; In:  A=Adresse de texte 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
JOIN:    SUBSP   16,i        ; #eltTabSJ #cmpT2 #adrEcri #adrF #adrD #longTxt2 #adTxtF #adTxtI      
         LDX     0,i
         LDA     0,i
longLoop:LDBYTEA buffTxtI,x  ; while (buffTxtI.charAt(X) != null) {
         ADDX    1,i         ;    X += 1
         CPA     '\x00',i
         BRNE    longLoop    ; }
         ADDX    buffTxtI,i
         SUBX    2,i
         STX     adTxtF,s    ; adTxtF = X - 2

         LDX     2,i         ; X = 2
         STX     eltTabSJ,s  ; eltTabSJ = X
         LDX     buffTxtF,i  ; X = adresse de buffTxtF
         STX     adrEcri,s   ; adrEcri = X
         LDX     0,i 
         STX     adTxtI,s    ; adTxtI = 0
         STX     adrD,s      ; adrD = 0
         STX     adrF,s      ; adrF = 0
         STX     cmpT2,s     ; cmpT2 = 0
         LDA     tabSJ,x     
         STA     longT,s     ; longT = tabSJ[0]

joinLoop:LDA     adrEcri,s   ; while (tabSJ[X] != null && tabSJ[X] != null 
                             ;            && tabSJ[X] != -1 && adrD < adTxtF) {
         LDX     eltTabSJ,s  
         ADDX    2,i
         STX     eltTabSJ,s  ;    eltTabSJ += 2
         LDA     tabSJ,x
         CPA     -1,i        ;    if (tabSJ[X] == -1)
         BREQ    casSp       ;        T : casSp
         CPA     '\x00',i    ;    if (tabSJ[X] == null)
         BREQ    FINAL       ;        T : FINAL
         BRNE    casNSp
      
casSp:   ADDX    2,i         
         STX     eltTabSJ,s  ;        eltTabSJ += 2
casNSp:  LDA     adrEcri,s   
         CALL    COPY        ;    COPY(eltTabSJ, adrEcri)
         
         STA     eltTabSJ,s  ;    eltTabSJ = A
         STX     adrEcri,s   ;    adrEcri = X
         LDX     0,i
         STX     cmpT2,s     ;    cmpT2 = 0
         LDA     adrTpars,x
         STA     adrD,s      ;    adrD = adtTpars[0]
         CPA     adTxtF,s    ;    if (adrD >= adTxtF)
         BRGE    FINAL       ;        T : FINAL
         ADDX    2,i
         LDA     adrTpars,x  
         STA     adrF,s      ;    adrF = adrTpars[i]

         LDA     0,i
         LDX     0,i
cpTxt2:  LDBYTEA txt2,x      ;    while (txt2[X] != null) {
         CPA     '\x00',i    ;        
         BREQ    joinLoop
         STBYTEA adrEcri,sf  ;        buffTxtF[X] = txt2[X]
         LDX     adrEcri,s
         ADDX    1,i
         STX     adrEcri,s   ;        adrEcri += 1
         LDX     cmpT2,s
         ADDX    1,i
         STX     cmpT2,s     ;        cmpT2 += 1
         BR      cpTxt2      ;    }
                             ; }
FINAL:   CHARO   0x000A,i
         STRO    buffTxtF,d  ; afficher le texte final avec les mots remplaces
         LDA     0,i
         ADDSP   16,i        ; #eltTabSJ #cmpT2 #adrEcri #adrF #adrF #longTxt2 #adTxtF #adTxtI 
         RET0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VARIABLES LOCALES POUR COPY
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tabSJCmp:.equate 0           ; #2d 1er compteur pour parcourir tabSJ
adrTCmp: .equate 2           ; #2d compteur pour parcourir adrTpars
longT:   .equate 4           ; #2d longeur txt1
adrDebut:.equate 6           ; #2d adresse debut de la copie
adrFin:  .equate 8           ; #2d adresse fin de la copie
adrBuffF:.equate 10          ; #2d adresse buffTxtF o� ecrire
cmpTxt2: .equate 12          ; #2d compteur txt2
tabSJCp2:.equate 14          ; #2d 2eme compteur pour parcourir tabSJ


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; adrToF copy()
; Utilise l?information stock� dans la 
; variable globale adrTpars pour effectuer 
; la copie du block d?octets
;
; In:  A=Adresse de texte 1
;      X=Position courante de tabSJ
; Out: A=Position courante de tabSJ
;      X=Adresse de la position suivante o�
;        �crire dans le buffer final
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
COPY:    SUBSP   16,i        ; #tabSJCp2 #cmpTxt2 #adrBuffF #adrFin #adrDebut #longT #adrTCmp #tabSJCmp  
         STA     adrBuffF,s
         STX     tabSJCmp,s  ; tabSJCmp = X
         LDA     buffTxtF,i 
         ADDA    100,i
         SUBA    adrBuffF,s
         CPA     0,i
         BRLE    deb 
         ADDX    2,i 
         STX     tabSJCp2,s  ; tabSJCp2 = X + 2
         LDX     0,i
         LDA     tabSJ,x
         STA     longT,s     ;longT = tabSJ[0]
         SUBA    longT,s
         STX     adrTCmp,s   ; adrTCmp = 0

         LDX     tabSJCmp,s
         LDA     tabSJ,x     
         CPA     -1,i        ; if (tabSJ[X] == -1)
         BREQ    cpDebut     ;    T : cpDebut
         BRNE    cpSuiv      ; else T : cpSuiv

cpDebut: LDA     0,i
         LDX     0,i
cSpeLoop:LDBYTEA txt2,x      ;    while (txt2.carAt[X] != null) {
         CPA     '\x00',i
         BREQ    cSpeSuiv
         STBYTEA adrBuffF,sf ;        buffTxtF = txt2.charAt[X]
         LDX     adrBuffF,s
         ADDX    1,i
         STX     adrBuffF,s
         LDX     cmpTxt2,s
         ADDX    1,i
         STX     cmpTxt2,s   ;        cmpTxt2 += 1
         BR      cSpeLoop    ;    }

cSpeSuiv:LDX     8,i
         STX     tabSJCmp,s  ; tabSJCmp = 8
         ADDX    2,i
         STX     tabSJCp2,s  ; tabSJCp2 = 10

cpSuiv:  LDX     tabSJCmp,s
         LDA     tabSJ,x
         LDX     0,i
         STA     adrTpars,x  ;    adrTpars[X] = tabSJ[tabSJCmp]
         STA     adrDebut,s  ;    adrDebut = A
         LDX     adrTCmp,s
         
         ADDX    2,i
         STX     adrTCmp,s   ;    adrTCmp += 2
         LDX     tabSJCp2,s
         LDA     tabSJ,x     
         CPA     '\x00',i    ;    if (tabSJ[X] != null)
         BREQ    calcFin     ;        T : calcFin
         SUBA    longT,s     ;    else {
         SUBA    1,i
         LDX     adrTCmp,s
         STA     adrTpars,x  ;        adrTpars[1] = tabSJ[X] - longT - 1
         STA     adrFin,s    ;        adrFin = adrTpars
         BR      nonFin      ;    }

calcFin: LDX     0,i
         LDA     0,i
calcLoop:LDBYTEA buffTxtI,x  ;        while (buffTxtI[X] != null) {
         ADDX    1,i         ;            X += 1
         CPA     '\x00',i
         BRNE    calcLoop    ;        }
         SUBX    1,i
         ADDX    buffTxtI,i
         STX     adrTCmp,s
         LDA     adrTCmp,s
         LDX     2,i
         STA     adrTpars,x  ;        adrTpars[1] = adrTCmp
         STA     adrFin,s    ;        adrFin = adrTCmp

nonFin:  ADDX    2,i
         LDA     adrBuffF,s 
         STA     adrTpars,x  ; adrTpars[2] = adrBuffF
         LDX     0,i
         LDA     adrDebut,s
cpLoop:  CPA     adrFin,s
         BRGT    nonCop
         LDBYTEA adrDebut,sf ; while (adrDebut < adrFin) {
         STBYTEA adrBuffF,sf ;    buffTxtF = adrDebut
         LDA     adrBuffF,s
         ADDA    1,i
         STA     adrBuffF,s 
         LDA     adrDebut,s
         ADDA    1,i
         STA     adrDebut,s  ;    
         BR      cpLoop      ; }
nonCop:  LDX     adrBuffF,s  ; X = adrBuffF
         LDA     tabSJCmp,s  ; A = tabSJCmp
         ADDSP   16,i         ; #tabSJCp2 #cmpTxt2 #adrBuffF #adrFin #adrDebut #longT #adrTCmp #tabSJCmp
         RET0

deb:     CHARO   0x000A,i
         STRO    striEMsg,d
         CHARO   0x000A,i
         STRO    msgChang,d  ; affichage message aucun changement
         STOP

;;;;;;;;;;;;;;;;;;;;;;
; VARIABLES GLOBALES
;;;;;;;;;;;;;;;;;;;;;;
buffTxtI:.block  50          ; #1c50a
buffTxtF:.block  100         ; #1c100a
txt1:    .block  10          ; #1c10a 
txt2:    .block  10          ; #1c10a
tabSJ:   .block  304         ; #1c304a 
adrTpars:.block  3           ; #1c3a

msgTxtI: .ASCII  "Texte Initial : \x00";
msgTxt1: .ASCII  "Mot � remplacer : \x00";
msgTxt2: .ASCII  "Mot de remplacement : \x00";
msgChang:.ASCII  "Aucun changement n'a �t� effect�.\x00"
striEMsg:.ASCII  "STRI erreur: d�bordement de capacit�\n\x00"           


         .END