#include <stdio.h>

int main(void) {
	int array[3] = { 1, 2, 3 };

	printf("First method ([ ] notation):\n");
	printf("value using array[0]: %d\n", array[0]);
	printf("address using &array[0]: %p\n", &array[0]);
	printf("Second method using pointers:\n");
	printf("value using *array: %d\n", *array);
	printf("address using &array: %p\n", &array);

	return 0;
}
