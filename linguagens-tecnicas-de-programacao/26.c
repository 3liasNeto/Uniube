#include <stdio.h>

int main() {
    float km;
    printf("Km: ");
    scanf("%f", &km);
    float miles = km * 0.621371;
    printf("Miles: %.2f\n", miles);
    return 0;
}