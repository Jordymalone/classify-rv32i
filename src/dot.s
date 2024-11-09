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

    li t0, 0                                # Represent Sum
    li t1, 0                                # Represent Index

loop_start:
    bge t1, a2, loop_end                    # if t1 >= a2, then loop_end
    # TODO: Add your own implementation

    # Calculate addr of first input[t1]
    mul t2, t1, a3                          # t2 = index * stride1
    slli t2, t2, 2                          # t2 = t2 * 4 (offset)
    add t2, a0, t2                          # t2 = input1_addr + offset
    lw t3, 0(t2)

    # Calculate addr of second input[t1], reuse t2
    mul t2, t1, a4                          # t2 = index * stride2
    slli t2, t2, 2                          
    add t2, a1, t2
    lw t4, 0(t2)

    # Compute
    mul t2, t3, t4                          # t2 = t3 * t4
    add t0, t0, t2                          # t0 = t0 + t2 (sum)

    addi t1, t1, 1                          # next index
    j loop_start

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
