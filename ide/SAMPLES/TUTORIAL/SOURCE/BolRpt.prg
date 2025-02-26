/******************************************************************************
 Progetto       : Tutorial
 Sottoprogetto  : Tutorial
 Programma      : V:\SAMPLES\TUTORIAL\source\BolRpt.prg
 Template       : V:\bin\..\tmp\xbase\report.tmp
 Descrizione    : Stampa Testata / Dettaglio Bolla
 Programmatore  : Demo
 Data           : 13-07-06
 Ora            : 16.44.00
******************************************************************************/


#INCLUDE "common.ch"
#INCLUDE "dfReport.ch"
#INCLUDE "dfNet.ch"

* #COD OITOP0 * #END Punto di dichiarazione file INCLUDE *.ch per file sorgente
MEMVAR Act, Sa, A, EnvId, SubId, BackFun           //  Variabili di ambiente dBsee

STATIC aFile     := {}                            ,; // Array dei file aperti dall'oggetto
       aBuffer   := {}                            ,; // Array generalizzato per oggetto report
       aVRec     := {}                               // Array del record virtuale



* #COD OITOP1 * #END Punto di dichiarazione STATICHE a livello di file sorgente

      /* 旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
         �                 TABELLA METODI DELL'OGGETTO REPORT                             �
         쳐컴컫컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         � n� � mtd.           � Descrizione                                              �
         쳐컴컵컴컴컴컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         �  1 � exe            � Esecutore                                                �
         �  2 � dbf            � Apre la base dati                                        �
         �  3 � dfCreateGVr    � Crea il record virtuale (static function)                �
         �  4 � repini         � Inizializza bande di default (static function)           �
         쳐컴컨컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         �                 METODI PRESENTI SOLO SE UTILIZZATI                             �
         쳐컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴캑
         �    � Qry                                � Attiva la chiamata al modulo di query�
         �    � <FILE>Header/body/footer           � Funzioni di gestione bande del report�
         �    � <FILE>Clear                        � Inizializza le variabili di calcolo  �
         �    � <FILE>Add                          � Incrementa le variabili di calcolo   �
         읕컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸 */


*******************************************************************************
FUNCTION BolRptExe( ;                              // [ 01 ]  ESECUTORE OPERAZIONI
                     nMode      ,;                 // nMode = PRINT_ALL     stampa tutto il report
                                 ;                 // nMode = PRINT_CURRENT Stampa il record corrente del file master
                     nUserMenu  ,;                 // Tipo menu di stampa
                                 ;                 // PM_MENU     Menu di configurazione
                                 ;                 // PM_MESSAGE  Warning di stampa
                                 ;                 // PM_NUL      Nessun avviso
                     cIdPrinter ,;                 // Identificatore di stampante
                     cIdPort    ,;                 // Nome porta di uscita
                     lQry       ,;                 // .T. = esegue la query
                     nOrder     ,;                 // Numero indice file master
                     bKey       ,;                 // Chiave di primo posizionamento file master
                     bFilter    ,;                 // Condizione di filtro sul file master
                     bBreak      )                 // Condizione di break sul file master
*******************************************************************************
* #COD OBEXE0 * #END //  esegue le operazioni elementari dell'oggetto

DEFAULT nMode TO PRINT_ALL                         // Stampa l'intero report
DEFAULT lQry  TO nMode==PRINT_ALL                  // Esegue la query

PRIVATE  EnvId:="BolRpt" ,SubId:=""                // Variabili di ambiente per report

aBuffer := dfPrnCfg()                              //  Inizializzazione array statico ( vedere Norton Guide )

IF BolRptDbf()                                     // Apertura File
   IF EMPTY( aVRec )
      dfCreateGVR( aVRec )                         // Creazione Record Virtuale
   ENDIF

   * #COD OIEXE0 * #END Prima dell'aggiornamento di chiave, filtro e break

   dfUpdVr( aVRec, nOrder, bKey, bFilter, bBreak )  // Aggiorna chiave, filtro e break per file master
   IF RepIni( nUserMenu, cIdPrinter, cIdPort )     // Inizializzazione Report
      dfPrnStart( aVRec, nMode )                   // Avvia la stampa per l'oggetto report
   ENDIF
