//*****************************************************************************
//Progetto       : dBsee 4.0
//Descrizione    : Funzioni di utilita' VARIE
//Programmatore  : Baccan Matteo
//*****************************************************************************
#include "dfMsg.ch"
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfVer()    // Versione della libreria
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN _LibType()                                           +;
       IF( dBsee4AXS()," ADS ", "" )                        +;
       IF( dfRealMode(), " Real ", " Protected " ) +"mode " +;
       dfStdMsg(MSG_LANGUAGE)                               +;
       " " +dfNumVer()                                      +;
       " - Date " +dfLibDate()                              +;
       IF( dfIsDebug(), " (DEBUG)", "" )

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfNumVer() // Versione della libreria
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN "5.0 "  // SIMONE 13/05/2004 IN VISUAL DBSEE DEVE TORNARE 5.0!!
