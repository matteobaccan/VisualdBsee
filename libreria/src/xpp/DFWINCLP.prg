/*******************************************************************************
Progetto       : dBsee 4.6
Descrizione    : Funzioni di utilita'
Programmatore  : Baccan Matteo
*******************************************************************************/

#include "Common.ch"
#include "dfWindow.ch"
#include "xbp.ch"

STATIC oClipboard := NIL

// * ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
// FUNCTION Main(  )
// * ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
// 
//      IF dfIsWin() // Is in Windows Task
//         dfWinFullScr()  // Set to full screen
// 
//         ? "Windows Version ", dfWinVer()
// 
//         IF dfIsWinClp()
//            ? "Clipboard Supported"
//            ? "Clipboard Version : " , dfWinClpVer()
// 
//            dfWinClpOpen()  // Open Clipboard
//            ? "Clipboard Size    : " , dfWinClpSize()
//            ? "Clipboard Get     : " , dfWinClpGet()
// 
//            ? "Empty Clipboard"
//            dfWinClpEmpty() // Empty the old value
//            ? "Clipboard Size    : " , dfWinClpSize()
//            ? "Clipboard Get     : " , dfWinClpGet()
// 
//            ? "Clipboard Set     : This text is put "+;
//                                   "in Windows"
//            dfWinClpSet("This text is put in Windows")
// 
//            ? "Clipboard Size    : " , dfWinClpSize()
//            ? "Clipboard Get     : " , dfWinClpGet()
// 
//            dfWinClpClose() // Close ClipBoard
//         ENDIF
//      ENDIF
// 
// RETURN NIL


* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfIsWinClp()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
DEFAULT oClipboard TO XbpClipBoard():new()
RETURN (oClipboard!=NIL)

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpOpen()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet := .F.

IF dfIsWinClp()
   oClipboard:CREATE()
   oClipboard:OPEN()
   lRet := .T.
ENDIF
RETURN lRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpClose()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet := .F.

IF dfIsWinClp()
   oClipboard:DESTROY()
   oClipboard:CLOSE()
   lRet := .T.
ENDIF
RETURN lRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpEmpty()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet := .F.

IF dfIsWinClp()
   lRet := dfWinClpSet( "" )
ENDIF
RETURN lRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpGet( nType )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL cRet := ""

IF dfIsWinClp()
   DEFAULT nType TO WIN_CLP_DATA_TEXT // Text

   nType := dfClp2Xpp( nType )

   cRet := oClipboard:getBuffer( nType )
ENDIF

RETURN cRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpVer()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL cRet := ""
IF dfIsWinClp()
   cRet := "2.0"
ENDIF
RETURN cRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpSet( cBuffer, nType )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL lRet := .F.

IF dfIsWinClp()
   lRet := oClipboard:setBuffer( cBuffer )
ENDIF
RETURN lRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfWinClpSize( nType )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL nRet := 0

IF dfIsWinClp()
   nRet := LEN(dfWinClpGet( nType ))
ENDIF
RETURN nRet

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
STATIC FUNCTION dfClp2Xpp( nType )
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL nRet := XBPCLPBRD_TEXT

DO CASE
   CASE nType==WIN_CLP_DATA_TEXT; nRet := XBPCLPBRD_TEXT
   CASE nType==WIN_CLP_DATA_BMP ; nRet := XBPCLPBRD_BITMAP
   CASE nType==WIN_CLP_DATA_META; nRet := XBPCLPBRD_METAFILE
ENDCASE

RETURN nRet
