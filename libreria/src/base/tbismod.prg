/*******************************************************************************
Progetto       : dBsee 4.3
Descrizione    : Funzioni di utilita'
Programmatore  : Baccan Matteo
*******************************************************************************/
#include "dfWin.ch"
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION tbIsMod( oTbr ) //
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL oCol := oTbr:GETCOLUMN(oTbr:COLPOS)

#ifdef __XPP__
RETURN !EMPTY(oCol:WC_EDITFIELD)
#else
RETURN (!EMPTY(oCol:CARGO) .AND. !EMPTY(oCol:WC_EDITFIELD))
#endif

