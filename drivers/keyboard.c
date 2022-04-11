#include <stdint.h>
#include <stdbool.h>
#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "screen.h"
#include "keyboard.h"

/*
Things to implement:
- Cases (shift) -- Do this with a second char array that it to be refereced if shift flag
- Backspace -- Do this by moving the cursor back one and setting to black
*/

void print_letter(uint8_t scancode) {
    char keyMapping[] = { // All of the ` should throw errors
        '`' /*ERROR*/, '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=', '`'/*BKSPCE*/,
        '\t', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', '\n',
        '`' /*LCTRL*/, 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', '\'', '`', '`' /*LSHIFT*/,
        '`', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '/', '`' /*RSHIFT*/,
        '`', '`' /*ALT*/, ' '
    };
    switch(scancode) {
        case 0x0:
            print("Error");
            break;
        case 0x1:
            print("ESC");
            break;
        case 0x2 ... 0x39:
            if(keyMapping[scancode] != '`') { // The ` are for unimplemented keys
                char str[2];
                str[0] = keyMapping[scancode];
                str[1] = '\0';
                print(str);
            }
            break;
        default:
            break;
    }
}

static void keyboard_callback(registers_t *regs) {
    uint8_t scancode = port_byte_in(0x60);
    print_letter(scancode);
}

void init_keyboard() {
    register_interrupt_handler(IRQ1, keyboard_callback);
}