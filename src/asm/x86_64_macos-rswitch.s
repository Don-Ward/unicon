#
# Context switch for AMD64 small model.  (Position-independent code.)
# Barry Schwartz, January 2005.
#
# Adapted to OSX/clang by Jafar Al-Gharaibeh, April 2016
#

        .file       "rswitch.s"
 
.L0:    .string     "new_context() returned in coswitch"

        .text
        .globl      _coswitch
_coswitch:
        # coswitch(old_cstate, new_cstate, first)
        #
        #     %rdi     old_cstate
        #     %rsi     new_cstate
        #     %edx     first (equals 0 if first activation)
        #

        movq    %rsp, 0(%rdi)      # Old stack pointer -> old_cstate[0]
        movq    %rbp, 8(%rdi)      # Old base pointer -> old_cstate[1]
        movq    %rbx, 16(%rdi)     # Old bx -> old_cstate[2]
        movq    %r12, 24(%rdi)     # Old r12 -> old_cstate[3]
        movq    %r13, 32(%rdi)     # Old r13 -> old_cstate[4]
        movq    %r14, 40(%rdi)     # Old r14 -> old_cstate[5]
        movq    %r15, 48(%rdi)     # Old r15 -> old_cstate[6]
        #
        movq    0(%rsi), %rsp      # new_cstate[0] -> new stack pointer
        movq    8(%rsi), %rbp      # new_cstate[1] -> new base pointer
        movq    16(%rsi), %rbx     # new_cstate[2] -> new bx
        orl     %edx, %edx         # Is this the first activation?
        je      .L1                # If so, skip the rest and call new_context
        movq    24(%rsi), %r12     # new_cstate[3] -> new r12
        movq    32(%rsi), %r13     # new_cstate[4] -> new r13
        movq    40(%rsi), %r14     # new_cstate[5] -> new r14
        movq    48(%rsi), %r15     # new_cstate[6] -> new r15
        ret     # to new coexpression
.L1:    xorl    %edi, %edi         # Call new_context((int) 0, (ptr) 0)
        xorl    %esi, %esi         # (Implicitly zero-extended to 64 bits)
        callq    _new_context
        leaq    .L0(%rip), %rdi    # Call syserr(...)
        movl    $0, %eax
        jmp     _syserr
