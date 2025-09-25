#include <stdio.h>

int main() {
    int year = 365;
    int age;
    printf("Idade: ");
    scanf("%d", &age);
    int days = age * year;
    printf("Você já viveu %d dias\n", days);
    return 0;
}