; File: fibonacci.asm

section .text
    global fibonacci_iterative

fibonacci_iterative:
    ; Prologue
    push    rbp
    mov     rbp, rsp
    
    ; Register n (input) is in RDI (according to System V AMD64 ABI)
    ; Result will be in RAX

    ; Handle base cases: n = 0 (returns 0) and n = 1 (returns 1)
    mov     rax, 0          ; Result accumulator (F0 = 0)
    mov     rcx, 1          ; Counter/Next value (F1 = 1)
    
    cmp     rdi, 0          ; Is n == 0?
    je      .done           ; If yes, return 0 (RAX is 0)

    cmp     rdi, 1          ; Is n == 1?
    je      .n_is_one       ; If yes, jump to set RAX to 1

    ; Loop setup
    mov     rdx, rdi        ; RDX = n
    sub     rdx, 1          ; Loop counter = n - 1 (since F0 and F1 are handled)

.loop_start:
    ; Calculate next Fibonacci number: next = current + previous
    mov     rbx, rax        ; Save current (previous F) to RBX
    add     rax, rcx        ; New Current (F_i) = F_(i-1) + F_(i-2). Result is in RAX
    mov     rcx, rbx        ; New Previous (F_(i-1)) = Old Current (F_(i-2))

    ; Loop control
    loop    .loop_start     ; Decrements RCX and jumps if RCX != 0.
                            ; Oh wait, we used RDX as counter. Let's fix that.
                            ; Corrected loop control:

    mov     rcx, rdx        ; Use RDX for loop count
.iterative_loop:
    mov     rbx, rax        ; Previous F (F_(i-2))
    add     rax, rcx        ; F_i = F_(i-1) + F_(i-2) (RAX = F_i)
    mov     rcx, rbx        ; F_(i-1) = F_(i-2) (RCX = F_(i-1))
    
    ; The logic above is slightly flawed for a clean iteration. 
    ; Let's use two registers for F_i and F_{i-1} properly.
    
    ; Proper Iterative Setup:
    mov     rsi, 0          ; F_{i-2} (a = 0)
    mov     r8, 1           ; F_{i-1} (b = 1)
    
    cmp     rdi, 0
    je      .done_zero
    cmp     rdi, 1
    je      .done_one
    
    mov     rcx, rdi        ; RCX = n
    sub     rcx, 1          ; Loop n-1 times (start from F1)

.fibo_loop:
    mov     rbx, rsi        ; RBX = F_{i-2}
    add     rsi, r8         ; F_{i-1} = F_{i-2} + F_{i-1} (New F_{i-1})
    mov     r8, rbx         ; F_{i-2} = Old F_{i-2}
    
    ; We need to switch the roles after calculation. 
    ; Let's reset the logic to be clean:
    ; a = F_{i-2}, b = F_{i-1}, temp = a + b, a = b, b = temp

    mov     rsi, 0          ; a (F0)
    mov     rdi, 1          ; b (F1)
    
    cmp     rdi, 0
    je      .done_zero_final
    cmp     rdi, 1
    je      .done_one_final
    
    mov     rcx, rdx        ; Loop count (n-1)

.fibo_iter_final:
    mov     rbx, rdi        ; temp = b
    add     rdi, rsi        ; b = b + a (New F_i)
    mov     rsi, rbx        ; a = temp (Old F_{i-1})

    loop    .fibo_iter_final

    mov     rax, rdi        ; Result is in RAX (b holds F_n)
    jmp     .epilogue

.done_zero_final:
    mov     rax, 0          ; F0 = 0
    jmp     .epilogue

.done_one_final:
    mov     rax, 1          ; F1 = 1
    jmp     .epilogue

.n_is_one:
    mov     rax, 1

.done:
    ; RAX already contains the result (0 or 1)

.epilogue:
    pop     rbp
    ret