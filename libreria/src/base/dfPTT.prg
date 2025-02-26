/******************************************************************************
Project     : dBsee 4.7
Description : Utilities Function
Programmer  : Baccan Matteo
******************************************************************************/

* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
FUNCTION dfPTT( cMov, nVal, nFie )
* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
LOCAL nRet := nFie
DO CASE
   CASE cMov=="+"
        nRet := nFie+nVal
   CASE cMov=="-"
        nRet := nFie-nVal
   CASE cMov=="="
        nRet :=      nVal
   //Aggiunti Luca 14/09/2004 per compatibilit�
   CASE cMov=="/"
        //IF !EMPTY(nVal) .AND. nVal>0
        IF !EMPTY(nVal) 
           nRet := nFie/nVal
        ELSE
           nRet := 0
        ENDIF
   CASE cMov=="*"
        //IF !EMPTY(nVal) .AND. nVal>0
        IF !EMPTY(nVal) 
           nRet := nFie*nVal
        ELSE
           nRet := 0
        ENDIF
ENDCASE
RETURN nRet

* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
FUNCTION dfRTT( cMov, nVal, nFie )
* 北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
LOCAL nRet := nFie
DO CASE
   CASE cMov=="+"
        nRet := nFie-nVal
   CASE cMov=="-"
        nRet := nFie+nVal
   CASE cMov=="/"
        IF !EMPTY(nVal) 
           nRet := nFie*nVal
        ELSE
           nRet := 0
        ENDIF
   CASE cMov=="*"
        IF !EMPTY(nVal) 
           nRet := nFie/nVal
        ELSE
           nRet := 0
        ENDIF
ENDCASE
RETURN nRet
