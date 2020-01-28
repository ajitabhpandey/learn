#include <stdio.h>

int check_prime(int num) {
    int flag = 0, i;
    if (num == 2)
        flag = 0;
    else {
        for (i = 2; i<=num/2; i++) {
            printf("i = %d, n=%d\n", i, num);
            if (num % i == 0)
                flag = 1;
        }
    }
    return flag;
}

int main() {
    int num;
    scanf("%d", &num);
    int check = check_prime(num);

    if (check == 0)
        printf("%d is a prime number\n", num);
    else
        printf("%d is not a prime number\n", num);

    return 0;
}