#include <iostream>
#include <string.h>
#include <locale.h>
#include <stdlib.h>
using namespace std;

extern "C" void EXPAND_LINE(char *line, int size, int max, char *new_str);
extern "C" void MAX_SIZE(int *sizes,int n, int *max);


int main()
{
    char *buf, string[255], str_sizes[255], buffer[255], line[255];
    int sizes[20], max_size = 0;

    scanf("%[^\n]s", string);
//    strcpy(string, "wertf rtyd ss r y ui efg hik er yd rty t k t ertdft yuerree e rt yu w w w w r");
    printf("%s\n", string);
    cin.ignore();
    scanf("%[^\n]s", str_sizes);
    printf("%s\n", str_sizes);
//    strcpy(str_sizes, "13 6 7 9 5 14 17");
    int i = 0;
    buf = strtok(str_sizes, " ");
    while (buf != NULL)
    {
        sizes[i] = atoi(buf);
        i++;
        buf = strtok(NULL, " \0");
    }
    MAX_SIZE(sizes, i, &max_size);
    int j = 0;
    int cur = 0;
    while (j < i)
    {
        strncpy(buffer, &string[cur], sizes[j]);
        buffer[sizes[j]] = '\0';
        strcpy(line, buffer);
        EXPAND_LINE(buffer, sizes[j], max_size, line);
        printf("%s\n", line);
        cur += sizes[j] + 1;
        j++;
    }
    return 0;
}

