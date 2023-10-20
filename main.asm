# Organização e arquitetura de computadores
# Alunos:
#      Paulo Henrique Rosa - 170163687
#      Aluno 2 - Matricula
#      Aluno 3 - Matricula


.data
  filenameBuffer: .space 1024
  fileBuffer: .space 1024
  getFilenameMsg: .asciiz "Arquivo de entrada:"
  finishedMsg: .asciiz "Arquivos gerados com sucesso"
  emptyFilename: .asciiz "Nome do arquivo não fornecido. Deseja inserir nome do arquivo? \n"
  fileNotFound: .asciiz "Arquivo não encontrado."

.macro terminate
	li $v0, 10
	syscall
.end_macro

.macro print_src (%str)
  li $v0, 4
  la $a0 %str
  syscall
.end_macro

.text
jal readFilename
print_src(filenameBuffer)
jal openFile
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
