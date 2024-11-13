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
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0                            # Represent sum
    li t1, 0                            # Represent count

    bge t1, a2, loop_end
    slli a3, a3, 2                      # stride1 * 4 for later move index
    slli a4, a4, 2                      # stride2 * 4 for later move index

loop_start:
    # TODO: Add your own implementation
    addi t1, t1 1
    lw t3, 0(a0)                        # Load multiplicand into t3
    lw t4, 0(a1)                        # Load multiplier into t4
    
    # mul t2, t3, t4
    li t2, 0                            # Represent product

mul_loop:
    andi t5, t4, 1                      # Check multiplier LSB is 1 or not
    beqz t5, skip_add
    add t2, t2, t3                      # Add multiplicand into t2

skip_add:
    slli t3, t3, 1
    srli t4, t4, 1
    bnez t4, mul_loop

    add t0, t0, t2                      # Add product (t3 * t4) into sum
    add a0, a0, a3                      # Move to next index
    add a1, a1, a4
    blt t1, a2, loop_start              # if count < number of elements, then loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit