#include <iostream>
#include <string.h>
#include <locale.h>
#include <stdlib.h>
using namespace std;

//abcdty
//babcd

extern "C" void FIND_SUBSTRINGS(char *str1, char *str2, char *substr, int *n, int i);
int main()
{
    char str1[255] = "", str2[255] = "", buffer[255] ="";
    scanf("%[^\n]s", str1);
    printf("str1: %s\n", str1);
    cin.ignore();
    scanf("%[^\n]s", str2);
    printf("str2: %s\n", str2);
    int i = 0;
    printf("SUBSTRINGS: \n");
    while (str1[i])
    {
        int n = 0;
        FIND_SUBSTRINGS(str1, str2, buffer, &n, i);
        strcpy(buffer, "");
        strncpy(buffer, str1 + i, n);
        i += n;
        if (n == 0) {i += 1;}
        if (n > 1)
            printf("%s\n", buffer);
    }
    return 0;
}
