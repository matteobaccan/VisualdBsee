/*******************************************************************************
Project     : dBsee 4.4
Description : Supporto per funzioni dBsee 3.0
Programmer  : Baccan Matteo
*******************************************************************************/
#include "common.ch"
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfYearLo( dDate )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
DEFAULT dDate TO DATE()
RETURN VAL(SUBSTR(STR(YEAR( dDate ),4),3,2))
