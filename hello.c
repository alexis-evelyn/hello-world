#include <stdio.h>

int main() {
	// Be Wary Of Injection Via printf and User Input
	// See Page At https://www.geeksforgeeks.org/puts-vs-printf-for-printing-a-string/
	puts("Hello World!");

	// Lower Level Version Of puts
	// stdin, stdout, stderr (or 0, 1, 2)
	// message
	// length of message
// 	write(1, "Hello World!", 13);
}
