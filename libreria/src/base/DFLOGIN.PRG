// *****************************************************************************
// Copyright (C) ISA - Italian Software Agency
// Description : Password Function rel 2.0
// *****************************************************************************

// -----------------------------------------------------------------------------
// Password File Structure
//
// DBLOGIN.DBF
//
// RECORD 1       >> CheckSum
//
// RECORD 2 ... N >> PassWord
//
// FIELDS
//
// cPassWord    C   10
// cUser        C   30  // User name. This field is registered only by dfCngPwd
//
// dDate        D    8  // Upgrade Date
//
// -----------------------------------------------------------------------------

#include "Common.ch"
#include "Inkey.ch"
#include "dfset.ch"
#include "dfNet.ch"
#include "dfMsg.ch"
#include "dfStd.ch"
#include "dfCTRL.ch"

// 04-nov-05 Correct DBGOTO(0) problem
#xtranslate DBGOTO(<x>) => DBGOTO_XPP(<x>)

STATIC aColor := NIL
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfGenPwd() // Make Password File
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet:=.F., nCount, lOldSet
dbCfgClose("dbLogin")

// Disable automatic use of ADS
setADS( .F. )

lOldSet := dfSet( AI_NET, .F. ) // Set EXCLUSIVE open
//Mantis 339
//DBCREATE( dbCfgPath( "dbLoginPath" ) +"dbLogin",{ {"cPassWord", "C", 6 ,0} ,;
DBCREATE( dbCfgPath( "dbLoginPath" ) +"dbLogin",{ {"cPassWord", "C", 10 ,0} ,;
                                                  {"cUser"    , "C", 30, 0} ,;
                                                  {"dDate"    , "D",  8, 0} })

dbCfgOpen("dbLogin")      // Open database

ZAP                       // Clear File
DBAPPEND()                // Skip first Record

FOR nCount:=1 TO 99       // Create login
    dbLogin->(DBAPPEND())
    dbLogin->cPassWord := dfRecDec( "VDBSEE" +PADL(nCount,4,"0") )
NEXT

dfUpdChk()                // Update checksum

dbCfgClose("dbLogin")     // Close Login

dfSet( AI_NET, lOldSet )  // Update setting

// Enable automatic use of ADS
setADS( .T. )

RETURN lRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
PROCEDURE dfLogin() // Password System
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
DEFAULT aColor TO dfColor( "dfLogin" )

// Disable automatic use of ADS
setADS( .F. )

IF !dbCfgOpen("dbLogin")  // ERROR on password file
   dbMsgErr( dfStdMsg(MSG_DFLOGIN01) )
   dfUserLev( 0 )         // Clear Level
   dfUserName( "" )
   RETURN
ENDIF

IF !dfChkLogin()          // Check LOG file
   dbMsgErr( dfStdMsg(MSG_DFLOGIN01) )
   dfUserLev( 0 )         // Clear Level
   dfUserName( "" )
   RETURN
ENDIF

Login()     // Set Password

// Enable automatic use of ADS
setADS( .T. )
RETURN

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfChkLogin() // Check CHECKSUM
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL nSum := dfCheksum(), lRet:=.F.
dbLogin->(DBGOTOP())
IF dbLogin->cPassWord==dfTotClc(nSum)
   lRet:=.T.
ENDIF
RETURN lRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC PROCEDURE dfUpdChk()  // Upgrade CheckSum
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL nCount:=dfCheksum()
dbLogin->(DBGOTOP())  // Write CHECKSUM
dbLogin->(dfNet( NET_RECORDLOCK, 0 ))
dbLogin->cPassWord := dfTotClc(nCount)
dbLogin->(DBCOMMIT())
dbLogin->(dfNet( NET_RECORDUNLOCK ))
RETURN

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfCheksum()  // Calculate File CHECKSUM
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL nSum := 0
dbLogin->(DBGOTOP())
dbLogin->(DBSKIP())   // Skip first Record

WHILE !dbLogin->(EOF())
   nSum += dfRecClc( dbLogin->cPassWord )
   dbLogin->(DBSKIP())
ENDDO

