;/***************************************************************************/
; * @file     startup_LPC17xx.s for ARM-KEIL ARM assembler
; * @brief    CMSIS Cortex-M3 Core Device Startup File for LPC17xx
; * @version  CMSIS v4.1
; * @date     07 March 2015
; *
; * @description
; * Created from the CMSIS template for the specified device
; * Quantum Leaps, www.state-machine.com
; *
; * @note
; * The symbols Stack_Size and Heap_Size should be provided on the command-
; * line options to the assembler, for example as:
; *     --pd "Stack_Size SETA 512" --pd "Heap_Size SETA 0"
; *
; * @note
; * The functions assert_failed/Q_onAssert defined at the end of this file
; * determine the error/assertion handling policy for the application and
; * might need to be customized for each project. This function is defined
; * in assembly to avoid accessing the stack, which might be corrupted by
; * the time assert_failed/Q_onAssert are called.
; *
; ***************************************************************************/
;/* Copyright (c) 2012 ARM LIMITED
;
;  All rights reserved.
;  Redistribution and use in source and binary forms, with or without
;  modification, are permitted provided that the following conditions are met:
;  - Redistributions of source code must retain the above copyright
;    notice, this list of conditions and the following disclaimer.
;  - Redistributions in binary form must reproduce the above copyright
;    notice, this list of conditions and the following disclaimer in the
;    documentation and/or other materials provided with the distribution.
;  - Neither the name of ARM nor the names of its contributors may be used
;    to endorse or promote products derived from this software without
;    specific prior written permission.
;
;  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
;  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;  POSSIBILITY OF SUCH DAMAGE.
;---------------------------------------------------------------------------*/

;******************************************************************************
;
; Allocate space for the stack.
;
;******************************************************************************
        AREA    STACK, NOINIT, READWRITE, ALIGN=3
__stack_base
StackMem
        SPACE   Stack_Size    ; provided in command-line option, for example:
                              ; --pd "Stack_Size SETA 512"
__stack_limit
__initial_sp

;******************************************************************************
;
; Allocate space for the heap.
;
;******************************************************************************
        AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
HeapMem
        SPACE   Heap_Size     ; provided in command-line option, for example:
                              ; --pd "Heap_Size SETA 0"
__heap_limit

;******************************************************************************
;
; Indicate that the code in this file preserves 8-byte alignment of the stack.
;
;******************************************************************************
        PRESERVE8

;******************************************************************************
;
; Place code into the reset code section.
;
;******************************************************************************
        AREA   RESET, DATA, READONLY
        EXPORT  __Vectors
        EXPORT  __Vectors_End
        EXPORT  __Vectors_Size

;******************************************************************************
;
; The vector table.
;
;******************************************************************************
__Vectors
        DCD     __initial_sp                ; Top of Stack
        DCD     Reset_Handler               ; Reset Handler
        DCD     NMI_Handler                 ; NMI Handler
        DCD     HardFault_Handler           ; Hard Fault Handler
        DCD     MemManage_Handler           ; The MPU fault handler
        DCD     BusFault_Handler            ; The bus fault handler
        DCD     UsageFault_Handler          ; The usage fault handler
        DCD     0                           ; Reserved
        DCD     0                           ; Reserved
        DCD     0                           ; Reserved
        DCD     0                           ; Reserved
        DCD     SVC_Handler                 ; SVCall handler
        DCD     DebugMon_Handler            ; Debug monitor handler
        DCD     0                           ; Reserved
        DCD     PendSV_Handler              ; The PendSV handler
        DCD     SysTick_Handler             ; The SysTick handler

        ; IRQ handlers...
        DCD     WDT_IRQHandler              ; WDT
        DCD     TIMER0_IRQHandler           ; TIMER0
        DCD     TIMER1_IRQHandler           ; TIMER1
        DCD     TIMER2_IRQHandler           ; TIMER2
        DCD     TIMER3_IRQHandler           ; TIMER3
        DCD     UART0_IRQHandler            ; UART0
        DCD     UART1_IRQHandler            ; UART1
        DCD     UART2_IRQHandler            ; UART2
        DCD     UART3_IRQHandler            ; UART3
        DCD     PWM1_IRQHandler             ; PWM1
        DCD     I2C0_IRQHandler             ; I2C0
        DCD     I2C1_IRQHandler             ; I2C1
        DCD     I2C2_IRQHandler             ; I2C2
        DCD     SPI_IRQHandler              ; SPI
        DCD     SSP0_IRQHandler             ; SSP0
        DCD     SSP1_IRQHandler             ; SSP1
        DCD     PLL0_IRQHandler             ; PLL0 (Main PLL)
        DCD     RTC_IRQHandler              ; RTC
        DCD     EINT0_IRQHandler            ; EINT0
        DCD     EINT1_IRQHandler            ; EINT1
        DCD     EINT2_IRQHandler            ; EINT2
        DCD     EINT3_IRQHandler            ; EINT3
        DCD     ADC_IRQHandler              ; ADC
        DCD     BOD_IRQHandler              ; BOD
        DCD     USB_IRQHandler              ; USB
        DCD     CAN_IRQHandler              ; CAN
        DCD     DMA_IRQHandler              ; GP DMA
        DCD     I2S_IRQHandler              ; I2S
        DCD     ENET_IRQHandler             ; Ethernet
        DCD     RIT_IRQHandler              ; RITINT
        DCD     MCPWM_IRQHandler            ; Motor Control PWM
        DCD     QEI_IRQHandler              ; Quadrature Encoder
        DCD     PLL1_IRQHandler             ; PLL1 (USB PLL)
        DCD     USBActivity_IRQHandler      ; USB Activity interrupt to wakeup
        DCD     CANActivity_IRQHandler      ; CAN Activity interrupt to wakeup
