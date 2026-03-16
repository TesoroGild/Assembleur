; ****************************************************************;
;       Programme: remplacer.pep                                  ;
;       PEP/8 version 8.2 sous Windows                            ;
;                                                                 ;
;       Programme qui permet de fusionner deux listes de notes    ;
;       tri�es en une seule liste qui est elle m�me tir�e.      ;
;                                                                 ;
; ****************************************************************;

         ;La majorit� des arguments de ce programme
         ;sont pass�s par la pile

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES SUR PILE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
var1:    .EQUATE 0            ;#2d
var2:    .EQUATE 2            ;#2d
var3:    .EQUATE 4            ;#2d
var4:    .EQUATE 6            ;#2d
var5:    .EQUATE 8            ;#2d
var6:    .EQUATE 10           ;#2d
var7:    .EQUATE 12           ;#2d
var8:    .EQUATE 14           ;#2d
var9:    .EQUATE 16           ;#2d
var35:   .EQUATE 18           ;#2d
var10:   .EQUATE 20           ;#2d
var11:   .EQUATE 22           ;#2d
var12:   .EQUATE 24           ;#2d
var13:   .EQUATE 26           ;#2d
var14:   .EQUATE 28           ;#2d
var15:   .EQUATE 30           ;#2d
var16:   .EQUATE 32           ;#2d
var17:   .EQUATE 34           ;#2d
var18:   .EQUATE 36           ;#2d
var19:   .EQUATE 40           ;#2d
var20:   .EQUATE 42           ;#2d
var21:   .EQUATE 44           ;#2d
var22:   .EQUATE 46           ;#2d
var23:   .EQUATE 48           ;#2d
var24:   .EQUATE 50           ;#2d
var25:   .EQUATE 52           ;#2d
var26:   .EQUATE 54           ;#2d
var27:   .EQUATE 56           ;#2d
var28:   .EQUATE 58           ;#2d
var29:   .EQUATE 60           ;#2d
var30:   .EQUATE 62           ;#2d
var31:   .EQUATE 64           ;#2d
var32:   .EQUATE 66           ;#2d
var33:   .EQUATE 68           ;#2d
var34:   .EQUATE 70           ;#2d


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;main()
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main:    CALL    notes ; cr�er la premi�re liste
         CALL    affListe ; afficher la liste cr��e
         LDA     2,i
         CALL    notes ; cr�er la deuxi�me liste
         CALL    affListe ; afficher la deuxi�me liste
         CALL    fusion ; fusionner les deux listes
         CALL    affListe ; afficher la liste r�sultante

;on efface le contenu de la pile
         SUBSP   70,i       ;#var1 #var2 #var3 #var4 #var5 #var6 #var7 #var8 #var9 #var35 #var10 #var11 #var12 #var13 #var14 #var15 #var16 #var17 #var18 #var19 #var20 #var21 #var22 #var23 #var24 #var25 #var26 #var27 #var28 #var29 #var30 #var31 #var32 #var33 #var34     
         LDA     0,i
         STA     0,s
         STA     2,s
         STA     4,s
         STA     6,s
         STA     8,s
         STA     10,s
         STA     12,s
         STA     14,s
         STA     16,s
         STA     18,s
         STA     20,s
         STA     22,s
         STA     24,s
         STA     26,s
         STA     28,s
         STA     30,s
         STA     32,s
         STA     34,s
         STA     36,s
         STA     38,s
         STA     40,s
         STA     42,s
         STA     44,s
         STA     46,s
         STA     48,s
         STA     50,s
         STA     52,s
         STA     54,s
         STA     56,s
         STA     58,s
         STA     60,s
         STA     62,s
         STA     64,s
         STA     66,s
         STA     68,s
         STA     70,s        
         ADDSP   70,i       ;#var1 #var2 #var3 #var4 #var5 #var6 #var7 #var8 #var9 #var35 #var10 #var11 #var12 #var13 #var14 #var15 #var16 #var17 #var18 #var19 #var20 #var21 #var22 #var23 #var24 #var25 #var26 #var27 #var28 #var29 #var30 #var31 #var32 #var33 #var34 

         STOP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;FONCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES FONCTION NOTES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
numList: .equate 0           ; #2d
choix:   .equate 2           ; #2d
adBuff:  .equate 4           ; #2d
debMail1:.equate 6           ; #2d
debMail2:.equate 8           ; #2d
debMaill:.equate 10          ; #2d

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;notes()
;Cr�e une liste des notes et retourne un pointeur
;vers son premier �l�ment (t�te). La fonction 
;impl�mente l'entr�e de l'information, 
;sa validation, la cr�ation des maillons de la 
;liste doublement cha�n�e contenant l'information, 
;l'insertion de maillons � la bonne position.
; In:  X=Adresse du debut maillon de la liste 1
;      A=Numero de la liste actuelle
; Out: X=Adresse du debut maillon de la liste 1
;      A=Adresse du debut maillon de la liste actuelle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
notes:   SUBSP   12,i         ; #debMaill #debMail2 #debMail1 #adBuff #choix #numList 
         
         STX     debMail1,s
         CPA     2,i
         BREQ    noteL1
         LDX     buffer,i
         STX     adBuff,s 
