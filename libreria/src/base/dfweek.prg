/******************************************************************************
Project     : dBsee 4.5
Description : Utilities Function
Programmer  : Baccan Matteo
******************************************************************************/

#include "Common.ch"
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWeek( dDate )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL nDate := 1, d1Date

DEFAULT dDate TO DATE()

d1Date := CTOD("01/01/"+ALLTRIM(STR(YEAR(dDate))))

WHILE DOW(++d1Date)>1; ENDDO

IF dDate >= d1Date
   nDate  += INT( ((dDate-d1Date)+7)/7 )
ENDIF

RETURN nDate