__Vectors_End

__Vectors_Size  EQU     __Vectors_End - __Vectors



;******************************************************************************
;
; This is the code for exception handlers.
;
;******************************************************************************
        AREA    |.text|, CODE, READONLY

;******************************************************************************
;
; This is the code that gets called when the processor first starts execution
; following a reset event.
;
;******************************************************************************
Reset_Handler   PROC
        EXPORT  Reset_Handler  [WEAK]
        IMPORT  SystemInit
        IMPORT  __main

        LDR     r0, =SystemInit ; CMSIS system initialization
        BLX     r0

        ; Call the C library enty point that handles startup. This will copy
        ; the .data section initializers from flash to SRAM and zero fill the
        ; .bss section.
        LDR     r0, =__main
        BX      r0

        ; __main calls the main() function, which should not return,
        ; but just in case jump to assert_failed() if main returns.
        MOVS    r0,#0
        MOVS    r1,#0       ; error number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The NMI handler
;
;******************************************************************************
NMI_Handler     PROC
        EXPORT  NMI_Handler     [WEAK]
        MOVS    r0,#0
        MOVS    r1,#2       ; NMI exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The Hard Fault handler
;
;******************************************************************************
HardFault_Handler PROC
        EXPORT  HardFault_Handler [WEAK]
        MOVS    r0,#0
        MOVS    r1,#3       ; HardFault exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The MPU fault handler
;
;******************************************************************************
MemManage_Handler PROC
        EXPORT  MemManage_Handler     [WEAK]
        MOVS    r0,#0
        MOVS    r1,#4       ; MemManage exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The Bus Fault handler
;
;******************************************************************************
BusFault_Handler PROC
        EXPORT  BusFault_Handler     [WEAK]
        MOVS    r0,#0
        MOVS    r1,#5       ; BusFault exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The Usage Fault handler
;
;******************************************************************************
UsageFault_Handler PROC
        EXPORT  UsageFault_Handler   [WEAK]
        MOVS    r0,#0
        MOVS    r1,#6       ; UsageFault exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The SVC handler
;
;******************************************************************************
SVC_Handler PROC
        EXPORT  SVC_Handler   [WEAK]
        MOVS    r0,#0
        MOVS    r1,#11      ; SVCall exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The Debug Monitor handler
;
;******************************************************************************
DebugMon_Handler PROC
        EXPORT  DebugMon_Handler     [WEAK]
        MOVS    r0,#0
        MOVS    r1,#12      ; DebugMon exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The PendSV handler
;
;******************************************************************************
PendSV_Handler PROC
        EXPORT  PendSV_Handler       [WEAK]
        MOVS    r0,#0
        MOVS    r1,#14      ; PendSV exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; The SysTick handler
;
;******************************************************************************
SysTick_Handler PROC
        EXPORT  SysTick_Handler     [WEAK]
        MOVS    r0,#0
        MOVS    r1,#15      ; SysTick exception number
        B       assert_failed
        ENDP