noteL1:  LDX     numList,s
         ADDX    1,i
         STX     numList,s
         CPX     1,i
         BREQ    saisList
         STA     numList,s
         LDA     0,i

saisList:STRO    msgList,d 
         DECO    numList,s
         CHARO   0x000A,i
outMenu: STRO    menu,d
         DECI    choix,s
         LDX     choix,s
         CPX     1,i
         BRLT    errMenu
         CPX     2,i
         BRGT    errMenu
         CPX     1,i
         BREQ    liste

         LDX     choix,s
         CPX     2,i
         BREQ    finSaisi 
         BR      erreur

erreur:  STRO    msgErr,d
         BR      outMenu

finSaisi:STA     debMaill,s
         LDX     debMail1,s
         ADDSP   12,i         ; #debMaill #debMail2 #debMaill #adBuff #choix #numList 
         RET0

liste:   LDX     adBuff,s
         SUBX    buffer,i
         SUBX    1,i
lstLoop: LDA     0,i
         ADDX    1,i
         LDBYTEA buffer,x
         CPA     "\x00",i
         BRNE    lstLoop
         ADDX    buffer,i
         STX     adBuff,s  
         CPX     buffer,i
         BREQ    lstSuite
         ADDX    1,i
             
lstSuite:LDA     numList,s
         CALL    creer
         STA     debMaill,s
         STX     adBuff,s
         LDA     numList,s
         CPA     2,i          ; si c'est la liste1, on stock les valeurs de       
         BRNE    saveL2       ; A et X dans debMaill, debMail1 et on les envoie 
         LDA     debMaill,s   ; � la fonction afficher. sinon, on les stock dans
         STA     debMail2,s   ; debMaill et debMail2
         BR      outMenu
saveL2:  LDA     debMaill,s
         STA     debMail1,s
         BR      outMenu

errMenu: STRO    msgErMnu,d
         CHARO   0x000A,i
         CHARO   0x000A,i
         BR      outMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES FONCTION CREER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
adrBuf:  .equate 0           ; #2d
compteur:.equate 2           ; #2d
addrPrec:.equate 4           ; #2d
note:    .equate 6           ; #2d
listNum: .equate 8           ; #2d
adrBuf2: .equate 10          ; #2d
adrDebB2:.equate 12          ; #2d


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;creer(numero_de_liste, adresse_buffer)
;La fonction cr�er permet de saisir les
;donn�es sur une note et cr�er un 
;maillon de la liste avec 4 champs
; In:  X=Adresse debut d'ecriture actuel
;        du buffer
;      A=Numero de la liste actuelle
; Out: X=Adresse debut d'ecriture actuel
;        du buffer
;      A=Numero de la liste actuelle
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
creer:   SUBSP   14,i         ; #adrDebB2 #adrBuf2 #listNum #note #addrPrec #compteur #adrBuf 
         
         STA     listNum,s
         CPA     2,i
         BREQ    adl2
         BR      next
adl2:    LDA     adrDebB2,s
         CPA     0,i
         BRNE    next
         STX     adrDebB2,s
         
next:    STX     addrPrec,s
         STX     adrBuf,s
         STX     adrBuf2,s         
         LDA     listNum,s
         CPA     1,i
         BRNE    l2
         CHARO   0x000A,i
         STRO    msgNmPr,d   ; affichage message de sollicitation texte initial
         CHARO   0x000A,i
         SUBX    buffer,i     
