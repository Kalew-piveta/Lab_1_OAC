.data
nome_arquivo: .asciiz "entrada.asm"
buffer: .space 100
tam_buffer: .word 100
mif_header: .asciiz "DEPTH = 16384;\nWIDTH = 32;\nADDRESS_RADIX = HEX;\nDATA_RADIX = HEX;\nCONTENT\nBEGIN\n"
mif_footer: .asciiz "END;\n"


.text
.globl main

# Função para criar o arquivo de saída .mif
# Argumentos: 
#   $a0 - Endereço base do array de dados
#   $a1 - Tamanho do array de dados
#   $a2 - Nome do arquivo
create_mif_file:
    # Abre o arquivo para escrita
    li $v0, 13         # Código da syscall para abrir arquivo
    move $a0, $a2      # Passa o endereço do nome do arquivo para $a0
    li $a1, 1          # Modo de escrita
    li $a2, 0          # Permissões (não usado para escrita)
    syscall           # Chama a syscall

    # Escreve o cabeçalho do arquivo MIF
    li $v0, 15         # Código da syscall para escrever arquivo
    li $a2, 86         # Tamanho do cabeçalho (86 bytes)
    la $a1, mif_header  # Endereço do cabeçalho
    syscall           # Chama a syscall

    # Escreve os dados no arquivo MIF
    li $v0, 15         # Código da syscall para escrever arquivo
    move $a0, $a2      # Passa o descritor de arquivo para $a0
    la $a1, 0($a0)     # Endereço do array de dados
    li $a2, (4 * $a1)      # Tamanho dos dados em bytes (4 bytes por palavra)
    syscall           # Chama a syscall

    # Escreve o rodapé do arquivo MIF
    li $v0, 15         # Código da syscall para escrever arquivo
    li $a2, 6          # Tamanho do rodapé (6 bytes)
    la $a1, mif_footer  # Endereço do rodapé
    syscall           # Chama a syscall

    # Fecha o arquivo
    li $v0, 16         # Código da syscall para fechar arquivo
    syscall           # Chama a syscall

    # Retorna
    jr $ra            # Retorna à função chamadora

main:
    # Abrir o arquivo .asm
    li $v0, 13         # Código da syscall para abrir arquivo
    la $a0, nome_arquivo # Endereço da string com o nome do arquivo
    li $a1, 0          # Modo de leitura
    li $a2, 0          # Permissões (não usado para leitura)
    syscall           # Chama a syscall

    # Inicializar variáveis
    li $t0, 0          # Inicializa um contador de linhas
    li $t1, 0          # Inicializa um marcador para verificar início da .data
    la $t2, buffer     # Endereço do buffer para armazenar a linha

read_loop:
    li $v0, 14         # Código da syscall para ler arquivo
    move $a0, $v0      # Passa o descritor de arquivo para $a0
    move $a1, $t2      # Passa o endereço do buffer para $a1
    li $a2, tam_buffer  # Tamanho máximo do buffer
    syscall           # Chama a syscall

    # Verificar se encontrou o início da .data
    beq $t1, 1, process_data
    li $t1, 1
    b read_loop

process_data:
    # Chama a função para criar o arquivo .mif
    la $a0, buffer     # Endereço base do array de dados
    li $a1, tam_buffer # Tamanho do array de dados (tamanho do buffer)
    la $a2, "saida.mif" # Nome do arquivo de saída
    jal create_mif_file

    # Fecha o arquivo .asm
    li $v0, 16         # Código da syscall para fechar arquivo
    syscall           # Chama a syscall

    # Encerra o programa
    li $v0, 10         # Código da syscall para encerrar o programa
    syscall           # Chama a syscall
