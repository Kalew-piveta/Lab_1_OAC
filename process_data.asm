.data
    inputFileName: .asciiz "C:\Users\kalew\Desktop\---UNB---\OAC\Lab_1_OAC\example_saida.asm"
    outputDataFileName: .asciiz "data.mif"
    buffer: .space 256  # Buffer para armazenar uma linha de c�digo
    dataMemoryStart: .word 0x2000  # Endere�o inicial para �rea .data
    reading_data: .word 1  # Flag indicando se est� lendo .data (1) ou .text (0)
    cabecalho: .ascii "DEPTH = 16384;\nWIDTH = 32;\nADDRESS_RADIX = HEX;\nDATA_RADIX = HEX;\nCONTENT\nBEGIN\n"
    nova_linha: .ascii "\n"
    error_open_msg: .asciiz "Erro ao abrir o arquivo.\n"
.text
    # Fun��o para abrir arquivo
    open_file:
        li $v0, 13      # Syscall para abrir arquivo para leitura
        la $a0, inputFileName
        li $a1, 0       # Modo de leitura
        li $a2, 0       # Permiss�es padr�o
        syscall
        bge $v0, 0, error_open  # Verifica se houve erro
        jr $ra

    # Fun��o para ler linha de arquivo
    read_line:
        li $v0, 14      # Syscall para ler uma linha
        move $a0, $v0   # $a0 ter� o identificador do arquivo
        la $a1, buffer   # $a1 ter� o endere�o do buffer
        li $a2, 256     # $a2 ter� o tamanho m�ximo da linha
        syscall
        move $a1, $v0   # $a1 ter� o endere�o do buffer
        jr $ra

    # Fun��o para processar a �rea .data
    process_data_area:
        # Abrir arquivo de entrada
        jal open_file

        # Abrir arquivo de sa�da para a �rea .data
        li $v0, 13      # Syscall para abrir arquivo para escrita
        la $a0, outputDataFileName
        li $a1, 1       # Modo de escrita
        li $a2, 0       # Permiss�es padr�o
        syscall

        # Pular a primeira linha (cabe�alho) do arquivo de sa�da MIF
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

        # Verificar se est� lendo .text
        lw $t0, reading_data
        beq $t0, $zero, end_read_loop  # Se lendo .text, parar de ler

        # Processar a linha (implementa��o requerida)
        # ...

        # Escrever a instru��o em MIF
        # ...

        # Continuar lendo o arquivo
        j read_loop

    end_read_loop:
        # Adicionar finaliza��o do arquivo MIF
        # ...

        # Fechar arquivo de entrada
        li $v0, 16      # Syscall para fechar arquivo
        move $a0, $v0   # $a0 ter� o identificador do arquivo
        syscall

        # Fechar arquivo de sa�da para a �rea .data
        li $v0, 16      # Syscall para fechar arquivo
        move $a0, $v0   # $a0 ter� o identificador do arquivo
        syscall

        # Terminar o programa
        li $v0, 10      # Syscall para terminar o programa
        syscall

    error_open:
        # Mensagem de erro de abertura do arquivo (implementa��o requerida)
        # Pode ser uma simples string indicando o erro.
     
        
           li $v0, 4
           la $a0, error_open_msg
           syscall

    # Sub-rotinas adicionais podem ser implementadas aqui

    # Fun��o para traduzir instru��o da �rea .data para hexadecimal
    # Recebe o endere�o em $a0 e a instru��o em $a1
    # Retorna o c�digo hexadecimal em $v0
    translate_data_instruction:
        lw $v0, 0($a0)   # Carrega a instru��o da mem�ria .data
        jr $ra

    # Fun��o para fechar arquivo com adi��o de nova linha
    close_file_with_newline:
        li $v0, 13      # Syscall para abrir arquivo para escrita
        la $a0, outputDataFileName
        li $a1, 1       # Modo de escrita
        li $a2, 0       # Permiss�es padr�o
        syscall

        # Adiciona um caractere de nova linha no final do arquivo
        li $v0, 4       # Syscall para escrever string
        li $a1, 0       # Modo de escrita
        la $a2, nova_linha    # Nova linha
        syscall

        # Fecha o arquivo
        li $v0, 16      # Syscall para fechar arquivo
        move $a0, $v0   # $a0 ter� o identificador do arquivo
        syscall
        jr $ra
