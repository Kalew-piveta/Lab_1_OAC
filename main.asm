# Organização e arquitetura de computadores
# Alunos:
#      Paulo Henrique Rosa - 170163687
#      Aluno 2 - Matricula
#      Aluno 3 - Matricula


.data
  filenameBuffer: .space 256
  fileBuffer: .space 1024
  getFilenameMessage: .asciiz "Arquivo de entrada:"
  finishedMessage: .asciiz "Arquivos gerados com sucesso"
  emptyFilename: .asciiz "Nome do arquivo não fornecido. Deseja inserir nome do arquivo? \n"
  fileNotFound: .asciiz "Arquivo não encontrado."

.text
.macro terminate
	li $v0, 10
	syscall
.end_macro

jal readFilename
jal readFile
terminate


# Open File (for reading)
readFilename: li $v0, 54
  	la $a0, getFilenameMessage
	la $a1, filenameBuffer
	li $a2, 256
	syscall

  # Check if the first caractere is zero (empty input)
	bnez $a1, readFilenameError

	jr $ra
# end readFilename

readFile: li $v0, 13
	la $a0, filenameBuffer
	li $a1, 0
	li $a2, 1
	syscall

  # Check if the file was opened successfully
	bnez $v0, readFileError

  # Save file descriptor (file ID)
	move $s0, $v0
	
	jr $ra

# Crate output files (WIP)
createFile: li $v0, 55
  	la $a0, finishedMessage
	li $a1, 1
	syscall

	terminate
# end createFile

# Error message Dialog
readFilenameError: li $v0, 50
  	la $a0, emptyFilename
	syscall
	
	beqz $a0, readFilename
	terminate
# end readFilenameError

# Error message Dialog
readFileError: li $v0, 55
  	la $a0, fileNotFound
	li $a2, 0
	syscall

	# TODO:  Try to read the filename again
	terminate
# end readFileError
