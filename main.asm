# Organização e arquitetura de computadores
# Alunos:
#      Paulo Henrique Rosa - 170163687
#      Aluno 2 - Matricula
#      Aluno 3 - Matricula


.data
  filenameBuffer: .asciiz "/Users/paulohenrique/Desktop/college/OAC/lab1/example_saida.asm"  #.space 256
  fileBuffer: .space 2048
  getFilenameMsg: .asciiz "Arquivo de entrada:"
  finishedMsg: .asciiz "Arquivos gerados com sucesso"
  emptyFilename: .asciiz "Nome do arquivo não fornecido. Deseja inserir nome do arquivo?"
  fileNotFound: .asciiz "Arquivo não encontrado."

  # Labels space
  labels: .space 1024

.macro terminate
	li $v0, 10
	syscall
.end_macro

.macro print_string (%str)
  li $v0, 4
  la $a0 %str
  syscall
.end_macro

.text
#jal read_filename
jal open_file
jal load_file
jal process_text_segment
terminate


read_filename: li $v0, 54
  la $a0, getFilenameMsg
  la $a1, filenameBuffer
  li $a2, 256
  syscall

  bltz $a1, readFilenameError

  la $t0, filenameBuffer

  remove_newLine: lb $t1, 0($t0)
    beq $t1, 10, found_newLine
    beq $t1, 0, found_null
    addi $t0, $t0, 1
    j remove_newLine

  found_newLine:
    sb $zero, 0($t0)
    j end_remove_newLine

  found_null:
  end_remove_newLine:

  jr $ra
# end readFilename

open_file: li $v0, 13
  la $a0, filenameBuffer
  li $a1, 0
  syscall

  # Check if the file was opened successfully
  bltz $v0, readFileError

  # Save file descriptor (file ID)
  move $s0, $v0
	
  jr $ra
# end readFile

load_file: li $v0, 14
  la $a0, ($s0)
  la $a1, fileBuffer
  li $a2, 2048
  syscall
  jr $ra

process_text_segment: 
  la $t0, fileBuffer

  find_text_segment: lb $t1, 0($t0)

    # verify if the current charactere is equal "."
    bne  $t1, 0x0000002E, next_char

    # verify if the next charactere is equal "t"
    lb $t1, 1($t0)
    beq $t1, 0x00000074, found_text_segment

    next_char: addi $t0, $t0, 0x00000002

    j find_text_segment

  # Found text segment, jump to next instruction in next line
  found_text_segment: addi $t0, $t0, 0x00000006
  

# (WIP)
createFile: li $v0, 55
  la $a0, finishedMsg
  li $a1, 1

  syscall
  terminate
# end createFile

readFilenameError: li $v0, 50
  la $a0, emptyFilename
  syscall
  beqz $a0, read_filename
  terminate
# end readFilenameError

readFileError: li $v0, 55
	la $a0, fileNotFound
	li $a2, 0
	syscall

  # TODO:  Try to read the filename again
  terminate
# end readFileError
