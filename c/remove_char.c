#include <stdio.h>
#include <string.h>

int main()
{
    char str[100];
    char ch;
    int i, len, j;
    scanf("%s %c", str, &ch);

    len = strlen(str);

    for (i = 0; i < len; i++)
    {
        printf("i is %d, %c\n", i, str[i]);
        if(str[i] == ch)
        {
            puts("Found match");
            for(j = i; j< len; j++)
            {
                printf("j is %d\n", j);
                str[j] = str[j+1];
            }
            printf("New string after replacing one instance is: %s\n", str);
            len--;
            i--;
        }
    }

    printf("%s\n", str);

    return 0;
}