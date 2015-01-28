global hk_load_gdt
global hk_support_x64
SELECTOR_DATA_0 equ 3*8 + 0
SELECTOR_DATA_3 equ 4*8 + 3
SELECTOR_CODE_0 equ 1*8 + 0
SELECTOR_CODE_3 equ 2*8 + 3
[SECTION .text]
[BITS 32]
;void hk_load_gdt(gdt_ptr* ptr, uint16 SLCT_CODE, uint16 SLCT_DATA)
hk_load_gdt:
push ebp
mov ebp,esp
push eax
mov eax,[ss:ebp+8]
lgdt [eax]
;reload cs
mov eax,[ss:ebp+12]
push eax
push dword .reload
retf
.reload
mov eax,[ss:ebp+16]
mov ss,ax
mov es,ax
mov fs,ax
mov gs,ax
mov ds,ax
pop eax
mov ebp,esp
pop ebp
ret

;int hk_support_x64(void)
hk_support_x64:
push ebp
mov ebp,esp
pushfd
pop eax
mov ecx, eax
xor eax, 1 << 21
push eax
popfd
pushfd
pop eax
push ecx
popfd
xor eax, ecx
jz .not_supported
mov eax, 0x80000000    ; Set the A-register to 0x80000000.
cpuid                  ; CPU identification.
cmp eax, 0x80000001    ; Compare the A-register with 0x80000001.
jb .not_supported      ; It is less, there is no long mode.
mov eax, 0x80000001    ; Set the A-register to 0x80000001.
cpuid                  ; CPU identification.
test edx, 1 << 29      ; Test if the LM-bit, which is bit 29, is set in the D-register.
jz .not_supported      ; They aren't, there is no long mode.
mov eax,1
jmp .end
.not_supported
xor eax,eax
.end
mov esp,ebp
pop ebp
ret