RETURN nSum

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfRecClc( cPassWord ) // Calculate Record CHECKSUM
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN dfStrCHK( PADR(cPassWord,LEN(dbLogin->cPassWord)) ) +dbLogin->(RECNO())

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfRecDec( cPassWord ) // Decode password
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
cPassWord := dfStrInv( PADR( cPassWord, LEN(dbLogin->cPassWord) ) )
RETURN dfDecode( cPassWord, ALLTRIM(STR(dbLogin->(RECNO()))) )

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfTotClc(nSum) // Change CHECKSUM to STRING
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN STR( nSum, LEN(dbLogin->cPassWord) )

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC PROCEDURE Login()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL cPwd, nCheck := 1
LOCAL aCTRL := {}
LOCAL cMes
IF !EMPTY(dfSet("XbasedfLoginTitle"))
   cMes := ALLTRIM(dfSet("XbasedfLoginTitle"))
ELSE
   cMes := "Login Password <<"+dfSetApplicationName()+">>"
ENDIF

dfUserLev( 0 )
cPwd := SPACE( LEN(dbLogin->cPassWord) )


ATTACH "SAY" TO aCtrl SAY  cMes;
                           AT 1 , 2  ;
                           FONT      "9.Verdana BOLD"
                               

ATTACH "01" TO aCTRL GET cPWD                         ;
                    AT  4, 7                          ;
                    PROMPT dfStdMsg(MSG_DFLOGIN02)    ;
                    PROMPTAT 3, 2                     ;
                    MESSAGE dfStdMsg(MSG_DFLOGIN02)   ;
                    PICTUREGET "@P"+REPLICATE("!",LEN(cPWD))

WHILE nCheck<4 .AND. dfUserLev()==0
   dfAutoForm( NIL, NIL, aCTRL,dfStdMsg(MSG_DFLOGIN14) ,,,.F. )

   IF M->A!=K_ESC .AND. dfFoundPwd( cPwd )
      IF !dbLogin->(DBRLOCK( dbLogin->(RECNO()) ))
         IF !dfYesNo( dfStdMsg(MSG_DFLOGIN03) + ;
                      dfStdMsg(MSG_DFLOGIN04) + ;
                      dfStdMsg(MSG_DFLOGIN05) + ;
                      dfStdMsg(MSG_DFLOGIN18) , .T. )
            nCheck:=3
         ENDIF
      ELSE
         dfUserLev( dbLogin->(RECNO())-1 )
         dfUserName( dbLogin->cUser )
      ENDIF
   ELSE
      IF M->A==K_ESC
         nCheck:=3
      ELSE
         IF nCheck<3
            dbMsgErr( dfStdMsg(MSG_DFLOGIN06) +;
                      dfStdMsg(MSG_DFLOGIN07) +;
                      dfStdMsg(MSG_DFLOGIN08)  )
         ELSE
            dbMsgErr( dfStdMsg(MSG_DFLOGIN09) +;
                      dfStdMsg(MSG_DFLOGIN10) +;
                      dfStdMsg(MSG_DFLOGIN11)  )
         ENDIF
      ENDIF
   ENDIF
   nCheck++
ENDDO

RETURN

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
PROCEDURE dfCngPwd()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL cPwd, cUser, cPwd1
LOCAL cUserName, nUserLev
LOCAL aCTRL := {}

// Disable automatic use of ADS
setADS( .F. )

