
#define NTX_CONDITION (OrdNumber() == 0 .OR. LASTREC() > 100)

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfNtxPos(  )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN IIF( NTX_CONDITION, RECNO(), OrdKeyNo() )

FUNCTION dfNtxPosCan()
RETURN NTX_CONDITION


// #include "Common.ch"
//
//
// * ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
// FUNCTION dfNtxPos( nIndex, nRecno ) // Posizione relativa solo per NTX
// * ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
//    LOCAL nPos
//
//    DEFAULT nIndex TO INDEXORD()
//    DEFAULT nRecno TO RECNO()
//
//    IF RDDNAME()=="DBFNTX" .AND.;
//       LASTREC()<100       .AND.;
//       " 5.2"$VERSION()
//       IF !EOF()
//          nPos := ORDKEYNO()
//       ELSE
//          nPos := 1
//       ENDIF
//    ELSE
//       nPos := nRecno
//    ENDIF
//
// RETURN nPos
