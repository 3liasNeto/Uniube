#include <stdio.h>

int main() {
    int temperatureC;
    printf("Informe a temperatura em Celsius: ");
    scanf("%d", &temperatureC);
    int temperatureF = (temperatureC * 9 / 5) + 32;
    printf("Temperatura em Fahrenheit: %d\n", temperatureF);
    return 0;
}