nUserLev  := dfUserLev()
cUserName := dfUserName()
dfLogin()
IF dfUserLev()>0
   dfPushArea()

   dbCfgOpen("dbLogin")

   cPwd  := SPACE( LEN(dbLogin->cPassWord) )
   cPwd1 := SPACE( LEN(dbLogin->cPassWord) )
   cUser := PADR( cUserName, LEN(dbLogin->cUser) )

   ATTACH "01" TO aCTRL GET cPWD                         ;
                       AT  3, 12                         ;
                       PROMPT dfStdMsg(MSG_DFLOGIN15)    ;
                       PROMPTAT 1, 1                     ;
                       MESSAGE dfStdMsg(MSG_DFLOGIN15)   ;
                       PICTUREGET "@P"+REPLICATE("!",LEN(cPWD))

   ATTACH "02" TO aCTRL GET cPWD1                        ;
                       AT  7, 12                         ;
                       PROMPT dfStdMsg(MSG_DFLOGIN16)    ;
                       PROMPTAT 5, 1                     ;
                       MESSAGE dfStdMsg(MSG_DFLOGIN16)   ;
                       PICTUREGET "@P"+REPLICATE("!",LEN(cPWD1))

   ATTACH "03" TO aCTRL GET cUser                        ;
                       AT  11, 1                         ;
                       PROMPT dfStdMsg(MSG_DFLOGIN17)    ;
                       PROMPTAT 9, 1                     ;
                       MESSAGE dfStdMsg(MSG_DFLOGIN17)   ;
                       PICTUREGET REPLICATE("X",LEN(cUser))

   IF dbLogin->(RECNO())#1 .AND. !dbLogin->(EOF())

      WHILE M->A!=K_ESC
         cPwd  := SPACE( LEN(dbLogin->cPassWord) )
         cPwd1 := SPACE( LEN(dbLogin->cPassWord) )
         dfAutoForm( NIL, NIL, aCTRL, dfStdMsg(MSG_DFLOGIN14),,,.F. )
         IF M->A!=K_ESC
            IF LEN(ALLTRIM(cPwd))<8 .AND. LEN(dbLogin->cPassWord)>=8
               dbMsgErr( dfStdMsg(MSG_DFLOGIN12) +;
                         dfStdMsg(MSG_DFLOGIN19) )
            ELSE
               IF cPwd==cPWD1  
                     dbLogin->cPassWord := dfRecDec( cPwd )
                     dbLogin->cUser     := cUser
                     dfUserName( cUser )
                     dfUpdChk()
                     M->A := K_ESC
               ELSE
                  dbMsgErr( dfStdMsg(MSG_DFLOGIN12) +;
                            dfStdMsg(MSG_DFLOGIN13)  )
               ENDIF
            ENDIF
         ENDIF
      ENDDO
   ENDIF
   dfPopArea()
ELSE
   dfUserLev( nUserLev )
   dfUserName( cUserName )
ENDIF

// Enable automatic use of ADS
setADS( .T. )

RETURN


* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfSetPwd( nLevel, cPassWord, cUser )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lLock, lSuccess := .T.
IF LEN(cPassWord)==LEN(dbLogin->cPassWord)
   dblogin->(DBGOTO(nLevel+1))  // Set Level
   lLock := dbLogin->( ASCAN(dfLockList(),RECNO())!=0 ) // Already Locked
   IF !lLock   // If isnt lock it
      lSuccess := dbLogin->(dfNet( NET_RECORDLOCK, 0 ))
   ENDIF
   IF lSuccess // If locked upgrade
      dbLogin->cPassWord := dfRecDec( cPassWord )
      IF !EMPTY(cUser)
         dbLogin->cUser := cUser
      ENDIF
   ENDIF
   IF !lLock   // UNLOCK
      lSuccess := dbLogin->(dfNet( NET_RECORDUNLOCK ))
   ENDIF
   dfUpdChk()
   lSuccess := .T.
ELSE
   lSuccess := .F.
ENDIF
RETURN lSuccess

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfPwdInfo( nLev )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL cPassWord
dbLogin->(DBGOTO( nLev+1 ))
cPassWord := dfDecode( dbLogin->cPassWord, ALLTRIM(STR(dbLogin->(RECNO()))) )
RETURN dfStrInv( PADR( cPassWord, LEN(dbLogin->cPassWord) ) )

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfPwdName( nLev )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
dbLogin->(DBGOTO( nLev+1 ))
RETURN dbLogin->cUser

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfFoundPwd( cPwd )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet:=.F.
dbLogin->(DBGOTOP())
dbLogin->(DBSKIP())   // Skip first Record

WHILE !dbLogin->(EOF()) .AND. ;
       dfRecDec( cPwd )#dbLogin->cPassWord
   dbLogin->(DBSKIP())
ENDDO

IF !dbLogin->(EOF())
   lRet:=.T.
ENDIF

RETURN lRet

// Enable/disable automatic use of ADS 
// WORKAROUND to PDR 3512 of Alaska Software
// Gerr 3888 Simone 27-aug-03
STATIC FUNCTION setADS( lEnable )
   STATIC cOrigVal

   IF cOrigVal == NIL
      cOrigVal := dfSet("XbaseAXSAutoUse") 
      DEFAULT cOrigVal TO "YES"
   ENDIF

   IF lEnable
      dfSet("XbaseAXSAutoUse", cOrigVal) 
   ELSE
      dfSet("XbaseAXSAutoUse", "NO") 
   ENDIF
RETURN NIL
