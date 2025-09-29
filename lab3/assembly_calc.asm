section .data
    msg_add      db "Addition Result: ", 0
    msg_add_len  equ $ - msg_add

    msg_mul      db "Multiplication Result: ", 0
    msg_mul_len  equ $ - msg_mul

    newline      db 0xA
    newline_len  equ $ - newline

section .bss
    result_str resb 16    ; Buffer to store result as string

section .text
    global _start

_start:
    ; -------- Hard-coded numbers ----------
    mov eax, 7          ; First number
    mov ebx, 5          ; Second number

    ; -------- Addition ----------
    mov ecx, eax        ; Store eax in ecx
    add ecx, ebx        ; ecx = eax + ebx
    mov edi, ecx        ; Save result for printing

    ; Print addition message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg_add
    mov edx, msg_add_len
    int 0x80

    ; Print addition result
    mov eax, edi
    call print_number

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 0x80

    ; -------- Multiplication ----------
    mov eax, 7
    mov ebx, 5
    imul ebx           ; EAX = EAX * EBX
    mov edi, eax       ; Save result

    ; Print multiplication message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mul
    mov edx, msg_mul_len
    int 0x80

    ; Print multiplication result
    mov eax, edi
    call print_number

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, newline_len
    int 0x80

    ; -------- Exit Program ----------
    mov eax, 1
    xor ebx, ebx
    int 0x80

; --------------------------------------
; Convert number in EAX to string and print
; --------------------------------------
print_number:
    mov ecx, result_str + 15  ; Point to end of buffer
    mov byte [ecx], 0         ; Null terminator

print_loop:
    dec ecx
    xor edx, edx
    mov ebx, 10
    div ebx                   ; EAX = EAX / 10, EDX = remainder
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz print_loop

    ; Write result
    mov eax, 4
    mov ebx, 1
    mov edx, result_str + 15
    sub edx, ecx
    mov eax, 4
    mov ebx, 1
    mov edx, result_str + 15
    sub edx, ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, ecx
    int 0x80
    ret
