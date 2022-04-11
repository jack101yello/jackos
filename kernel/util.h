#ifndef __util_H
#define __util_H

#define low_16(address) (uint16_t)((address) & 0xFFFF)
#define high_16(address) (uint16_t)(((address) >> 16) & 0xFFFF)

void memory_copy(char* source, char* dest, int num_bytes);
void int_to_string(int n, char str[]);
int string_length(char str[]);
void char_to_string(char cha, char str[]);

#endif