nasm -f elf64 main.asm -l main.lst
ld -o main main.o
./main
rm main.o main.lst
