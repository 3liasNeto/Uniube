#include <stdio.h>
#include <math.h>

int main() {
    int raio;
    scanf("Raio: %d", &raio);
    float area = 2 * M_PI * raio;
    printf("Área: %.2f\n", area);

    return 0;
}