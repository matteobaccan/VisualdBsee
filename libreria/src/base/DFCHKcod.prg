/******************************************************************************
Project     : dBsee 4.5
Description : Utilities Function
Programmer  : Baccan Matteo
******************************************************************************/

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfChkCode( cCode )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet := .F.

cCode := ALLTRIM(cCode)

DO CASE
   CASE LEN(cCode)==16; lRet := dfChkCf(cCode)
   CASE LEN(cCode)==11; lRet := dfChkIva(cCode)
ENDCASE

RETURN lRet
