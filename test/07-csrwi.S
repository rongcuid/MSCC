# No exception here!
reset:	j main
vec_ill_inst:	j vec_ill_inst
vec_misaligned:	j vec_misaligned

main:
	j test_csrwi

test_failed:
	j test_failed

test_csrwi:
	# mscratch
	csrwi mscratch, 0xA
	csrr x1, mscratch
	li x2, 0xA
	bne x1, x2, test_failed
	
	# mepc
	csrwi mepc, 0xB
	csrr x1, mepc
	li x2, 0x8
	bne x1, x2, test_failed
	
	# mcause
	csrwi mcause, 0xC
	csrr x1, mcause
	li x2, 0xC
	bne x1, x2, test_failed

        # mtvec. Ignores lower two bits
        csrwi mtvec, 0x1
        csrr x1, mtvec
        bnez x1, test_failed
        csrwi mtvec, 0x8
        csrr x1, mtvec
        li x2, 8
        bne x1, x2, test_failed
	
	# mtval. May be called mbadaddr
	csrwi mbadaddr, 0x1
	csrr x1, mbadaddr
	li x2, 0x1
	bne x1, x2, test_failed
	
	# mcycle
	csrwi mcycle, 0xE
	li x2, 0xF
	csrr x1, mcycle
	bne x1, x2, test_failed
	csrwi mcycle, 0
        csrr x1, mcycle
        bnez x1, test_failed

	# minstret
	csrwi minstret, 0x1
	li x2, 0x2
	csrr x1, minstret
	bne x1, x2, test_failed

	# mcycleh
	csrwi mcycleh, 0x3
	li x2, 0x3
	csrr x1, mcycleh
	bne x1, x2, test_failed

	# minstreth
	csrwi minstreth, 0x4
	li x2, 0x4
	csrr x1, minstreth
	bne x1, x2, test_failed

        # mstatus
        csrwi mstatus, 0x1 # ignored
        csrr x1, mstatus
        li x2, 0b00000000000000000001100000000000
        bne x2, x1, test_failed
        csrwi mstatus, 0x8 # mie
        li x2, 0b00000000000000000001100000001000
        csrr x1, mstatus
        bne x1, x2, test_failed

	j main
