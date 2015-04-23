#ifndef _HAL_IO_H_
#define _HAL_IO_H_
#include "../common/kdef.h"
#include "../common/type.h"

#define GATE_DPL_0 (0ull << 13)
#define GATE_DPL_1 (1ull << 13)
#define GATE_DPL_2 (2ull << 13)
#define GATE_DPL_3 (3ull << 13)
#define GATE_PRESENT (1ull << 15)
#define GATE_TYPE_CALL (12ull << 8)
#define GATE_TYPE_INTERRUPT (14ull << 8)
#define GATE_TYPE_TRAP (15ull << 8)

extern void NATIVE64 hal_write_port(uint64_t port, int64_t data);
extern int64_t NATIVE64 hal_read_port(uint64_t port);
void NATIVE64 hal_interrupt_handler_dummy();

void NATIVE64 hal_set_interrupt_handler(uint64_t index, void (*handler)());
extern void NATIVE64 hal_enable_interrupt();
extern void NATIVE64 hal_disable_interrupt();
extern void NATIVE64 hal_interrupt_handler_wrapper();

void NATIVE64 hal_write_gate(void *const gate, uint64_t const offset, uint32_t const selector, uint32_t const attr);

extern uint8_t g_idt[];
#endif