# Organização e arquitetura de computadores
# Alunos:
#      Paulo Henrique Rosa - 170163687
#      Aluno 2 - Matricula
#      Aluno 3 - Matricula


.data
  filenameBuffer: .space 256
  fileBuffer: .space 2048
  getFilenameMsg: .asciiz "Arquivo de entrada:"
  finishedMsg: .asciiz "Arquivos gerados com sucesso"
  emptyFilename: .asciiz "Nome do arquivo não fornecido. Deseja inserir nome do arquivo?"
  fileNotFound: .asciiz "Arquivo não encontrado."

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
jal readFilename
jal openFile
jal readFile
jal processLineData
terminate


readFilename: li $v0, 54
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

openFile: li $v0, 13
  la $a0, filenameBuffer
  li $a1, 0
  syscall

  # Check if the file was opened successfully
  bltz $v0, readFileError

  # Save file descriptor (file ID)
  move $s0, $v0
	
  jr $ra
# end readFile

readFile: li $v0, 14
  la $a0, ($s0)
  la $a1, fileBuffer
  li $a2, 2048

  syscall
  
  jr $ra

processLineData: 
  la $t0, fileBuffer 

  loop: lb $t1, 0($t0)
  bne  $t1, 46 next

  lb $t1, 1($t0)

  # verify if equal "d"
  beq $t1, 100, find_newLine

  next: addi $t0, $t0, 1
  j loop

find_newLine:

  addi $t0, $t0, 1
  lb $t1, 0($t0)
  
  terminate


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
  beqz $a0, readFilename
  terminate
# end readFilenameError

readFileError: li $v0, 55
	la $a0, fileNotFound
	li $a2, 0
	syscall

  # TODO:  Try to read the filename again
  terminate
# end readFileError
