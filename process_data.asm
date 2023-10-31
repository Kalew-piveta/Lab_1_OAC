.data
    inputFileName: .asciiz "C:\Users\kalew\Desktop\---UNB---\OAC\Lab_1_OAC\example_saida.asm"
    outputDataFileName: .asciiz "data.mif"
    buffer: .space 256  # Buffer para armazenar uma linha de código
    dataMemoryStart: .word 0x2000  # Endereço inicial para área .data
    reading_data: .word 1  # Flag indicando se está lendo .data (1) ou .text (0)
    cabecalho: .ascii "DEPTH = 16384;\nWIDTH = 32;\nADDRESS_RADIX = HEX;\nDATA_RADIX = HEX;\nCONTENT\nBEGIN\n"
    nova_linha: .ascii "\n"
    error_open_msg: .asciiz "Erro ao abrir o arquivo.\n"
.text
    # Função para abrir arquivo
    open_file:
        li $v0, 13      # Syscall para abrir arquivo para leitura
        la $a0, inputFileName
        li $a1, 0       # Modo de leitura
        li $a2, 0       # Permissões padrão
        syscall
        bge $v0, 0, error_open  # Verifica se houve erro
        jr $ra

    # Função para ler linha de arquivo
    read_line:
        li $v0, 14      # Syscall para ler uma linha
        move $a0, $v0   # $a0 terá o identificador do arquivo
        la $a1, buffer   # $a1 terá o endereço do buffer
        li $a2, 256     # $a2 terá o tamanho máximo da linha
        syscall
        move $a1, $v0   # $a1 terá o endereço do buffer
        jr $ra

    # Função para processar a área .data
    process_data_area:
        # Abrir arquivo de entrada
        jal open_file

        # Abrir arquivo de saída para a área .data
        li $v0, 13      # Syscall para abrir arquivo para escrita
        la $a0, outputDataFileName
        li $a1, 1       # Modo de escrita
        li $a2, 0       # Permissões padrão
        syscall

        # Pular a primeira linha (cabeçalho) do arquivo de saída MIF
        la $a0, outputDataFileName
        li $v0, 4       # Syscall para escrever string
        li $a1, 0       # Modo de escrita
        la $a2, cabecalho
        syscall

    read_loop:
        # Ler uma linha do arquivo
        jal read_line

        # Verificar se chegou ao final do arquivo
        beq $v0, $zero, end_read_loop

        # Verificar se está lendo .text
        lw $t0, reading_data
        beq $t0, $zero, end_read_loop  # Se lendo .text, parar de ler

        # Processar a linha (implementação requerida)
        # ...

        # Escrever a instrução em MIF
        # ...

        # Continuar lendo o arquivo
        j read_loop

    end_read_loop:
        # Adicionar finalização do arquivo MIF
        # ...

        # Fechar arquivo de entrada
        li $v0, 16      # Syscall para fechar arquivo
        move $a0, $v0   # $a0 terá o identificador do arquivo
        syscall

        # Fechar arquivo de saída para a área .data
        li $v0, 16      # Syscall para fechar arquivo
        move $a0, $v0   # $a0 terá o identificador do arquivo
        syscall

        # Terminar o programa
        li $v0, 10      # Syscall para terminar o programa
        syscall

    error_open:
        # Mensagem de erro de abertura do arquivo (implementação requerida)
        # Pode ser uma simples string indicando o erro.
     
        
           li $v0, 4
           la $a0, error_open_msg
           syscall

    # Sub-rotinas adicionais podem ser implementadas aqui

    # Função para traduzir instrução da área .data para hexadecimal
    # Recebe o endereço em $a0 e a instrução em $a1
    # Retorna o código hexadecimal em $v0
    translate_data_instruction:
        lw $v0, 0($a0)   # Carrega a instrução da memória .data
        jr $ra

    # Função para fechar arquivo com adição de nova linha
    close_file_with_newline:
        li $v0, 13      # Syscall para abrir arquivo para escrita
        la $a0, outputDataFileName
        li $a1, 1       # Modo de escrita
        li $a2, 0       # Permissões padrão
        syscall

        # Adiciona um caractere de nova linha no final do arquivo
        li $v0, 4       # Syscall para escrever string
        li $a1, 0       # Modo de escrita
        la $a2, nova_linha    # Nova linha
        syscall

        # Fecha o arquivo
        li $v0, 16      # Syscall para fechar arquivo
        move $a0, $v0   # $a0 terá o identificador do arquivo
        syscall
        jr $ra
