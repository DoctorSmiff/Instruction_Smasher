
        ARM
        REQUIRE8
        PRESERVE8

        AREA ||i.getc||, CODE, READONLY, ALIGN=2

getc PROC
        MOV      r1,#0x60000000
|L1.4|
        LDR      r0,[r1,#0x18]
        TST      r0,#0x10
        BNE      |L1.4|
        LDR      r0,[r1,#0]
        BICS     r2,r0,#0xff
        MVNNE    r0,#0
        STRNE    r0,[r1,#4]
        BX       lr
        ENDP


        AREA ||i.putc||, CODE, READONLY, ALIGN=2

putc PROC
        CMP      r0,#0xa
        MOV      r2,#0x68000000
        MOVEQ    r1,#0xd
        STREQ    r1,[r2,#0]
        STR      r0,[r2,#0]
        BX       lr
        ENDP


        AREA ||i.puts||, CODE, READONLY, ALIGN=2

puts PROC
        MOV      r3,r0
        PUSH     {lr}
        B        |L3.20|
|L3.12|
        ADD      r3,r3,#1
        BL       putc
|L3.20|
        LDRB     r0,[r3,#0]
        CMP      r0,#0
        BNE      |L3.12|
        POP      {pc}
        ENDP


        AREA ||i.tstc||, CODE, READONLY, ALIGN=2

tstc PROC
        MOV      r0,#0x60000000
        LDR      r0,[r0,#0x18]
        MOV      r1,#1
        BIC      r0,r1,r0,LSR #4
        BX       lr
        ENDP
