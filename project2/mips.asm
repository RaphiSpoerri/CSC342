


main:
	lwc1 $f1, f32.anon1
	lwc1 $f2, f32.anon2
	add.s $f12, $f1, $f2
	
	li $v0, 2 # print float
	syscall
	
	li $v0, 10 # exit
	syscall

.data
f32.anon1: .float 1.1
f32.anon2: .float 2.2
