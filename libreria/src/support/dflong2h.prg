FUNCTION dfLong2Hex(n)
RETURN PADL(dfNum2Base(n, "0123456789ABCDEF"), 8, "0")
