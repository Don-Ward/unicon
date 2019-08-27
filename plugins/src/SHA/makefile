################################################################################
# 
# This file is released under the terms of the GNU LIBRARY GENERAL PUBLIC LICENSE
# (LGPL) version 2. The licence may be found in the root directory of the Unicon
# source directory in the file COPYING.
#
################################################################################
#
#     Makefile for the SHA plugin
#
#     Don Ward
#     August 2019
#
################################################################################
include ../../../Makedefs

SHALIB = shalib.so
CFLAGS = -I ..
RFCDIR = ./RFC6234
RFC6234Files = $(RFCDIR)/sha1.o $(RFCDIR)/sha224-256.o ./$(RFCDIR)/sha384-512.o \
			./$(RFCDIR)/usha.o ./$(RFCDIR)/hkdf.o ./$(RFCDIR)/hmac.o
UFLAGS = -K -s 

.PHONY: Test QuickTest CLEAN All

.SUFFIXES: .c .o
.c.o:			$(CC) $(CFLAGS) -c $<

All: shaPlugTest $(SHALIB) 

SecureHash.u: SecureHash.icn
	-unicon $(UFLAGS) -u -c $< -o $@

$(SHALIB): ShaCproc.o $(RFC6234Files)
	$(CC) -Xlinker -dylib -Xlinker -undefined -Xlinker dynamic_lookup -shared -o $(SHALIB) $?

$(RFC6234Files):
	cd $(RFCDIR); $(MAKE)

shaPlugTest: shaPlugTest.icn SecureHash.u $(SHALIB)
	-unicon $(UFLAGS) -u shaPlugTest

Test:	shaPlugTest $(SHALIB)
	@echo "**** The GrandSlam test takes a while to finish; be patient. ****"
	./shaPlugTest All

QuickTest: shaPlugTest $(SHALIB)
	./shaPlugTest Defaults SecureHash Errors

CLEAN:
	rm -f *.u *.o *.so shaPlugTest
	cd $(RFCDIR); $(MAKE) CLEAN

# Temporary test code
testLoadFunc: testLoadFunc.icn SecureHash.u $(SHALIB)
	unicon -u $@



