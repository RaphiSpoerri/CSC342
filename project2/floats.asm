


.data
float_anon1: .float 1
float_anon2: .float 2

.text
main:
	lwc1 $f1, float_anon1
	lwc1 $f2, float_anon2
	add.s $f12, $f1, $f2
	
	li $v0, 2 # print float
	syscall
	
	li $v0, 10 # exit
	syscall