ENDIF

dfClose( aFile, .T., .T. )                         // Chiusura file dell'oggetto ( vedere Norton Guide )

* #COD OAEXE0 * #END //  esegue le operazioni elementari dell'oggetto

RETURN .T.

*******************************************************************************
FUNCTION BolRptDbf()                               // [ 02 ] APERTURA DATABASE
*******************************************************************************
* #COD OBDBF0 * #END //  apertura della base dati

/*旼컴컴컴컴컴컴컴커
  �  MASTER FILE   �
  읕컴컴컴컴컴컴컴켸*/
IF !dfUse( "T_Bolle", 1 ,aFile ) ;RETU .F. ;END

/*旼컴컴컴컴컴컴컴커
  �  RELATION FILE �
  읕컴컴컴컴컴컴컴켸*/
IF !dfUse( "R_Bolle", 1 ,aFile ) ;RETU .F. ;END
IF !dfUse( "Clienti", 1 ,aFile ) ;RETU .F. ;END
IF !dfUse( "Province", 1 ,aFile ) ;RETU .F. ;END
IF !dfUse( "P_Bolle", 1 ,aFile ) ;RETU .F. ;END
IF !dfUse( "Articoli", 1 ,aFile ) ;RETU .F. ;END
IF !dfUse( "Categ", 1 ,aFile ) ;RETU .F. ;END

* #COD OADBF0 * #END //  apertura della base dati

RETURN .T.


******************************************************************************
STATIC PROCEDURE dfCreateGVr( aVirRec )            // [ 03 ] CREAZIONE RECORD VIRTUALE
******************************************************************************
LOCAL VRloc                                        // array del record virtuale
LOCAL aFather                                      // array di supporto
LOCAL aGrp                                         // array di supporto

* #COD OBVRC0 * #END //  Creazione record virtuale


/* 旼컴컴컴컴컴컴컴컴컴커
   � blocco file master �
   읕컴컴컴컴컴컴컴컴컴켸 */

VRLoc := dfVRCreate( )
VRLoc[VR_NAME  ]    := "T_Bolle"                    // Nome del file

VRLoc[VR_ORDER ]    := 1                            // Numero indice file principale ( SET ORDER )
VRLoc[VR_EOF_MODE]  := VR_IGNORE                    // modalit� di scansione: ignore
VRLoc[VR_EJECT ]    := .F.                          // Salto pagina dopo raggruppamento


VRLoc[VR_BODY  ]    := {||T_BolleBody()}            // Code Block di attivazione banda
VRLoc[VR_ROWBODY  ] := 1                            // Numero di righe banda
VRLoc[VR_BRKBODY  ] := .F.                          // Salto pagina nella banda
VRLoc[VR_EJECTBODY] := .F.                          // Salto pagina dopo banda
VRLoc[VR_BODY2HEAD] := .F.                          // Reintesta con proprio header dopo il salto pagina
VRLoc[VR_BODY2FOOT] := .F.                          // Chiudi con proprio footer prima del salto pagina



* #COD OIVRAA0021 * #END
dfVrAddFle( aVirRec, {}, VRLoc )


/* 旼컴컴컴컴컴컴컴컴컴컴컴컴�
   � blocco file relazionato �
   읕컴컴컴컴컴컴컴컴컴컴컴컴� */
VRLoc := dfVRCreate( )
VRLoc[VR_NAME  ]    := "R_Bolle"                    // Nome del file

VRLoc[VR_KEY   ]    := {||T_Bolle->CodBol}          // chiave
VRLoc[VR_FILTER]    := {||.T.}                      // filtro
VRLoc[VR_BREAK ]    := {||R_Bolle->CodBol!=T_Bolle->CodBol}   // break di relazione
VRLoc[VR_EOF_MODE]  := VR_RECOVER                   // modalit� di scansione: recover
VRLoc[VR_EJECT ]    := .T.                          // Salto pagina dopo raggruppamento


