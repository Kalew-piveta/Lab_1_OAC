


.data
  localArquivo: .asciiz "/Users/paulohenrique/Desktop/college/OAC/lab1/in1.txt"
  conteudo: .space 1024

.text
li $v0, 13
la $a0, localArquivo
li $a1, 0
syscall

move $s0, $v0
move $a0, $s0

li $v0, 14 
la $a1, conteudo
li $a2, 1024
syscall

li $v0, 4
move $a0, $a1
syscall

li $v0, 16
move $a0, $s0

syscall
