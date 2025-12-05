#include <stdio.h>
#include <stdlib.h>

float sum(float, float);
float multiply(float, float);
float divide(float, float);
float subtract(float, float);

int main()
{
    char input[100];
    float result, a, b;
    char operator;

    printf("==============================\n");
    printf("Simple Calculator in C\n");

    if (!fgets(input, sizeof input, stdin))
    {
        printf("Read error\n");
        return 1;
    }

    int parsed = sscanf(input, "%f %c %f", &a, &operator, &b);
    if (parsed != 3)
    {
        printf("Invalid input format\n");
        return 1;
    }

    switch (operator)
    {
    case '+':
        result = sum(a, b);
        break;
    case '-':
        result = subtract(a, b);
        break;
    case '*':
        result = multiply(a, b);
        break;
    case '/':
        result = divide(a, b);
        break;
    default:
        printf("Operador Invalido! Por favor use +, -, * ou /.\n");
        return 1;
    }

    printf("Resultado\n");
    printf("%.2f %c %.2f = %.2f\n", a, operator, b, result);
    printf("==============================\n");

    return 0;
}

float sum(float a, float b)
{
    return a + b;
}

float multiply(float a, float b)
{
    return a * b;
}

float divide(float a, float b)
{
    if (b == 0)
    {
        printf("Error: Division by zero!\n");
    }
    return a / b;
}

float subtract(float a, float b)
{
    return a - b;
}