VRLoc[VR_BODY  ]    := {||R_BolleBody()}            // Code Block di attivazione banda
VRLoc[VR_ROWBODY  ] := 1                            // Numero di righe banda
VRLoc[VR_BRKBODY  ] := .F.                          // Salto pagina nella banda
VRLoc[VR_EJECTBODY] := .F.                          // Salto pagina dopo banda
VRLoc[VR_BODY2HEAD] := .F.                          // Reintesta con proprio header dopo il salto pagina
VRLoc[VR_BODY2FOOT] := .F.                          // Chiudi con proprio footer prima del salto pagina


aFather := {}
aAdd( aFather , "T_Bolle" )
* #COD OIVRBA0021 * #END
dfVrAddFle( aVirRec, aFather, VRLoc )

* #COD OAVRC0 * #END //  Creazione record virtuale

RETURN

******************************************************************************
STATIC FUNCTION RepIni( nUserMenu, cIdPrinter, cIdPort )  // [ 04 ] INIZIALIZZAZIONE BANDE DI DEFAULT
******************************************************************************
* #COD OBINI0 * #END //  Inizializzazione bande di default

LOCAL lRet := .T.                                  //  Valore di ritorno

aBuffer[ REP_NAME ]          := "Stampa Testata / Dettaglio Bolla"  //  Intestazione report
aBuffer[ REP_VREC ]          := aVRec

// ReportManager
dfRepManReportSet(aBuffer, dfReportManagerPath()+"BolRpt.REP")


* #COD OIINI0 * #END Dopo inizializzazione bande di default

lRet := dfPrnMenu( aBuffer, nUserMenu, cIdPrinter, cIdPort )  //  Configurazione con parametri di layout

// Elementi dell'array aBuffer che riportano le marginature
// del report configurate nella funzione dfPrnMenu().
//
// Qualora si intenda modificare una o piu' voci, si copino
// quelle interessate opportunamente scommentate nel punto
// di iniezione sottostante.
//
// aBuffer[ REP_PAGELENGHT ] := 0                  //  numero di righe per pagina
// aBuffer[ REP_MGN_TOP ]    := 0                  //  Scostamento Header di pagina
// aBuffer[ REP_MGN_BOTTOM ] := 0                  //  Scostamento Footer di pagina
// aBuffer[ REP_MGN_LEFT ]   := 0                  //  margine sinistro da aggiungere ad ogni nuova riga

* #COD OAINI0 * #END //  Inizializzazione bande di default

RETURN lRet




