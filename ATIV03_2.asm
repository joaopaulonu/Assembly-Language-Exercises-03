; Ponto de partida para programas .COM
[org 0x100]

; --- Seção de Dados ---

section .data
    msg_entrada db "Digite um caractere (ESC para finalizar): $"
    msg_letra db "O caractere digitado e uma letra.$"
    msg_numero db "O caractere digitado e um numero.$"
    msg_desconhecido db "O caractere digitado e um caractere desconhecido.$"
    msg_fim db "Fim do programa.$"
    
; --- Seção de Código ---
section .text
    global _start

_start:
    ; Este é o comeco do nosso programa.

main_loop:
    ; O coracao do programa, onde a gente faz a repeticao.

    ; 1. Mostra a mensagem de entrada
    mov ah, 09h              
    mov dx, msg_entrada      
    int 21h                  

    ; 2. Le o caractere que o usuario digitar
    mov ah, 01h              
    int 21h                  
    mov bl, al               

    ; Adiciona uma nova linha para a proxima mensagem
    mov ah, 02h              
    mov dl, 0dh            
    int 21h
    mov dl, 0ah              
    int 21h

    ; 3. Checa se o caractere e ESC (o numero 27 na tabela ASCII)
    cmp bl, 27               
    je end_program           

    ; 4. Checa se o caractere e uma letra
    cmp bl, 'A'              
    jl check_number         
    cmp bl, 'Z'              
    jle is_letter            

    cmp bl, 'a'              
    jl check_number         
    cmp bl, 'z'              
    jle is_letter            

    ; 5. Se nao for letra, a gente checa se e numero
check_number:
    cmp bl, '0'              
    jl is_unknown            
    cmp bl, '9'              
    jle is_number            

    ; 6. Se nao e letra nem numero, so pode ser desconhecido
is_unknown:
    mov ah, 09h
    mov dx, msg_desconhecido
    int 21h
    jmp main_loop            

is_letter:
    mov ah, 09h
    mov dx, msg_letra
    int 21h
    jmp main_loop            
    
is_number:
    mov ah, 09h
    mov dx, msg_numero
    int 21h
    jmp main_loop           

end_program:
    ; A gente so chega aqui se o usuario digitou ESC.
    
    ; Mostra a mensagem de fim
    mov ah, 09h
    mov dx, msg_fim
    int 21h
    
    ; Finaliza o programa
    mov ax, 4c00h            
    int 21h