crLoop:  CHARI   buffer,x  ; while (!buffTxtI.charAt(X).equals(null)) {
         LDA     compteur,s  ;    saisie du texte initial
         ADDA    1,i
         STA     compteur,s  ;    compteur += 1
         CPA     300,i        ;    if (nbOctets > 300)
         BRGT    deb         ;        break
         LDBYTEA buffer,x  ;    A = buffTxtI.chatAt(X)
         CPA     '\n',i
         BREQ    crFin    ;    if (buffTxtI.charAt(X).equals('\n'))
         LDBYTEA buffer,x
         ADDX    1,i         ;    X += 1
         BR      crLoop
crFin:   LDBYTEA 0,i        
         STBYTEA buffer,x  ;    modification du 2eme '\n' consecutif en null       

         STRO    msgNote,d
         DECI    note,s
         LDA     note,s
         CPA     0,i
         BRLT    noteLoop
         CPA     100,i
         BRGT    noteLoop
ntLpFin: LDA     listNum,s
         LDX     adrBuf,s
         CALL    inserer
         ADDSP   14,i         ; #adrDebB2 #adrBuf2 #listNum #note #addrPrec #compteur #adrBuf 
         RET0

noteLoop:STRO    msgErNot,d
         STRO    msgNote,d
         DECI    note,s
         LDA     note,s
         CPA     0,i
         BRLT    noteLoop
         CPA     100,i
         BRGT    noteLoop
         BR      ntLpFin

deb:     STRO    msgDeb,d
         STOP

l2:      CHARO   0x000A,i
         STRO    msgNmPr,d   ; affichage message de sollicitation texte initial
         CHARO   0x000A,i
         SUBX    buffer,i
crLoop2: CHARI   buffer,x  ; while (!buffTxtI.charAt(X).equals(null)) {
         LDA     compteur,s  ;    saisie du texte initial
         ADDA    1,i
         STA     compteur,s  ;    compteur += 1
         CPA     300,i        ;    if (nbOctets > 300)
         BRGT    deb         ;        break
         LDBYTEA buffer,x  ;    A = buffTxtI.chatAt(X)
         CPA     '\n',i
         BREQ    crFin2    ;    if (buffTxtI.charAt(X).equals('\n'))
         LDBYTEA buffer,x
         ADDX    1,i         ;    X += 1
         BR      crLoop2
crFin2:  LDBYTEA 0,i        
         STBYTEA buffer,x  ;    modification du 2eme '\n' consecutif en null       

         STRO    msgNote,d
         DECI    note,s
         LDA     note,s
         CPA     0,i
         BRLT    noteLp2
         CPA     100,i
         BRGT    noteLp2
ntLpFin2:LDA     listNum,s
         LDX     adrDebB2,s
         CALL    inserer
         ADDSP   14,i         ; #adrDebB2 #adrBuf2 #listNum #note #addrPrec #compteur #adrBuf  
         RET0

noteLp2: STRO    msgErNot,d
         STRO    msgNote,d
         DECI    note,s
         LDA     note,s
         CPA     0,i
         BRLT    noteLp2
         CPA     100,i
         BRGT    noteLp2
         BR      ntLpFin2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES FONCTION INSERER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
iPrec:   .equate 0           ; #2d
head1:   .equate 2           ; #2d
head2:   .equate 4           ; #2d
iAdrBuf: .equate 20          ; #2d
iAddPrec:.equate 24          ; #2d
iNote:   .equate 26          ; #2d
iListNum:.equate 28          ; #2d
iAdrBuf2:.equate 30          ; #2d
iAdDebB2:.equate 32          ; #2d


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;inserer()
;Cette fonction ins�re un maillon dans la liste
;� la bonne position. La liste est organis�e 
;en ordre croissant alphanum�rique selon NOM,
;PR�NOM. La liste est d�finie par le pointeur
;t�te vers son premier �l�ment.
; Out: X=position actuelle ou ecrire
;      A=Tete maillon actuel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
inserer: SUBSP   18, i       ; #iAdDebB2 #iAdrBuf2 #iListNum #iNote #iAddPrec #iAdrBuf #head2 #head1 #iPrec     
    
;Si iListNum = 1, on ajoute dans liste 1 sinon
;on va dans liste 2 et on fait l'insertion    
;si l'adresse buffer = l'adresse buffer courant
;on cree le premier maillon. sinon, on appel la
;fonction comparer    
         LDA     iListNum,s
         CPA     1,i
         BRNE    il2
         LDX     buffer,i    ; si les adresses sont les meme alors on essaye de rentrer
         CPX     iAdrBuf,s   ; le 1er maillon donc on ne fait pas de comparaison et on
         BREQ    crDeb       ; insere directement. sinon, on appel la fonction comparer
         CALL    cmpMs
         CPA     1,i         ; selon la valeur de retour de registre A, on ajoute:
         BREQ    insSuiv     ; soit apres un maillon
         CPA     2,i         
         BREQ    insDeb      ; au debut de la liste
         CPA     3,i
         BREQ    crLessT     ; avant un maillon
      
;on creer le 1er maillon : suivant et precedent
;sont nuls    
crDeb:   LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         STX     head1,s
         LDA     iNote,s
         STA     mNote,x
         LDA     0,i
         STA     mPrec,x
         STX     iPrec,s
         LDX     mPrec,x
         LDA     0,i
         STA     mSuiv,x
         LDX     iAdrBuf,s

insSuite:CHARO   0x000A,i
         LDA     head1,s
         LDX     iAdrBuf,s
         ADDSP   18, i       ; #iAdDebB2 #iAdrBuf2 #iListNum #iNote #iAddPrec #iAdrBuf #head2 #head1 #iPrec     
         RET0

;on insere le maillon a la fin, on change
;son precedent et le suivant de l'ancienne 
;maillon qui etait le dernier de la liste
insSuiv: LDX     iPrec,s
         LDA     mSuiv,x
         CPA     0,i
         BRNE    crGtT
         LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     iPrec,s
         STA     mPrec,x
         STX     iPrec,s
         LDX     buffer,i
         CPX     iAdrBuf,s
         BREQ    insSuite
         LDX     iPrec,s
         LDX     mPrec,x
         LDA     iPrec,s
         STA     mSuiv,x
         LDX     iAdrBuf,s
         BR      insSuite

;on insere au debut, on change son suivant,
;on change le precedent du suivant et le 
;precedent du maillon actuel est nul
insDeb:  LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     0,i
         STA     mPrec,x
         STX     iPrec,s
         LDA     head1,s
         STA     mSuiv,x
         LDX     iAddPrec,s
         STX     head1,s
         LDX     mSuiv,x
         LDA     head1,s
         STA     mPrec,x
         LDX     iAdrBuf,s
         BR      insSuite

;on insere le maillon apres le maillon actuel
;on change son precedent, son suivant, 
;le precedent du suivant et le suivant du precedent
crGtT:   LDX     iPrec,s
         LDX     mSuiv,x
         CPX     0,i
         BREQ    insSuiv
         LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     iPrec,s
         STA     mPrec,x
         STX     iPrec,s
         LDX     mPrec,x
         LDA     mSuiv,x
         LDX     iPrec,s
         STA     mSuiv,x
         LDX     mPrec,x
         LDA     iPrec,s
         STA     mSuiv,x
         LDX     iPrec,s
         LDX     mSuiv,x
         STA     mPrec,x
         LDX     iAdrBuf,s
         BR      insSuite

;on insere le maillon avant le maillon actuel
;on change son precedent, son suivant, 
;le precedent du suivant et le suivant du precedent
crLessT: LDX     iPrec,s
         LDX     mPrec,x
         CPX     0,i
         BREQ    insDeb
         LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     iPrec,s      ; maillon courant
         STA     mSuiv,x     ; precedent du maillon courant
         STX     iPrec,s
         LDX     mSuiv,x
         LDA     mPrec,x
         LDX     iPrec,s
         STA     mPrec,x
         LDX     mSuiv,x
         LDA     iPrec,s
         STA     mPrec,x
         LDX     iPrec,s
         LDX     mPrec,x
         STA     mSuiv,x
         LDX     iAdrBuf,s
         BR      insSuite

;traitement de la liste 2
il2:     LDX     iAdDebB2,s
         CPX     iAdrBuf2,s
         BREQ    crDeb2
         CALL    cmpMs
         CPA     4,i
         BREQ    insSuiv2
         CPA     5,i
         BREQ    insDeb2
         CPA     6,i
         BREQ    crLessT2

crDeb2:  LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         STX     head2,s
         LDA     iNote,s
         STA     mNote,x
         LDA     0,i
         STA     mPrec,x
         STX     iPrec,s
         LDX     mPrec,x
         LDA     0,i
         STA     mSuiv,x
         LDX     iAdrBuf2,s

insSuit2:CHARO   0x000A,i
         LDA     head2,s
         LDX     iAdrBuf2,s
         ADDSP   18, i       ; #iAdDebB2 #iAdrBuf2 #iListNum #head2 #head1 #iNote #iPrec #iAddPrec #iAdrBuf 
         RET0

insSuiv2:LDX     iPrec,s
         LDA     mSuiv,x
         CPA     0,i
         BRNE    crGtT2 
         LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     iPrec,s
         STA     mPrec,x
         STX     iPrec,s
         LDX     iAdDebB2,s
         CPX     iAdrBuf2,s
         BREQ    insSuit2
         LDX     iPrec,s
         LDX     mPrec,x
         LDA     iPrec,s
         STA     mSuiv,x
         LDX     iAdrBuf2,s
         BR      insSuit2

insDeb2: LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     0,i
         STA     mPrec,x
         STX     iPrec,s
         LDA     head2,s
         STA     mSuiv,x
         LDX     iAddPrec,s
         STX     head2,s
         LDX     mSuiv,x
         LDA     head2,s
         STA     mPrec,x
         LDX     iAdrBuf2,s
         BR      insSuit2

crGtT2:  LDX     iPrec,s
         LDX     mSuiv,x
         CPX     0,i
         BREQ    insSuiv2
         LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     iPrec,s
         STA     mPrec,x
         STX     iPrec,s
         LDX     mPrec,x
         LDA     mSuiv,x
         LDX     iPrec,s
         STA     mSuiv,x
         LDX     mPrec,x
         LDA     iPrec,s
         STA     mSuiv,x
         LDX     iPrec,s
         LDX     mSuiv,x
         STA     mPrec,x
         LDX     iAdrBuf2,s
         BR      insSuit2

crLessT2:LDX     iPrec,s
         LDX     mPrec,x
         CPX     0,i
         BREQ    insDeb2
         LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     iAddPrec,s
         STA     mAdresse,x
         STX     iAddPrec,s
         LDA     iNote,s
         STA     mNote,x
         LDA     iPrec,s      ; maillon courant
         STA     mSuiv,x     ; precedent du maillon courant
         STX     iPrec,s
         LDX     mSuiv,x
         LDA     mPrec,x
         LDX     iPrec,s
         STA     mPrec,x
         LDX     mSuiv,x
         LDA     iPrec,s
         STA     mPrec,x
         LDX     iPrec,s
         LDX     mPrec,x
         STA     mSuiv,x
         LDX     iAdrBuf2,s
         BR      insSuit2 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES FONCTION CMPMS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
obtChar: .equate 0           ; #2d
indBuff: .equate 2           ; #2d
indElt:  .equate 4           ; #2d
cPrec:   .equate 18          ; #2d
cAdrBuf: .equate 38          ; #2d
cNote:   .equate 44          ; #2d
cListNum:.equate 46          ; #2d
cAdrBuf2:.equate 48          ; #2d
cAdDebB2:.equate 50          ; #2d


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;cmpMs()
;Comparer les 2 maillons en comparant 
;d'abord les champs textes, Noms et Pr�noms. 
;Si ces cha�nes sont identiques, le deuxi�me 
;champ, Note, est utilis� pour faire la 
;comparaison. Si les 2 champs sont identiques, 
;l'ordre d'insertion est arbitraire.
; Out: X=Numero de traitement
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmpMs:   SUBSP   16,i        ; #cAdrBuf2 #cListNum #cNote #cAdrBuf #cPrec #indElt #indBuff #obtChar 

;liste 1
         LDA     cListNum,s
         CPA     1,i
         BRNE    cV2

         LDX     buffer,i    ; si les adresses sont les meme alors on essaye de
         CPX     cAdrBuf,s   ; rentrer le 1er maillon donc on ne fait pas de comparaison
         BRNE    cpSuiv

cFin:    ADDSP   16,i        ; #cAdrBuf2 #cListNum #cNote #cAdrBuf #cPrec #indElt #indBuff #obtChar 
         RET0

cpSuiv:  LDX     cAdrBuf,s
         SUBX    buffer,i
         STX     indBuff,s   ; indBuff = cAdrBuf - buffer
         LDBYTEA buffer,x
         STA     obtChar,s   ; obtChar = buffer[X]
         LDX     cPrec,s
         LDX     mAdresse,x
         SUBX    buffer,i
         STX     indElt,s    ; indElt = mAdresse - buffer
         LDBYTEA buffer,x    ; A = buffer [X]
         CPA     obtChar,s   ; si maillon actuel est plus petit que le nouveau
         BRLT    verSuiv     ; on verifie le suivant
         BREQ    compSuit    ; s'il est egal, on compare les caractere suivant
         BRGT    verPrec     ; s'il est plus grand, on verifi le precedent

compSuit:CPA     "\x00",i    ; do {
         BREQ    compNote    ;      
         LDX     indBuff,s
         ADDX    1,i         
         STX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         LDX     indElt,s
         ADDX    1,i
         STX     indElt,s
         LDBYTEA buffer,x
         CPA     obtChar,s   ;     comparaison caractere par caractere
         BRLT    verSuiv
         BREQ    compSuit    ; } while (A == obtChar && A == null)
         BRGT    verPrec

r1:      LDA     1,i
         BR      cFin

r2:      LDA     2,i
         BR      cFin

r3:      LDA     3,i
         BR      cFin

;si les notes sont egales, l'ordre d'insertion n'importe pas
;si la note est plus grande, on verifi la maillon suivant
;  si la note est plus petite, on insere avant
;  sinon, on verifi le suivant
;sinon on verifi le maillon precedent
;  si la note est plus grande, on insere apres
;  sinon, on cerifi le precedent
compNote:LDX     cPrec,s
         LDX     mNote,x
         CPX     cNote,s
         BREQ    r1
         BRLT    verSuiv
         BRGT    verPrec

cpNotSv: LDX     cPrec,s
         LDX     mNote,x
         CPX     cNote,s
         BREQ    r1
         BRLT    verSuiv
         BRGT    r3

cpNotPr: LDX     cPrec,s
         LDX     mNote,x
         CPX     cNote,s
         BRGE    verPrec
         BRLT    r1

;on verifi le precedent tant qu'il y en a un ou 
;jusqu'a ce que l'element precedent soit plus grand
verPrec: LDX     cPrec,s
         LDX     mPrec,x
         CPX     0,i
         BREQ    r2
         LDX     cAdrBuf,s
         SUBX    buffer,i
         STX     indBuff,s
         LDX     cPrec,s
         LDX     mPrec,x
         STX     cPrec,s
         LDX     mAdresse,x
         SUBX    buffer,i
         STX     indElt,s
         LDBYTEA buffer,x
vPLoop:  CPA     "\x00",i
         BREQ    cpNotPr        
         LDX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         ADDX    1,i
         STX     indBuff,s
         LDX     indElt,s
         LDBYTEA buffer,x
         ADDX    1,i
         STX     indElt,s
         CPA     obtChar,s
         BREQ    vPLoop
         BRLT    r1
         BRGT    verPrec

;on verifi le suivant tant qu'il y en a un ou 
;jusqu'a ce que l'element suivant soit plus petit
verSuiv: LDX     cPrec,s
         LDX     mSuiv,x
         CPX     0,i
         BREQ    r1
         LDX     cAdrBuf,s 
         SUBX    buffer,i
         STX     indBuff,s
         LDX     cPrec,s
         LDX     mSuiv,x
         STX     cPrec,s
         LDX     mAdresse,x
         SUBX    buffer,i
         STX     indElt,s
         LDBYTEA buffer,x
vSLoop:  CPA     "\x00",i
         BREQ    cpNotSv        
         LDX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         ADDX    1,i
         STX     indBuff,s
         LDX     indElt,s
         LDBYTEA buffer,x
         ADDX    1,i
         STX     indElt,s
         CPA     obtChar,s
         BRLT    verSuiv
         BREQ    vSLoop
         BRGT    r3

;liste 2 : meme implementation
cV2:     LDX     cAdDebB2,s 
         CPX     cAdrBuf2,s
         BRNE    cpSuiv2

cFin2:   ADDSP   16,i        ; #cAdrBuf2 #cListNum #cNote #cAdrBuf #cPrec #indElt #indBuff #obtChar  
         RET0

cpSuiv2: LDX     cAdrBuf2,s
         SUBX    buffer,i
         STX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         LDX     cPrec,s
         LDX     mAdresse,x
         SUBX    buffer,i
         STX     indElt,s
         LDBYTEA buffer,x
         CPA     obtChar,s
         BRLT    verSuiv2
         BREQ    cmpSuit2
         BRGT    verPrec2

cmpSuit2:CPA     "\x00",i
         BREQ    cmpNote2        
         LDX     indBuff,s
         ADDX    1,i
         STX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         LDX     indElt,s
         ADDX    1,i
         STX     indElt,s
         LDBYTEA buffer,x
         CPA     obtChar,s
         BRLT    verSuiv2
         BREQ    cmpSuit2
         BRGT    verPrec2

r4:      LDA     4,i
         BR      cFin2

r5:      LDA     5,i
         BR      cFin2

r6:      LDA     6,i
         BR      cFin2

cmpNote2:LDX     cPrec,s
         LDX     mNote,x
         CPX     cNote,s
         BREQ    r4
         BRLT    verSuiv2
         BRGT    verPrec2

cpNotSv2:LDX     cPrec,s
         LDX     mNote,x
         CPX     cNote,s
         BREQ    r4
         BRLT    verSuiv2
         BRGT    r6

cpNotPr2:LDX     cPrec,s
         LDX     mNote,x
         CPX     cNote,s
         BRGE    verPrec2
         BRLT    r4

verPrec2:LDX     cPrec,s
         LDX     mPrec,x
         CPX     0,i
         BREQ    r5
         LDX     cAdrBuf2,s
         SUBX    buffer,i
         STX     indBuff,s
         LDX     cPrec,s
         LDX     mPrec,x
         STX     cPrec,s
         LDX     mAdresse,x
         SUBX    buffer,i
         STX     indElt,s
         LDBYTEA buffer,x
vPLoop2: CPA     "\x00",i
         BREQ    cpNotPr2        
         LDX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         ADDX    1,i
         STX     indBuff,s
         LDX     indElt,s
         LDBYTEA buffer,x
         ADDX    1,i
         STX     indElt,s
         CPA     obtChar,s
         BREQ    vPLoop2
         BRLT    r4
         BRGT    verPrec2

verSuiv2:LDX     cPrec,s
         LDX     mSuiv,x
         CPX     0,i
         BREQ    r4
         LDX     cAdrBuf2,s
         SUBX    buffer,i
         STX     indBuff,s
         LDX     cPrec,s
         LDX     mSuiv,x
         STX     cPrec,s
         LDX     mAdresse,x
         SUBX    buffer,i
         STX     indElt,s
         LDBYTEA buffer,x
vSLoop2: CPA     "\x00",i
         BREQ    cpNotSv2        
         LDX     indBuff,s
         LDBYTEA buffer,x
         STA     obtChar,s
         ADDX    1,i
         STX     indBuff,s
         LDX     indElt,s
         LDBYTEA buffer,x
         ADDX    1,i
         STX     indElt,s
         CPA     obtChar,s
         BRLT    verSuiv2
         BREQ    vSLoop2
         BRGT    r6


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES FONCTION AFFLISTE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
addrBuf: .equate 0           ; #2d 
dbMaill: .equate 2           ; #2d
dbMaill1:.equate 4           ; #2d
dbMaill2:.equate 6           ; #2d


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;affListe()
;affiche le contenu d?une liste
; In: X=Tete liste 1
;     A=Tete liste actuelle
; Out: X=Tete liste 1
;     A=Tete liste 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
affListe:SUBSP   8,i         ; #dbMaill2 #dbMaill1 #dbMaill #addrBuf            
         STX     dbMaill1,s  ; dbMaill1 = X
         STA     dbMaill,s   ; dbMaill = A
         STA     dbMaill2,s  ; dbMaill2 = A
         LDX     dbMaill,s   ; X = debMaill
         CPX     0,i         ; if (X != 0) {
         BREQ    affFn
         
affLoop: CHARO   0x000A,i    ;     do {
         LDA     mAdresse,x
         SUBA    buffer,i
         STA     addrBuf,s   ;         addrBuf = mAdresse-buffer
         LDX     addrBuf,s   ;         X = addrBuf
         SUBX    1,i
affNom:  ADDX    1,i         ;         do {
         CHARO   buffer,x    ;             X++
         LDBYTEA buffer,x    ;             system.out.print(buffer[x])
         CPA     "\x00",i    ;             A = getChar(X)
         BRNE    affNom      ;         } while (A != null)
         LDX     dbMaill,s
         CHARO   " ",i
         CHARO   ";",i
         CHARO   " ",i
         STRO    msgNote,d   ;         system.out.print(msgNote)
         DECO    mNote,x     ;         system.out.print(mNote)
         LDX     mSuiv,x     
         STX     dbMaill,s   ;         dbMaill = dbMaill.next()
         CPX     0,i         
         BREQ    affFin
         BR      affLoop     ;     } while (dbMaill = 0)

affFin:  LDX     buffer,i
         SUBX    buffer,i
         SUBX    1,i
affFinLp:ADDX    1,i
         LDBYTEA buffer,x
         CPA     "\x00",i
         BRNE    affFinLp
         ADDX    1,i
         LDBYTEA buffer,x
         CPA     "\x00",i
         BRNE    affFinLp
         ADDX    buffer,i
         SUBX    1,i
         STX     addrBuf,s

affFn:   LDX     0,i
         STX     dbMaill,s
         LDX     dbMaill1,s  ; } else {
         LDA     dbMaill2,s  ;     X = dbMaill1
         CHARO   0x000A,i    ;     A = dbMaill2
         CHARO   0x000A,i
         ADDSP   8,i         ; #dbMaill2 #dbMaill1 #dbMaill #addrBuf               
         RET0                ; return 0
                             ; }


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;VARIABLES LOCALES FONCTION FUSION
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tete1:   .equate 0           ; #2d
tete2:   .equate 2           ; #2d 
tete3:   .equate 4           ; #2d
maillonP:.equate 6           ; #2d
debL3:   .equate 8           ; #2d
ind1:    .equate 10          ; #2d
ind2:    .equate 12          ; #2d
char:    .equate 14          ; #2h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;fusion(head, head1)
;La fonction fusion forme la liste r�sultat
;en fusionnant l?information des deux listes
; In: X=Tete liste 1
;     A=Tete liste 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fusion:  SUBSP   16,i         ; #char #ind2 #ind1 #debL3 #maillonP #tete3 #tete2 #tete1
         
         STX     tete1,s     ; tete1 = X
         STA     tete2,s     ; tete2 = A
         LDX     0,i 
         STX     maillonP,s  ; maillonP = 0
         STX     ind2,s      ; ind2 = 0
         STX     char,s      ; char = 0
         STX     tete3,s     ; tete3 = 0
         STX     debL3,s     ; debL3 = 0

fusionLp:LDX     tete1,s     ; do {
         CPX     0,i         ;     if (tete1 == 0) 
         BREQ    addL2       ;         ajouter uiquement liste2
         LDX     tete2,s
         CPX     0,i         ;     if (tete2 == 0) 
         BREQ    addL1       ;         ajouter uiquement liste1

         LDX     tete1,s
         LDX     mAdresse,x  ;     X = mAdresse (tete1)
         SUBX    buffer,i
         STX     ind1,s      ;     ind1 = mAdresse[X] - buffer
         LDA     0,i
         LDBYTEA buffer,x
         STA     char,s      ;     char = buffer[X]
         LDX     tete2,s
         LDX     mAdresse,x  ;     X = mAdresse (tete2)
         SUBX    buffer,i
         STX     ind2,s      ;     ind2 = mAdresse[X] - buffer
         LDA     0,i
         LDBYTEA buffer,x    ;     A = buffer[X]
         CPA     char,s      
         BRLT    addL2       ;     if (A < char) ajouter elts de liste2
         BRGT    addL1       ;     else if (A > char) ajouter elts de liste1
         
vrStLp:  LDA     ind1,s      ;     else {
         ADDA    1,i         ;         do {
         STA     ind1,s      ;             ind1 += 1
         LDA     ind2,s
         ADDA    1,i
         STA     ind2,s      ;             ind2 += 1
         LDX     ind1,s      ;             X = ind1
         LDA     0,i
         LDBYTEA buffer,x    ;
         STA     char,s      ;             char = buffer[X]
         LDX     ind2,s      ;             X = ind2
         LDA     0,i
         LDBYTEA buffer,x    ;             A = buffer[X]
         CPA     char,s      
         BRLT    addL2       ;             if (A < char) ajouter elts liste1
         BRGT    addL1       ;             else if (A > char) ajouter elts de liste1
         CPA     "\x00",i    
         BREQ    vrNote                       
         BR      vrStLp      ;         } while (A == char && A != null)
                             ;     }
vrNote:  LDX     tete1,s
         LDA     mNote,x     ;     A = mNote (liste1)
         LDX     tete2,s
         CPA     mNote,x     
         BRLE    addL1       ;    if (A <= mNote (liste2)) ajouter elts liste1
         BRGT    addL2       ;    else ajouter elts liste2

addL1:   LDX     tete1,s
         CPX     0,i         ;    if (tete1 == 0) {
         BRNE    fSt         ;        if (tete2 ==0)
         LDX     tete2,s     ;            return debL3
         CPX     0,i
         BREQ    fusFin      ;    }
fSt:     LDA     8,i         ;    
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     debL3,s     ;    if (debL3 == 0)
         CPA     0,i         ;        maillonP = 0
         BRNE    sauter
         STX     debL3,s
         STX     maillonP,s 
sauter:  STX     tete3,s     ;    tete3 = X
         LDX     tete1,s     ;    X = tete1
         LDA     mAdresse,x  ;    A = mAdresse[X]
         LDX     tete3,s     ;    X = tete3
         STA     mAdresse,x  ;    mAdresse[X] = A
         LDX     tete1,s
         LDA     mNote,x     ;    A = mNote[X]
         LDX     tete3,s
         STA     mNote,x     ;    mNote[X] = A
         LDX     tete1,s     ;    X = tete1
         LDA     mPrec,x     ;    A = mPrec[X]
         CPA     0,i         
         BRNE    fu1Suit2    ;    if (A == 0) T
         LDX     tete1,s     
         LDX     mSuiv,x     
         STX     tete1,s     ;       tete1 = mSuiv[X]
         LDA     tete3,s
         CPA     debL3,s     
         BREQ    fusionLp    ; } while (tete3 = debL3)
         BR      fu1Suit1

fu1Suit2:LDX     tete1,s     ;    T : else {
         LDX     mSuiv,x     ;            tete1 = mSuiv[X]
         STX     tete1,s     ;        }

fu1Suit1:LDX     tete3,s
         LDA     maillonP,s
         STA     mPrec,x     ;    mPrec[X] = maillonP
         LDA     tete3,s
         STA     maillonP,s  ;    maillonP = tete3
         LDX     tete3,s
         LDX     mPrec,x
         LDA     tete3,s
         STA     mSuiv,x     ;    mSuiv[X] = tete3
         LDX     tete1,s
         CPX     0,i         ;    if (tete1 == 0) ajouter elts liste2
         BREQ    addL2
         BR      fusionLp      

;Meme implementation que addL1
;avec les elts de liste 2
addL2:   LDX     tete2,s
         CPX     0,i
         BRNE    fSt2       
         LDX     tete1,s
         CPX     0,i
         BREQ    fusFin
fSt2:    LDA     8,i
         CALL    new         ; #mSuiv #mPrec #mNote #mAdresse
         LDA     debL3,s
         CPA     0,i
         BRNE    sauter2
         STX     debL3,s
         STX     maillonP,s 
sauter2: STX     tete3,s
         LDX     tete2,s
         LDA     mAdresse,x
         LDX     tete3,s
         STA     mAdresse,x
         LDX     tete2,s
         LDA     mNote,x
         LDX     tete3,s
         STA     mNote,x
         LDX     tete2,s
         LDA     mPrec,x
         CPA     0,i
         BRNE    fu2Suit2
         LDX     tete2,s
         LDX     mSuiv,x
         STX     tete2,s
         LDA     tete3,s
         CPA     debL3,s
         BREQ    fusionLp
         BR      fu2Suit1
fu2Suit2:LDX     tete2,s
         LDX     mSuiv,x
         STX     tete2,s
fu2Suit1:LDX     tete3,s
         LDA     maillonP,s
         STA     mPrec,x
         LDA     tete3,s
         STA     maillonP,s
         LDX     tete3,s
         LDX     mPrec,x
         LDA     tete3,s
         STA     mSuiv,x
         LDX     tete2,s
         CPX     0,i
         BREQ    addL1
         BR      fusionLp    ; } while (tete1 != 0 && tete2 != 0) 

fusFin:  STRO    msgFus,d 
         LDA     debL3,s
         ADDSP   16,i         ; #char #ind2 #ind1 #debL3 #maillonP #tete3 #tete2 #tete1
         RET0


buffer:  .block  300         ; #1c300a
msgList: .ascii  "Liste \x00" 
menu:    .ascii  "*******************\n"
         .ascii  "* 1 - Saisir      *\n" 
         .ascii  "* 2 - Quitter     *\n"
         .ascii  "*******************\n"
         .ascii  "Votre choix : \x00"
msgErr:  .ascii  "Ce num�ro ne fait pas parti du menu\n"
         .ascii  "Veuillez recommencer\n\n\x00" 
msgNmPr: .ascii  "Nom, Pr�nom : \x00"
msgNote: .ascii  "Note : \x00"
msgDeb:  .ascii  "Erreur : Debordement de capacit�\x00"
msgErNot:.ascii  "Veuillez entrer une notre entre 0 et 100\n\x00"
msgFus:  .ascii  "Liste fusion\x00"
msgErMnu:.ascii  "Veuiullez saisir un nombre entre 1 et 2\x00"


;****** Structure d'un maillon
mAdresse:.equate 6           ; #2d 
mNote:   .equate 4           ; #2d
mPrec:   .equate 2           ; #2d 
mSuiv:   .equate 0           ; #2d

;*******operator new
;Precondition : A contains number of bytes
;Postcondition : X contains pointer to bytes
new:     LDX     hpPtr,d     ;returned pointer
         ADDA    hpPtr,d     ;allocate from heap
         STA     hpPtr,d     ;update hpPtr
         RET0
hpPtr:   .ADDRSS heap        ;address of next free byte 
heap:    .BLOCK 1 ;first byte in the heap


         .END