******************************************************************************
STATIC PROCEDURE T_BolleBody()                       // Banda di body file T_Bolle
******************************************************************************
* #COD OBBAA  * #END // funzione di gestione banda di report
dfReportOutPut(    0,    1, T_Bolle->CodBol, {"CodBol","C",3,0},"T_BOLLE","T_Bolle->CodBol"  )
dfReportOutPut(    0,    2, T_Bolle->DatBol, {"DatBol","D",8,0},"T_BOLLE","T_Bolle->DatBol"  )
dfReportOutPut(    0,    3, T_Bolle->CodCli, {"CodCli","C",6,0},"T_BOLLE","T_Bolle->CodCli"  )
dfReportOutPut(    0,    4, T_Bolle->TipBol, {"TipBol","C",1,0},"T_BOLLE","T_Bolle->TipBol"  )
dfReportOutPut(    0,    5, T_Bolle->ScnBol, {"ScnBol","N",2,0},"T_BOLLE","T_Bolle->ScnBol"  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,    6, Clienti->CodCli, {"CodCli","C",6,0},"T_BOLLE","Clienti->CodCli"  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,    7, Clienti->RagCli, {"RagCli","C",30,0},"T_BOLLE","Clienti->RagCli"  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,    8, Clienti->IndCli, {"IndCli","C",30,0},"T_BOLLE","Clienti->IndCli"  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,    9, Clienti->CapCli, {"CapCli","C",5,0},"T_BOLLE","Clienti->CapCli"  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,   10, Clienti->CitCli, {"CitCli","C",13,0},"T_BOLLE","Clienti->CitCli"  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,   11, Clienti->NotCli, {"NotCli","M",10,0},"T_BOLLE","Clienti->NotCli"  )
Clienti->(dfS(1, T_Bolle->CodCli))
Province->(dfS(1, Upper(Clienti->PrvCli)))
dfReportOutPut(    0,   15, Province->DesPrv, {"DesPrv","C",20,0},"T_BOLLE","Province->DesPrv"  )
P_Bolle->(dfS(1, T_Bolle->CodBol))
dfReportOutPut(    0,   16, P_Bolle->CodVet, {"CodVet","C",2,0},"T_BOLLE","P_Bolle->CodVet"  )
P_Bolle->(dfS(1, T_Bolle->CodBol))
dfReportOutPut(    0,   17, P_Bolle->NotPie, {"NotPie","M",10,0},"T_BOLLE","P_Bolle->NotPie"  )
P_Bolle->(dfS(1, T_Bolle->CodBol))
dfReportOutPut(    0,   18,  dbTabGet( "Vettore", P_Bolle->CodVet, "RagVet" ) , {"RagVet","C",20,0},"T_BOLLE",""  )
Clienti->(dfS(1, T_Bolle->CodCli))
dfReportOutPut(    0,   32, Clienti->PrvCli, {"PrvCli","C",2,0},"T_BOLLE","Clienti->PrvCli"  )
* #COD OABAA  * #END // funzione di gestione banda di report
RETURN


******************************************************************************
STATIC PROCEDURE R_BolleBody()                       // Banda di body file R_Bolle
******************************************************************************
* #COD OBBBA  * #END // funzione di gestione banda di report
dfReportOutPut(    0,   19, R_Bolle->CodBol, {"CodBol","C",3,0},"R_BOLLE","R_Bolle->CodBol"  )
dfReportOutPut(    0,   20, R_Bolle->CodArt, {"CodArt","C",8,0},"R_BOLLE","R_Bolle->CodArt"  )
dfReportOutPut(    0,   21, R_Bolle->QtaArt, {"QtaArt","N",8,2},"R_BOLLE","R_Bolle->QtaArt"  )
dfReportOutPut(    0,   22, R_Bolle->PrzArt, {"PrzArt","N",8,2},"R_BOLLE","R_Bolle->PrzArt"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   23, Articoli->CodCat, {"CodCat","C",2,0},"R_BOLLE","Articoli->CodCat"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   24, Articoli->CodArt, {"CodArt","C",8,0},"R_BOLLE","Articoli->CodArt"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   25, Articoli->DesArt, {"DesArt","C",30,0},"R_BOLLE","Articoli->DesArt"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   28, Articoli->ArtTip, {"ArtTip","C",1,0},"R_BOLLE","Articoli->ArtTip"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   29, Articoli->EsiArt, {"EsiArt","C",1,0},"R_BOLLE","Articoli->EsiArt"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   30, Articoli->ColArt, {"ColArt","N",3,0},"R_BOLLE","Articoli->ColArt"  )
Articoli->(dfS(1, R_Bolle->CodArt))
dfReportOutPut(    0,   31, Articoli->NotArt, {"NotArt","M",10,0},"R_BOLLE","Articoli->NotArt"  )
Articoli->(dfS(1, R_Bolle->CodArt))
Categ->(dfS(1, Articoli->CodCat))
dfReportOutPut(    0,   33, Categ->DesCat, {"DesCat","C",30,0},"R_BOLLE","Categ->DesCat"  )
dfReportOutPut(    0,   34, R_Bolle->NumRigBol, {"NumRigBol","N",4,0},"R_BOLLE","R_Bolle->NumRigBol"  )
* #COD OABBA  * #END // funzione di gestione banda di report
RETURN


* #COD OIBOT1 * #END Fine file sorgente per oggetto report
