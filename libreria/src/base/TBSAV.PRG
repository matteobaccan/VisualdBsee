//*****************************************************************************
//Progetto       : dBsee 4.0
//Descrizione    : Funzioni di utilita' per tBrowse
//Programmatore  : Baccan Matteo
//*****************************************************************************
#include "dfwin.ch"
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
PROCEDURE tbSav( oTbr ) //
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
IF oTbr:W_SAVESCREENID # NIL
   dbScrSav( oTbr:W_SAVESCREENID ,;
             TBREALTOP( oTbr )     ,;
             TBREALLEFT( oTbr )    ,;
             TBREALBOTTOM( oTbr )  +IF(oTbr:W_SHADOW,1,0) ,;
             TBREALRIGHT( oTbr )   +IF(oTbr:W_SHADOW,2,0)  )
ENDIF
RETURN

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
PROCEDURE tbRes( oTbr ) //
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
IF oTbr:W_SAVESCREENID # NIL
   dbScrRes( oTbr:W_SAVESCREENID )
ENDIF
RETURN
