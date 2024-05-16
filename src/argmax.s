.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Error checks
    li t0, 0 # t0：i
    li t4, 1 # res
    blt a1, t4, bad

    # Prologue


loop_start:
    add t1, a0, zero  # t1: &a
    li t3, 0 # t3:0

loop_continue:
# 遍历数组，找最大最左的
    bge t0, a1, loop_end

    lw t2, 0(t1) # t2：a[i]

    addi t1, t1, 4
    addi t0, t0, 1 
    
    #检查值
    ble t2, t3, loop_continue
    mv t3, t2
    addi a0, t0, -1 #t0 已经被 + 1了
    j loop_continue

loop_end:
    # Epilogue

    jr ra

bad:
    li a0, 36
    j exit
    # Epilogue