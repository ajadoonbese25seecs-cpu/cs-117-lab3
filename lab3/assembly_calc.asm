section .data
    prompt_num1 db 'Enter first number: ', 0
    prompt_num2 db 'Enter second number: ', 0
    prompt_op db 'Enter operation (+ or -): ', 0
    result_msg db 'Result: ', 0
    error_msg db 'Invalid operation!', 0xA, 0
    newline db 0xA, 0

section .bss
    num1 resb 16        ; Buffer for first number
    num2 resb 16        ; Buffer for second number
    operation resb 2    ; Buffer for operation (+ or -)
    result resq 1       ; Store result

section .text
    global _start

_start:
    ; Print prompt for first number
    mov rax, 1          ; Syscall: write
    mov rdi, 1          ; File descriptor: stdout
    mov rsi, prompt_num1
    mov rdx, 20         ; Length of prompt_num1
    syscall

    ; Read first number
    mov rax, 0          ; Syscall: read
    mov rdi, 0          ; File descriptor: stdin
    mov rsi, num1
    mov rdx, 16
    syscall

    ; Print prompt for second number
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_num2
    mov rdx, 21         ; Length of prompt_num2
    syscall

    ; Read second number
    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 16
    syscall

    ; Print prompt for operation
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_op
    mov rdx, 24         ; Length of prompt_op
    syscall

    ; Read operation
    mov rax, 0
    mov rdi, 0
    mov rsi, operation
    mov rdx, 2
    syscall

    ; Convert first number to integer
    mov rsi, num1
    call atoi
    mov rbx, rax        ; Store first number in rbx

    ; Convert second number to integer
    mov rsi, num2
    call atoi
    mov rcx, rax        ; Store second number in rcx

    ; Check operation
    mov al, [operation]
    cmp al, '+'
    je add_numbers
    cmp al, '-'
    je sub_numbers
    jmp invalid_op

add_numbers:
    add rbx, rcx
    mov [result], rbx
    jmp print_result

sub_numbers:
    sub rbx, rcx
    mov [result], rbx
    jmp print_result

invalid_op:
    mov rax, 1
    mov rdi, 1
    mov rsi, error_msg
    mov rdx, 18         ; Length of error_msg
    syscall
    jmp exit

print_result:
    ; Print "Result: "
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, 8          ; Length of result_msg
    syscall

    ; Convert result to string and print
    mov rax, [result]
    call itoa
    mov rax, 1
    mov rdi, 1
    mov rsi, num1       ; Reusing num1 buffer for output
    mov rdx, 16
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

exit:
    ; Exit program
    mov rax, 60         ; Syscall: exit
    mov rdi, 0          ; Status: 0
    syscall

; Function: atoi (convert string to integer)
atoi:
    xor rax, rax        ; Clear rax
    xor rcx, rcx        ; Clear rcx (digit counter)
atoi_loop:
    movzx rdx, byte [rsi + rcx]
    cmp rdx, 0xA        ; Check for newline
    je atoi_done
    cmp rdx, 0          ; Check for null terminator
    je atoi_done
    sub rdx, '0'        ; Convert ASCII to number
    imul rax, 10
    add rax, rdx
    inc rcx
    jmp atoi_loop
atoi_done:
    ret

; Function: itoa (convert integer to string)
itoa:
    mov rbx, num1       ; Use num1 buffer for output
    mov rcx, 0          ; Digit counter
    cmp rax, 0
    jge itoa_positive
    mov byte [rbx], '-'
    inc rbx
    inc rcx
    neg rax
itoa_positive:
    mov r8, 10          ; Base 10
    mov r9, rbx         ; Save start of buffer
itoa_loop:
    xor rdx, rdx
    div r8              ; rax = quotient, rdx = remainder
    add dl, '0'         ; Convert to ASCII
    mov [rbx], dl
    inc rbx
    inc rcx
    cmp rax, 0
    jne itoa_loop
    ; Reverse the string
    mov rsi, r9
    mov rdi, rbx
    dec rdi
    mov r8, rcx
    shr r8, 1           ; Divide length by 2
reverse_loop:
    cmp r8, 0
    je itoa_done
    mov al, [rsi]
    mov bl, [rdi]
    mov [rsi], bl
    mov [rdi], al
    inc rsi
    dec rdi
    dec r8
    jmp reverse_loop
itoa_done:
    mov byte [rbx], 0   ; Null terminate
    ret