#include <stdio.h>

int main() {
    int kg;
    printf("Kg: ");
    scanf("%d", &kg);
    float lbs = kg * 2.20462;
    printf("Lbs: %.2f\n", lbs);
    return 0;
}