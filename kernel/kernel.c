#include "../drivers/screen.h"
#include "../drivers/keyboard.h"
#include "../cpu/idt.h"
#include "../cpu/isr.h"

extern void main() {
    clear_screen();
    print("Booting JackOS...\n");
    isr_install();
    print("Enabling external interrupts.\n");
    asm volatile("sti");

    print("Initializing keyboard (IRQ 1)\n");
    init_keyboard();
}