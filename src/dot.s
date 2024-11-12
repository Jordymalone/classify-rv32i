.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    # Prologue
    addi sp, sp, -32
    sw ra, 28(sp)
    sw s0, 24(sp)
    sw s1, 20(sp)
    sw s2, 16(sp)
    sw s3, 12(sp)
    sw s4, 8(sp)
    sw s5, 4(sp)
    sw s6, 0(sp)

    mv s0, a0                               # a0: Pointer to first input array                               
    mv s1, a1                               # a1: Pointer to second input array
    mv s2, a2                               # a2: Number of elements to process
    mv s3, a3                               # a3: stride1
    mv s4, a4                               # a4: stride2

    li t0, 1
    blt s2, t0, error_terminate
    blt s3, t0, error_terminate
    blt s4, t0, error_terminate

    li s5, 0                                # Represent Sum
    li s6, 0                                # Represent Index

loop_start:
    bge s6, s2, loop_end                    # if s6 >= s2, then loop_end

    mv a1, s6                               # Copy multiplicand into a1
    mv a2, s3                               # Copy multiplier into a2
    jal mul
    mv t2, a0                               # Copy result into t2

    slli t2, t2, 2                          # t2 = t2 * 4
    add t2, s0, t2                          # t2 = input1_addr + offset
    lw t3, 0(t2)

    mv a1, s6
    mv a2, s4
    jal mul
    mv t2, a0

    slli t2, t2, 2
    add t2, s1, t2
    lw t4, 0(t2)

    mv a1, t3                               # multiplicand
    mv a2, t4                               # multiplier
    jal mul
    mv t2, a0

    add s5, s5, t2                          # sum += t2
    addi s6, s6, 1                          # add index
    j loop_start

loop_end:
    mv a0, s5

    # Epilogue
    lw ra, 28(sp)
    lw s0, 24(sp)
    lw s1, 20(sp)
    lw s2, 16(sp)
    lw s3, 12(sp)
    lw s4, 8(sp)
    lw s5, 4(sp)
    lw s6, 0(sp)
    addi sp, sp, 32
    jr ra

error_terminate:
    blt s2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit

mul:
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw s1, 4(sp)
    sw s2, 0(sp)

    mv s1, a1
    mv s2, a2
    li s0, 0

mul_loop:
    beq s2, x0, mul_done
    add s0, s0, s1                          # sum += multiplicand
    addi s2, s2, -1                         # multiplier -= 1
    j mul_loop

mul_done:
    mv a0, s0                               # copy result back into a0

    lw ra, 12(sp)
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw s2, 0(sp)
    addi sp, sp, 16
    ret