;******************************************************************************
;
; Define Default_Handledr as dummy for all IRQ handlers
;
;******************************************************************************
Default_Handler PROC
        EXPORT  WDT_IRQHandler          [WEAK]
        EXPORT  TIMER0_IRQHandler       [WEAK]
        EXPORT  TIMER1_IRQHandler       [WEAK]
        EXPORT  TIMER2_IRQHandler       [WEAK]
        EXPORT  TIMER3_IRQHandler       [WEAK]
        EXPORT  UART0_IRQHandler        [WEAK]
        EXPORT  UART1_IRQHandler        [WEAK]
        EXPORT  UART2_IRQHandler        [WEAK]
        EXPORT  UART3_IRQHandler        [WEAK]
        EXPORT  PWM1_IRQHandler         [WEAK]
        EXPORT  I2C0_IRQHandler         [WEAK]
        EXPORT  I2C1_IRQHandler         [WEAK]
        EXPORT  I2C2_IRQHandler         [WEAK]
        EXPORT  SPI_IRQHandler          [WEAK]
        EXPORT  SSP0_IRQHandler         [WEAK]
        EXPORT  SSP1_IRQHandler         [WEAK]
        EXPORT  PLL0_IRQHandler         [WEAK]
        EXPORT  RTC_IRQHandler          [WEAK]
        EXPORT  EINT0_IRQHandler        [WEAK]
        EXPORT  EINT1_IRQHandler        [WEAK]
        EXPORT  EINT2_IRQHandler        [WEAK]
        EXPORT  EINT3_IRQHandler        [WEAK]
        EXPORT  ADC_IRQHandler          [WEAK]
        EXPORT  BOD_IRQHandler          [WEAK]
        EXPORT  USB_IRQHandler          [WEAK]
        EXPORT  CAN_IRQHandler          [WEAK]
        EXPORT  DMA_IRQHandler          [WEAK]
        EXPORT  I2S_IRQHandler          [WEAK]
        EXPORT  ENET_IRQHandler         [WEAK]
        EXPORT  RIT_IRQHandler          [WEAK]
        EXPORT  MCPWM_IRQHandler        [WEAK]
        EXPORT  QEI_IRQHandler          [WEAK]
        EXPORT  PLL1_IRQHandler         [WEAK]
        EXPORT  USBActivity_IRQHandler  [WEAK]
        EXPORT  CANActivity_IRQHandler  [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler
        MOVS    r0,#0
        MOVS    r1,#-1      ; 0xFFFFFFF
        B       assert_failed
        ENDP

        ALIGN               ; make sure the end of this section is aligned


;******************************************************************************
;
; The function expected of the C library startup code for defining the stack
; and heap memory locations.  For the C library version of the startup code,
; provide this function so that the C library initialization code can find out
; the location of the stack and heap.
;
;******************************************************************************
    IF :DEF: __MICROLIB
        EXPORT  __initial_sp
        EXPORT  __stack_limit
        EXPORT  __heap_base
        EXPORT  __heap_limit
    ELSE
        IMPORT  __use_two_region_memory
        EXPORT  __user_initial_stackheap

__user_initial_stackheap PROC
        LDR     R0, =__heap_base
        LDR     R1, =__stack_limit
        LDR     R2, =__heap_limit
        LDR     R3, =__stack_base
        BX      LR
        ENDP
    ENDIF

;******************************************************************************
;
; The functions assert_failed/Q_onAssert define the error/assertion
; handling policy for the application and might need to be customized
; for each project. These functions are defined in assembly to avoid
; accessing the stack, which might be corrupted by the time assert_failed
; is called. For now the function just resets the CPU.
;
; NOTE: the functions assert_failed/Q_onAssert should NOT return.
;
; The C proptotypes of these functions are as follows:
; void assert_failed(char const *file, int line);
; void Q_onAssert   (char const *file, int line);
;******************************************************************************
        EXPORT  assert_failed
        EXPORT  Q_onAssert
assert_failed PROC
Q_onAssert
        ;
        ; NOTE: add here your application-specific error handling
        ;

        ; the following code implements the CMIS function
        ; NVIC_SystemReset() from core_cm4.h
        ; Leave this code if you wish to reset the system after an error.
        DSB                      ; ensure all memory access complete
        LDR    r0,=0x05FA0004    ; (0x5FA << SCB_AIRCR_VECTKEY_Pos)
                                 ; | (SCB->AIRCR & SCB_AIRCR_PRIGROUP_Msk)
                                 ; | SCB_AIRCR_SYSRESETREQ_Msk
        LDR    r1,=0xE000ED0C    ; address of SCB->AIRCR
        STR    r0,[r1]           ; r0 -> SCB->AIRCR
        DSB                      ; ensure all memory access complete
        B      .                 ; wait until reset occurs
        ENDP


        ALIGN               ; make sure the end of this section is aligned

        END                 ; end of module
