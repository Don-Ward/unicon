
include ../Makedefs

TARGETS=$(patsubst %.icn,%,$(wildcard *.icn))

SKIP= tester FxPtTests AssertKywdTest\
      audio dbi list_test nlm q rec test testnlm clin_err hello mintest ovld q2 sel to

Test: DoTest

include ../Makefile.test

FxPtTest: FxPtTest.icn tester.u

FxPtTest_OVLD: FxPtTest_OVLD.icn tester.u

tester.u: tester.icn
	$(UC) -s -u -c $^

AssertKywd: AssertKywd.icn AssertKywdTest.u

AssertKywdTest.u: AssertKywdTest.icn tester.u
	$(UC) -s -u -c $^



