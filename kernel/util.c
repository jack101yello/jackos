#include "util.h"

void memory_copy(char* source, char* dest, int num_bytes) {
    for(int i = 0; i < num_bytes; i++) {
        *(dest + i) = *(source + i);
    }
}

void reverse(char str[]) {
    int c, j;
    for(int i = 0, j = string_length(str)-1; i < j; i++, j--) {
        c = str[i];
        str[i] = str[j];
        str[j] = c;
    }
}

void int_to_string(int n, char str[]) {
    int i, sign;
    if((sign = n) < 0) n = -n;
    i = 0;
    do {
        str[i++] = n % 10 + '0';
    }
    while((n /= 10) > 0);
    if(sign < 0) str[i++] = '-';
    str[i] = '\0';
    reverse(str);
}

int string_length(char str[]) {
    int i = 0;
    while(str[i] != '\0') ++i;
    return i;
}

void char_to_string(char cha, char str[]) {
    str[0] = cha;
    str[1] = '\0';
}