/******************************************************************************
Project     : dBsee 4.4
Description : Utilities Function
Programmer  : Baccan Matteo
******************************************************************************/
#include "dfSet.ch"

/*
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfChkDidExp( bExp1, bExp2, nIndex, bRelKey )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet

IF dfASDriver( RDDNAME() )
   lRet := DFS( nIndex, EVAL(bRelKey) )
ELSE
   lRet := IF( EOF(), .F., EVAL(bExp1)==EVAL(bExp2) )
ENDIF
*/

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfChkDidExp( nIndex, bRelKey, bRelFilter, bRelBreak )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet

IF dfASDriver( RDDNAME() )
   lRet := DFS( nIndex, EVAL( bRelKey ) )
ELSE
   lRet := .F.
   WHILE !EOF() .AND. !EVAL( bRelBreak )
      IF EVAL( bRelFilter )
         lRet := .T.
         EXIT
      ENDIF
      SKIP
   ENDDO
ENDIF

RETURN lRet
