.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0                    # Assume arr[0] is the biggest element
    li t2, 1                    # Initialize the loop variable (start from element 2)
loop_start:
    # TODO: Add your own implementation
    bge t2, a1, DONE            # if t2 >= a1, then DONE

    slli t3, t2, 2              # t3 = t2 * 4
    add t3, a0, t3              # t3 = base_addr + offset
    lw t4, 0(t3)                # Load t3 into t4

    ble t4, t0, NEXT_LOOP       # if t4 <= t0, then NEXT_LOOP

    mv t0, t4                   # Update the value
    mv t1, t2                   # Update the index

NEXT_LOOP:
    addi t2, t2, 1              # Next loop
    j loop_start

handle_error:
    li a0, 36
    j exit

DONE:
    mv a0, t1
    ret