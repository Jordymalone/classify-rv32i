.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error     
    li t1, 0                    # Initialize loop variable

loop_start:
    # TODO: Add your own implementation
    bge t1, a1, DONE            # if t1 >= a1, then DONE
    slli t2, t1, 2              # t2 = t1 * 4
    add t2, a0, t2              # t2 = base_addr + offset

    lw t3, 0(t2)                # Load arr[t1] into t3
    blt t3, x0 SET_ZERO         # if t3 < 0, then set zero

    addi t1, t1, 1              # else add t1 to next index
    j loop_start

SET_ZERO:
    li t3, 0

NEXT:
    sw t3, 0(t2)                # set zero then store back into arr
    addi t1, t1, 1              # next index

    j loop_start

error:
    li a0, 36          
    j exit          

DONE:
    ret