
        ARM
        REQUIRE8
        PRESERVE8

        AREA ||i.LED_tests||, CODE, READONLY, ALIGN=2

LED_tests PROC
        PUSH     {r4,r5,lr}
        MVN      r0,#0xff00
        MOV      r4,#0x68000000
        STR      r0,[r4,#4]
        MOV      r5,#0
        STR      r5,[r4,#0]
        LDR      r3,|L1.96|
        MOV      r12,r5
|L1.32|
        MOV      r2,#0x100
        MOV      r1,#0
|L1.40|
        STR      r2,[r4,#0]
        LSL      r2,r2,#1
        MOV      r0,#0
|L1.52|
        ADD      r0,r0,#1
        CMP      r0,r3
        BCC      |L1.52|
        ADD      r1,r1,#1
        CMP      r1,#8
        BCC      |L1.40|
        ADD      r12,r12,#1
        CMP      r12,#0xf
        STRCS    r5,[r4,#0]
        BCC      |L1.32|
        POP      {r4,r5,pc}
        ENDP

|L1.96|
        DCD      0x00004e20

        AREA ||i.deleteChar||, CODE, READONLY, ALIGN=2

deleteChar PROC
        PUSH     {r0-r8,lr}
        MOV      r5,r0
        ADR      r0,|L2.252|
        LDR      r0,[r0,#0]
        MOV      r4,r2
        STR      r0,[sp,#0xc]
        MOV      r7,r3
        ADR      r0,|L2.256|
        LDM      r0,{r2,r3}
        LDR      r0,[r0,#8]
        LDR      r8,[sp,#0x28]
        STRD     r2,r3,[sp,#0]
        STR      r0,[sp,#8]
        LDR      r0,[r7,#0]
        CMP      r0,#0
        MOVEQ    r0,r1
        BEQ      |L2.124|
        LDRB     r0,[r1,#-1]
        SUB      r6,r1,#1
        CMP      r0,#9
        LDREQ    r0,[r4,#0]
        BEQ      |L2.152|
        ADD      r0,sp,#0xc
        BL       puts
        LDR      r0,[r4,#0]
        SUB      r0,r0,#1
        STR      r0,[r4,#0]
|L2.108|
        LDR      r0,[r7,#0]
        SUB      r0,r0,#1
        STR      r0,[r7,#0]
        MOV      r0,r6
|L2.124|
        ADD      sp,sp,#0x10
        POP      {r4-r8,pc}
|L2.132|
        ADD      r0,sp,#0xc
        BL       puts
        LDR      r0,[r4,#0]
        SUB      r0,r0,#1
        STR      r0,[r4,#0]
|L2.152|
        CMP      r0,r8
        MOVLE    r8,sp
        BGT      |L2.132|
        B        |L2.204|
|L2.168|
        LDRB     r0,[r5,#0]
        CMP      r0,#9
        LDR      r0,[r4,#0]
        BEQ      |L2.216|
        ADD      r0,r0,#1
        STR      r0,[r4,#0]
        LDRB     r0,[r5,#0]
        BL       putc
|L2.200|
        ADD      r5,r5,#1
|L2.204|
        CMP      r5,r6
        BCC      |L2.168|
        B        |L2.108|
|L2.216|
        AND      r0,r0,#7
        ADD      r0,r0,r8
        BL       puts
        LDR      r0,[r4,#0]
        AND      r1,r0,#7
        RSB      r1,r1,#8
        ADD      r0,r0,r1
        STR      r0,[r4,#0]
        B        |L2.200|
        ENDP

|L2.252|
        DCB      "\b \b",0
|L2.256|
        DCB      "        ",0
        DCB      0
        DCB      0
        DCB      0

        AREA ||i.dumpMemory||, CODE, READONLY, ALIGN=2

dumpMemory PROC
        PUSH     {r4-r6,lr}
        MOV      r5,r0
        SUB      sp,sp,#0x50
        MOV      r0,#0xa
        BL       putc
        MOV      r6,#0
|L3.24|
        MOV      r0,#0x3a
        BL       putc
        MOV      r4,#0
|L3.36|
        LDR      r1,[r5,#0]
        MOV      r0,sp
        BL       unsigned_to_hex_string
        MOV      r0,sp
        BL       puts
        ADD      r5,r5,#4
        MOV      r0,#0x2c
        BL       putc
        ADD      r4,r4,#1
        CMP      r4,#2
        BCC      |L3.36|
        MOV      r0,#0xa
        BL       putc
        ADD      r6,r6,#1
        CMP      r6,#2
        BCC      |L3.24|
        MOV      r0,#0xa
        BL       putc
        MOV      r0,#1
        ADD      sp,sp,#0x50
        POP      {r4-r6,pc}
        ENDP


        AREA ||i.erase_flash||, CODE, READONLY, ALIGN=2

erase_flash PROC
        PUSH     {r4-r6,lr}
        LDR      r5,|L4.48|
        LDR      r0,|L4.52|
        MOV      r4,#0
        BL       puts
        MOV      r0,#1
        MOV      r1,#0x60000
        STR      r0,[r1,#0]
|L4.32|
        ADD      r4,r4,#1
        CMP      r4,r5
        BLT      |L4.32|
        POP      {r4-r6,pc}
        ENDP

|L4.48|
        DCD      0x00002af8
|L4.52|
        DCD      ||.constdata||

        AREA ||i.individualTests||, CODE, READONLY, ALIGN=2

individualTests PROC
        PUSH     {r4,lr}
        SUB      sp,sp,#0x30
        MOV      r4,#0
        STR      r4,[sp,#0x28]
|L5.16|
        ADR      r0,|L5.180|
        BL       puts
        ADR      r0,|L5.212|
        BL       puts
        ADR      r0,|L5.228|
        BL       puts
        ADR      r0,|L5.244|
        BL       puts
        ADR      r0,|L5.260|
        BL       puts
        ADR      r0,|L5.272|
        BL       puts
        MOV      r1,sp
        ADR      r0,|L5.304|
        STRB     r4,[sp,#0]
        BL       readLine
        ADD      r1,sp,#0x28
        MOV      r0,sp
        BL       asciiToHex
        LDR      r0,[sp,#0x28]
        CMP      r0,#1
        ADREQ    r0,|L5.328|
        BEQ      |L5.144|
        CMP      r0,#2
        BEQ      |L5.152|
        CMP      r0,#3
        MOVNE    r0,#0
        BNE      |L5.172|
        ADR      r0,|L5.352|
        BL       puts
        BL       LED_tests
        ADR      r0,|L5.372|
|L5.144|
        BL       puts
        B        |L5.16|
|L5.152|
        ADR      r0,|L5.392|
        BL       puts
        BL       aes_tests
        BL       des_tests
        B        |L5.16|
|L5.172|
        ADD      sp,sp,#0x30
        POP      {r4,pc}
        ENDP

