TITLE Numero
.MODEL SMALL
.STACK 100h
.DATA

MSG1 DB 'Digite um caractere: $'
SIM DB 10,13,'O caractere digitado e um numero.$'
NAO DB 10,13,'O caractere digitado nao e um numero.$'
.CODE

; Permite o acesso às variáveis definidas em .DATA
MOV AX,@DATA
MOV DS,AX

; Exibe na tela a string MSG1 (“Digite um caractere: ”)
MOV AH,9
MOV DX,OFFSET MSG1
INT 21h

; Lê um caractere do teclado e salva o caractere lido em AL
MOV AH,1
INT 21h

; Copia o caractere lido para BL
MOV BL,AL

; Compara o caractere em BL com o caractere '0'
CMP BL,'0'

; Se o caractere em BL for menor que '0', salta para o rotulo NAOENUMERO
JB NAOENUMERO

; Compara o caractere em BL com o caractere '9'
CMP BL,'9'

; Se o caractere em BL for maior que '9', salta para o rotulo NAOENUMERO
JA NAOENUMERO

; Se chegou ate aqui, exibe na tela dizendo que o caractere e um numero
MOV AH,9
MOV DX,OFFSET SIM
INT 21h

; Salta para o rótulo FIM
JMP FIM

; Define o rótulo NAOENUMERO
NAOENUMERO:

; Exibe na tela dizendo que o caractere nao e um numero
MOV AH,9
MOV DX,OFFSET NAO
INT 21h

; Define o rótulo FIM
FIM:

; Finaliza o programa
MOV AH,4Ch
INT 21h

END

;----------------------------------- O que o programa faz? -----------------------------------;

; O programa pede para o usuário digitar um caractere na tela. Depois, ele verifica se o caractere digitado é um número, ou seja, se está entre '0' e '9'.
