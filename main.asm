# Organização e arquitetura de computadores
# Alunos:
#      Paulo Henrique Rosa - 170163687
#      Aluno 2 - Matricula
#      Aluno 3 - Matricula


.data
  filenameBuffer: .space 100
  getFilenameMessage: .asciiz "Arquivo de entrada: \n"
  finishedMessage: .asciiz "Arquivos gerados com sucesso \n"
  emptyFilename: .asciiz "Nome do arquivo não fornecido. Deseja inserir nome do arquivo? \n"

.text
jal readFilename
jal createFile

.macro exit
	li $v0, 10
	syscall
.end_macro

# Open File (for reading)
readFilename: la $a0, getFilenameMessage
	la $a1, filenameBuffer
	li $a2, 100
	li $v0, 54
	syscall

	bnez $a1, infoError
	
	la $s0, filenameBuffer
	
	la $a0, ($s0)
	li $v0, 4
	syscall
	
	# TODO: Call the next step flow
	jal createFile
# end readFilename

# Crate output files (WIP)
createFile: la $a0, finishedMessage
	li $a1, 1
	li $v0, 55
	syscall
	exit
# end createFile

# Error message Dialog
infoError: la $a0, emptyFilename
	li $v0, 50
	syscall
	
	beqz $a0, readFilename
	exit
# end infoError
