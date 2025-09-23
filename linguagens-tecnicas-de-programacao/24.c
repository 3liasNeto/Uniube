#include <stdio.h>

int main() {
    int min = 60;
    int hour;

    printf("Horas: ");
    scanf("%d", &hour);
    int total = hour * min;
    printf("Minutos: %d\n", total);
    return 0;
}