.data
 
.balign 4
a: .skip 0x00100000

.text
 
.global main
main:
    mov r0, #0 /* Setting r0 = 0 */
    ldr r1, addr_of_a       /* r1 = &a */
    mov r2, #0              /* r2 = 0 (r2 is counter) */
    ldr r4, =0x00000000 /* r4 = 0 */
    sub r8, r4, #1 /* r8 = 0 - 1 : 1 */
    ldr r6, =0x00040000 /* Setting r6 to a quarter of MB */
initialLoop1:
    cmp r2, r6              /* Checking to see if a mb has been written */
    beq reset1        /* If so, leave the loop, otherwise continue */
    add r3, r1, r2, LSL #2  /* r3 = r1 + (r2*4) */
    str r8, [r3]            /* *r3 = r8 */
    add r2, r2, #1          /* r2 = r2 + 1 */
    b initialLoop1          /* Go to the beginning of the loop */
reset1:
    ldr r2, =0x00000000 /* Resetting counter */
    b read1
read1:
    cmp r2, r6 /* Checking if loop is finished */
    beq reset3 /* Go to reset */
    add r3, r1, r2, LSL #2  /* r3 = r1 + (r2*4) */
    ldr r10, [r3] /* r10 = r3 */
    cmp r10, r8 /* Check if r10 equals r8 */
    add r2, r2, #1 /* Increment counter */
    bne error1 /* If not match then go to error */
    b read1 /* Loop */
reset3:
    ldr r2, =0x00000000 /* Resetting counter */
    b initialLoop2
initialLoop2:
    cmp r2, r6              /* Checking to see if a mb has been written */
    beq reset2                 /* If so, leave the loop, otherwise continue */
    add r3, r1, r2, LSL #2  /* r3 = r1 + (r2*4) */
    str r4, [r3]            /* *r3 = r4 */
    add r2, r2, #1          /* r2 = r2 + 1 */
    b initialLoop2          /* Go to the beginning of the loop */
reset2:
    ldr r2, =0x00000000 /* Resetting counter */
    b read2
read2:
    cmp r2, r6 /* Checking if loop is finished */
    beq end /* Go to end */
    add r3, r1, r2, LSL #2  /* r3 = r1 + (r2*4) */
    ldr r10, [r3] /* r10 = r3 */
    cmp r10, r4 /* Check if r10 equals r4 */
    add r2, r2, #1 /* Increment counter */
    bne error /* If not match then go to error */
    b read2 /* Loop */
end:
    mov r0, #0 /* Print 0 when program ends */
    bx lr
error1:
    mov r0, #1 /* Print 1 when program ends */
    bx lr
error2:
    mov r0, #2 /* Print 2 when program ends */
    bx lr 
addr_of_a: .word a
