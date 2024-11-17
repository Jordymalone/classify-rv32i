# Assignment 2: Classify

## Supervisor
Jserv(Ching-Chun (Jim) Huang)

## Introduction
In this assignment, I'm going to implement fundamental matrix operations commonly used in neural networks, such as matrix multiplication. With this function, we can build a simple Artificial Neural Network (ANN) capable of classifying handwritten digit files.

### HackMD
[Assignment 2: Complete Applications](https://hackmd.io/@kjpqZJZeQHKQyZzsURxmsA/rkjhMKlGJg)

### Required Environment
GNU/Linux and macOS

## Part A: Mathematical Functions
### Task 1: ReLU
Implement a ReLU function that applies the transformation  \text{max}(a, 0)  to each element of a 1D row-major input vector, setting all negative values to 0.
$$\text{ReLU}(a) = \max(a, 0)$$
#### Logical Thinking
1. Compute the Address of the Current Element
2. Check and Update Negative Values to 0
3. Loop Until Completion

### Task 2: ArgMax
Implement the argmax function in argmax.s to find the index of the largest element in a vector. If there are duplicate maximum values, the function should return the smallest index among them.
#### Logical Thinking
1. Compute the Current Element Address
2. Compare with the Maximum Element
3. Update Maximum Element and Index
4. Repeat the Process

### Task 3.1: Dot Product
Implement the dot product function in dot.s, ensuring to account for stride when accessing vector elements. Overflow handling isn’t needed, so the mulh instruction is unnecessary.
$$\text{dot}(a, b) = \sum_{i=0}^{n-1} (a_i \cdot b_i)$$
#### Logical Thinking
1. LSB check of the Multiplier
2. Conditional Addition
3. Shift Operations
4. Loop Continuation

### Task 3.2: Matrix Multiplication
$$C[i][j] = \text{dot}(A[i], B[:, j])$$
1. Inner Loop End
    * After completing the first row across all columns, adjust the row position to move to the next row.
2. Outer Loop End
    * Restore the stack to maintain the proper state for subsequent operations.

## Part B: File Operations and Main
In Part B, the main focus is to modify the `mul` instructions using RV32I instructions.

### Task 1: Read Matrix
Implement the function to read a binary matrix from a file and load it into memory.

### Task 2: Write Matrix
Implement the function to write a matrix to a binary file.

### Task 3: Classification
Bring everything together to classify an input using two weight matrices and the ReLU and ArgMax functions. Use the following sequence:
1. Matrix Multiplication:
    * hidden_layer = matmul(m0, input)
2. ReLU Activation:
    * relu(hidden_layer)
3. Second Matrix Multiplication:
    * scores = matmul(m1, hidden_layer)
4. Classification:
    * Call `argmax` to find the index of the highest score

## Result
```
test_abs_minus_one (__main__.TestAbs) ... ok
test_abs_one (__main__.TestAbs) ... ok
test_abs_zero (__main__.TestAbs) ... ok
test_argmax_invalid_n (__main__.TestArgmax) ... ok
test_argmax_length_1 (__main__.TestArgmax) ... ok
test_argmax_standard (__main__.TestArgmax) ... ok
test_chain_1 (__main__.TestChain) ... ok
test_classify_1_silent (__main__.TestClassify) ... ok
test_classify_2_print (__main__.TestClassify) ... ok
test_classify_3_print (__main__.TestClassify) ... ok
test_classify_fail_malloc (__main__.TestClassify) ... ok
test_classify_not_enough_args (__main__.TestClassify) ... ok
test_dot_length_1 (__main__.TestDot) ... ok
test_dot_length_error (__main__.TestDot) ... ok
test_dot_length_error2 (__main__.TestDot) ... ok
test_dot_standard (__main__.TestDot) ... ok
test_dot_stride (__main__.TestDot) ... ok
test_dot_stride_error1 (__main__.TestDot) ... ok
test_dot_stride_error2 (__main__.TestDot) ... ok
test_matmul_incorrect_check (__main__.TestMatmul) ... ok
test_matmul_length_1 (__main__.TestMatmul) ... ok
test_matmul_negative_dim_m0_x (__main__.TestMatmul) ... ok
test_matmul_negative_dim_m0_y (__main__.TestMatmul) ... ok
test_matmul_negative_dim_m1_x (__main__.TestMatmul) ... ok
test_matmul_negative_dim_m1_y (__main__.TestMatmul) ... ok
test_matmul_nonsquare_1 (__main__.TestMatmul) ... ok
test_matmul_nonsquare_2 (__main__.TestMatmul) ... ok
test_matmul_nonsquare_outer_dims (__main__.TestMatmul) ... ok
test_matmul_square (__main__.TestMatmul) ... ok
test_matmul_unmatched_dims (__main__.TestMatmul) ... ok
test_matmul_zero_dim_m0 (__main__.TestMatmul) ... ok
test_matmul_zero_dim_m1 (__main__.TestMatmul) ... ok
test_read_1 (__main__.TestReadMatrix) ... ok
test_read_2 (__main__.TestReadMatrix) ... ok
test_read_3 (__main__.TestReadMatrix) ... ok
test_read_fail_fclose (__main__.TestReadMatrix) ... ok
test_read_fail_fopen (__main__.TestReadMatrix) ... ok
test_read_fail_fread (__main__.TestReadMatrix) ... ok
test_read_fail_malloc (__main__.TestReadMatrix) ... ok
test_relu_invalid_n (__main__.TestRelu) ... ok
test_relu_length_1 (__main__.TestRelu) ... ok
test_relu_standard (__main__.TestRelu) ... ok
test_write_1 (__main__.TestWriteMatrix) ... ok
test_write_fail_fclose (__main__.TestWriteMatrix) ... ok
test_write_fail_fopen (__main__.TestWriteMatrix) ... ok
test_write_fail_fwrite (__main__.TestWriteMatrix) ... ok

----------------------------------------------------------------------
Ran 46 tests in 21.026s

OK
```