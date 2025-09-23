#include <stdio.h>

int main() {
    int array[3];
    for(int i = 1; i <= 3; i++) {
        scanf("%d", &array[i-1]);
        
    }
    printf("%d\n", array[1] * array[2] * array[0]);
}