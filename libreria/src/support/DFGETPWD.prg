* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
FUNCTION dfGetPwd( nRow, nCol, nLen, cCol ) // Input tipo BANCOMAT
* ħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħħ
LOCAL cStr := SPACE(nLen)

dfGetW( nRow, nCol, "PassWord", @cStr, "@P"+REPLICATE("X",nLen), .T. )

M->Act := "ret"
M->A := 13

RETURN UPPER(cStr)
