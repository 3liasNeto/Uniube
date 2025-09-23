#include <stdio.h>

int main() {
    int temperatureC;
    scanf("%d", &temperatureC);
    int temperatureF = (temperatureC * 9 / 5) + 32;
    printf("Temperatura em Fahrenheit: %d\n", temperatureF);
    return 0;
}