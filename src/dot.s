.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:
    # Error checks
    li t0, 1 
    blt a2, t0, bad_len
    blt a3, t0, bad_stride
    blt a4, t0, bad_stride

    # Prologue
    addi sp, sp, -60      
    sw   gp, 56(sp)        
    sw   tp, 52(sp)        # 保存线程指针寄存器 tp
    sw   s0, 48(sp)        # 保存保存寄存器 s0/fp
    sw   s1, 44(sp)        # 保存保存寄存器 s1
    sw   s2, 40(sp)        # 保存保存寄存器 s2
    sw   s3, 36(sp)        # 保存保存寄存器 s3
    sw   s4, 32(sp)        # 保存保存寄存器 s4
    sw   s5, 28(sp)        # 保存保存寄存器 s5
    sw   s6, 24(sp)        # 保存保存寄存器 s6
    sw   s7, 20(sp)        # 保存保存寄存器 s7
    sw   s8, 16(sp)        # 保存保存寄存器 s8
    sw   s9, 12(sp)        # 保存保存寄存器 s9
    sw   s10, 8(sp)        # 保存保存寄存器 s10
    sw   s11, 4(sp)        # 保存保存寄存器 s11


loop_start:
    mv t1, a0  # t1: arr0
    
    mv t2, a1 # t2: arr1
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
    li t3, 0 # t3: res
    li t4, 1# times

    li t0, 4
    mul t5, a3, t0 #arr0 offset
    mul t6, a4, t0 #arr1 offset

loop_continue:
    #每次前进各自的 stride，相乘
    bgt t4,a2,loop_end

    lw s0, 0(t1)
    lw s1, 0(t2)
    mul s0, s0, s1
    add t3, t3, s0

    addi t4,t4,1
    add t1,t1,t5
    add t2,t2,t6
    
    j loop_continue


loop_end:
    mv a0, t3

    # Epilogue
    lw   gp, 56(sp)       
    lw   tp, 52(sp)        # 恢复线程指针寄存器 tp
    lw   s0, 48(sp)        # 恢复保存寄存器 s0/fp
    lw   s1, 44(sp)        # 恢复保存寄存器 s1
    lw   s2, 40(sp)        # 恢复保存寄存器 s2
    lw   s3, 36(sp)        # 恢复保存寄存器 s3
    lw   s4, 32(sp)        # 恢复保存寄存器 s4
    lw   s5, 28(sp)        # 恢复保存寄存器 s5
    lw   s6, 24(sp)        # 恢复保存寄存器 s6
    lw   s7, 20(sp)        # 恢复保存寄存器 s7
    lw   s8, 16(sp)        # 恢复保存寄存器 s8
    lw   s9, 12(sp)        # 恢复保存寄存器 s9
    lw   s10, 8(sp)        # 恢复保存寄存器 s10
    lw   s11, 4(sp)        # 恢复保存寄存器 s11
    addi sp, sp, 60        # 恢复栈指针
ebreak
    jr ra
bad_len:
    li a0, 36
    j exit
bad_stride:
    li a0, 37
    j exit
    