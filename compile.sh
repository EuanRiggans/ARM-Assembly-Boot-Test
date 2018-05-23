#ARM Assembler Boot Test Compiler
echo "Compiling ARM Assembler Boot Test..."
as -o boot-test.o boot-test.s
gcc -o boot-test boot-test.o
echo "Compile Completed"
