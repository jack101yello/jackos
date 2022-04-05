#ifndef __screen_H
#define __screen_H

#include "../kernel/low_level.h"
#include "../kernel/util.h"

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80
#define WHITE_ON_BLACK 0x0f

#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

void print_at(char* message, int col, int row);
void print(char* message);
void clear_screen();

#endif