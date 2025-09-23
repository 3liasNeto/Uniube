#include <stdio.h>

int main() {
    unsigned int productId;
    unsigned long quantity;
    double price;
    float discount = 0;

    printf("Product ID: ");
    scanf("%u", &productId);
    printf("Quantity: ");
    scanf("%lu", &quantity);
    printf("Price: ");
    scanf("%lf", &price);

    if(price <= 0){
        printf("Invalid price!\n");
        return 1;
    }

    if(quantity > 100){
        discount = 0.05;
    } else if (quantity >= 1000){
        discount = 0.12;
    }

    double total = quantity * price * (1 - discount);
    printf("Product ID: %u\n", productId);
    printf("Valor Bruto: R$ %.2lf\n", quantity * price);
    printf("Discount: %.2f%%\n", discount * 100);
    printf("Total: R$ %.2lf\n", total);

    return 0;
}