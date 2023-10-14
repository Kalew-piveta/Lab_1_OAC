# Trabalho 1 de Organização e Arquitetura de Computadores da UNB


## Definição do Trabalho

Deve ser criado um código com linguagem de programação Assembly MIPS um programa com os seguintes requisitos:
- Leitura de um arquivo de entrada com o código fonte também em Assembly MIPS com extensão `.asm`
- Gerar um código objeto montado em Hexadecimal em arquivo texto ASCII no formato MIF (Memory Inicialization File)
- O código objeto montado deve ser capaz de tratar as instruções pré-definidas
- Deve ser tratados todos os possíveis erros (opcode e instruções inexistentes)
- Deve ser criado dois arquivos de saída `_text.mif` e `_data.mif`  como o nome do arquivo de entrada


### Instruções pré-definidas
``` assembly
  lw $t0, OFFSET($s3)
  add/sub/and/or/nor/xor $t0, $s2, $t0
  sw $t0, OFFSET($s3)
  j LABEL
  jr $t0
  jal LABEL
  beq/bne $t1, $zero, LABEL
  slt $t1, $t2, $t3
  lui $t1, 0xXXXX
  addu/subu $t1, $t2, $t3
  sll/srl $t2, $t3, 10
  addi/andi/ori/xori $t2, $t3, -10
  mult $t1, $t2
  div $t1, $t2
  mfhi/mflo $t1
  bgez $t1, LABEL
  clo $t1, $t2
  srav $t1, $t2, $t3
  sra $t2, $t1, 10
  bgezal $t1, LABEL
  addiu $t1, $t2, $t3
  lb $t1, 100($t2)
  movn $t1, $t2, $t3
  mul $t1, $t2, $t5
  sb $t4, 1000($t2)
  slti/sltu $t1, $t2, -100
```

## Tarefas do Trabalho

[] - Ler um arquivo de entrada text ASCII com instruções 
  [] - Abrir caixa de dialogo
  [] - Pegar o nome do arquivo de entrada
[] - Traduzir as instruções em código objeto montado em Hexadecimal
  [] - Fazer tratamentos de erros
  [] - Tratar representações de todos os registradores
[] - Criar um arquivo com o código objeto montado em Hexadecimal no formado MIF (Memory Inicialization File)
[] - Escrever os arquivos de saída
  [] - [NOME_ARQUIVO_ENTRADA]_data.mif
  [] - [NOME_ARQUIVO_ENTRADA]_text.mif

