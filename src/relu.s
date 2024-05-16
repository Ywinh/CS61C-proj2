.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Error checks
    li t0, 1 # t0：i
    blt a1, t0, bad
    
    # Prologue

loop_start: #做一些循环之前的准备工作 类似for(int i=0;i<j;i++)中 int i = 0 的工作
    add t1, a0, zero  # t1: &a
    li t3, 0 # t3:0

loop_continue:
 # 遍历数组，<0 的 = 0，>=0的不变
    bgt t0, a1, loop_end

    lw t2, 0(t1) # t2：a[i]

    addi t1, t1, 4
    addi t0, t0, 1 
    
    #检查值
    bgt t2, zero, loop_continue
    sw t3,-4(t1) # t1已经加过4，需要在这里使用 -4 的地址

    j loop_continue
loop_end:

    jr ra

bad:
    li a0, 36
    j exit
    # Epilogue
