/******************************************************************************
Project     : dBsee for Xbase++
Description : Utilities Function
Programmer  : Simone Degl'Innocenti
******************************************************************************/

#include "dll.ch"

// Ritorna le directory windows e system
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfGetWindowsDirectory()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN _GetDir("GetWindowsDirectoryA")

* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfGetSystemDirectory()
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
RETURN _GetDir("GetSystemDirectoryA")


STATIC FUNCTION _GetDir(cFunc)
   LOCAL cPath :="  "
   LOCAL n

   // dimensione necessaria per allocare il buffer
   n := DLLCALL("Kernel32.dll", DLL_STDCALL, cFunc , @cPath, 0)
   IF n <= 0
      RETURN ""
   ENDIF

   // alloca lo spazio (+2) per il chr(0) +
   cPath := SPACE(n+2)

   n := DLLCALL("Kernel32.dll", DLL_STDCALL, cFunc , @cPath, LEN(cPath))
   IF n <= 0
      RETURN ""
   ENDIF

   // Toglie il chr(0)
   dfGetCString(@cPath)
RETURN cPath
