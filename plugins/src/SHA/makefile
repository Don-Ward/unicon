################################################################################
# 
# This file is released under the terms of the GNU LIBRARY GENERAL PUBLIC LICENSE
# (LGPL) version 2. The licence may be found in the root directory of the Unicon
# source directory in the file COPYING.
#
# It uses source code that is copyrighted by the IETF trust.
# See the file RFC6234/sha.h for the conditions governing the redistribution
# and use of that code.
#
# Note that the original RFC6234 source code has been modified to be
# thread-safe. The original code may be used by compiling it with the
# ORIGINAL_SHA_CODE_NOT_THREAD_SAFE symbol defined.
# 
################################################################################
#
#     Makefile for the SHA class and support routines
#
#     Don Ward
#     June 2019
#
################################################################################
SHALIB = shalib.so
CFLAGS = -I ..
RFCDIR = ./RFC6234
RFC6234Files = $(RFCDIR)/sha1.o $(RFCDIR)/sha224-256.o ./$(RFCDIR)/sha384-512.o \
			./$(RFCDIR)/usha.o ./$(RFCDIR)/hkdf.o ./$(RFCDIR)/hmac.o

.PHONY: Test QuickTest CLEAN All

.SUFFIXES: .c .o
.c.o:			$(CC) $(CFLAGS) -c $<

All: shaPlugTest $(SHALIB) 

SecureHash.u: SecureHash.icn
	-unicon -u -c $< -o $@

$(SHALIB): ShaCproc.o $(RFC6234Files)
	$(CC) -Xlinker -dylib -Xlinker -undefined -Xlinker dynamic_lookup -shared -o $(SHALIB) $?

$(RFC6234Files):
	cd $(RFCDIR); $(MAKE)

shaPlugTest: shaPlugTest.icn SecureHash.u $(SHALIB)
	-unicon -u shaPlugTest

Test:	shaPlugTest $(SHALIB)
	@echo "**** The GrandSlam test takes a while to finish; be patient. ****"
	./shaPlugTest All

QuickTest: shaPlugTest $(SHALIB)
	./shaPlugTest SecureHash Defaults Errors

Clean:
	rm -f ../../lib/$(SHALIB)
	rm -f *.u *.o *.so shaPlugTest
	cd $(RFCDIR); $(MAKE) Clean

Install:
	cp $(SHALIB) ../../lib

# Temporary test code
testLoadFunc: testLoadFunc.icn SecureHash.u $(SHALIB)
	unicon -u $@



