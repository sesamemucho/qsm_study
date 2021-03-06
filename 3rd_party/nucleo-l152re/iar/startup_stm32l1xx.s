;/***************************************************************************/
; * @file     startup_stm32l1xx for IAR ARM assembler
; * @brief    CMSIS Cortex-M3 Core Device Startup File for STM32L1xx.s
; * @version  CMSIS v4.1
; * @date     27 March 2015
; *
; * @description
; * Created from the CMSIS template for the specified device
; * Quantum Leaps, www.state-machine.com
; *
; * @note
; * The function assert_failed defined at the end of this file defines
; * the error/assertion handling policy for the application and might
; * need to be customized for each project. This function is defined in
; * assembly to avoid accessing the stack, which might be corrupted by
; * the time assert_failed is called.
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

        MODULE  ?cstartup

        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)

        SECTION .intvec:CODE:NOROOT(2)

        PUBLIC  __vector_table
        PUBLIC  __Vectors
        PUBLIC  __Vectors_End
        PUBLIC  __Vectors_Size

;******************************************************************************
; The vector table
;
        DATA
__vector_table
        DCD     sfe(CSTACK)
        DCD     Reset_Handler             ; Reset Handler
        DCD     NMI_Handler               ; NMI Handler
        DCD     HardFault_Handler         ; Hard Fault Handler
        DCD     MemManage_Handler         ; The MPU fault handler
        DCD     BusFault_Handler          ; The bus fault handler
        DCD     UsageFault_Handler        ; The usage fault handler
        DCD     0                         ; Reserved
        DCD     0                         ; Reserved
        DCD     0                         ; Reserved
        DCD     0                         ; Reserved
        DCD     SVC_Handler               ; SVCall handler
        DCD     DebugMon_Handler          ; Debug monitor handler
        DCD     0                         ; Reserved
        DCD     PendSV_Handler            ; The PendSV handler
        DCD     SysTick_Handler           ; The SysTick handler

        ; IRQ handlers...
        DCD     WWDG_IRQHandler           ; Window Watchdog
        DCD     PVD_IRQHandler            ; PVD through EXTI Line detect
        DCD     TAMPER_STAMP_IRQHandler   ; Tamper and Time Stamp
        DCD     RTC_WKUP_IRQHandler       ; RTC Wakeup
        DCD     FLASH_IRQHandler          ; FLASH
        DCD     RCC_IRQHandler            ; RCC
        DCD     EXTI0_IRQHandler          ; EXTI Line 0
        DCD     EXTI1_IRQHandler          ; EXTI Line 1
        DCD     EXTI2_IRQHandler          ; EXTI Line 2
        DCD     EXTI3_IRQHandler          ; EXTI Line 3
        DCD     EXTI4_IRQHandler          ; EXTI Line 4
        DCD     DMA1_Channel1_IRQHandler  ; DMA1 Channel 1
        DCD     DMA1_Channel2_IRQHandler  ; DMA1 Channel 2
        DCD     DMA1_Channel3_IRQHandler  ; DMA1 Channel 3
        DCD     DMA1_Channel4_IRQHandler  ; DMA1 Channel 4
        DCD     DMA1_Channel5_IRQHandler  ; DMA1 Channel 5
        DCD     DMA1_Channel6_IRQHandler  ; DMA1 Channel 6
        DCD     DMA1_Channel7_IRQHandler  ; DMA1 Channel 7
        DCD     ADC1_IRQHandler           ; ADC1
        DCD     USB_HP_IRQHandler         ; USB High Priority
        DCD     USB_LP_IRQHandler         ; USB Low  Priority
        DCD     DAC_IRQHandler            ; DAC
        DCD     COMP_IRQHandler           ; COMP through EXTI Line
        DCD     EXTI9_5_IRQHandler        ; EXTI Line 9..5
        DCD     LCD_IRQHandler            ; LCD
        DCD     TIM9_IRQHandler           ; TIM9
        DCD     TIM10_IRQHandler          ; TIM10
        DCD     TIM11_IRQHandler          ; TIM11
        DCD     TIM2_IRQHandler           ; TIM2
        DCD     TIM3_IRQHandler           ; TIM3
        DCD     TIM4_IRQHandler           ; TIM4
        DCD     I2C1_EV_IRQHandler        ; I2C1 Event
        DCD     I2C1_ER_IRQHandler        ; I2C1 Error
        DCD     I2C2_EV_IRQHandler        ; I2C2 Event
        DCD     I2C2_ER_IRQHandler        ; I2C2 Error
        DCD     SPI1_IRQHandler           ; SPI1
        DCD     SPI2_IRQHandler           ; SPI2
        DCD     USART1_IRQHandler         ; USART1
        DCD     USART2_IRQHandler         ; USART2
        DCD     USART3_IRQHandler         ; USART3
        DCD     EXTI15_10_IRQHandler      ; EXTI Line 15..10
        DCD     RTC_Alarm_IRQHandler      ; RTC Alarm through EXTI Line
        DCD     USB_FS_WKUP_IRQHandler    ; USB FS Wakeup from suspend
        DCD     TIM6_IRQHandler           ; TIM6
        DCD     TIM7_IRQHandler           ; TIM7
        DCD     SDIO_IRQHandler           ; SDIO
        DCD     TIM5_IRQHandler           ; TIM5
        DCD     SPI3_IRQHandler           ; SPI3
        DCD     UART4_IRQHandler          ; UART4
        DCD     UART5_IRQHandler          ; UART5
        DCD     DMA2_Channel1_IRQHandler  ; DMA2 Channel 1
        DCD     DMA2_Channel2_IRQHandler  ; DMA2 Channel 2
        DCD     DMA2_Channel3_IRQHandler  ; DMA2 Channel 3
        DCD     DMA2_Channel4_IRQHandler  ; DMA2 Channel 4
        DCD     DMA2_Channel5_IRQHandler  ; DMA2 Channel 5
        DCD     AES_IRQHandler            ; AES
        DCD     COMP_ACQ_IRQHandler       ; Comparator Channel Acquisition

__Vectors_End

__Vectors       EQU   __vector_table
__Vectors_Size  EQU   __Vectors_End - __Vectors

;******************************************************************************
;
; Weak fault handlers...
;
        SECTION .text:CODE:REORDER:NOROOT(2)

;.............................................................................
        PUBWEAK Reset_Handler
        EXTERN  SystemInit
        EXTERN  __iar_program_start
Reset_Handler
        BL      SystemInit  ; CMSIS system initialization
        BL      __iar_program_start ; IAR startup code
;.............................................................................
        PUBWEAK NMI_Handler
NMI_Handler
        MOVS    r0,#0
        MOVS    r1,#2       ; NMI exception number
        B       assert_failed
;.............................................................................
        PUBWEAK HardFault_Handler
HardFault_Handler
        MOVS    r0,#0
        MOVS    r1,#3       ; HardFault exception number
        B       assert_failed
;.............................................................................
        PUBWEAK MemManage_Handler
MemManage_Handler
        MOVS    r0,#0
        MOVS    r1,#4       ; MemManage exception number
        B       assert_failed
;.............................................................................
        PUBWEAK BusFault_Handler
BusFault_Handler
        MOVS    r0,#0
        MOVS    r1,#5       ; BusFault exception number
        B       assert_failed
;.............................................................................
        PUBWEAK UsageFault_Handler
UsageFault_Handler
        MOVS    r0,#0
        MOVS    r1,#6       ; UsageFault exception number
        B       assert_failed


;******************************************************************************
;
; Weak non-fault handlers...
;

        PUBWEAK SVC_Handler
SVC_Handler
        MOVS    r0,#0
        MOVS    r1,#11      ; SVCall exception number
        B       assert_failed
;.............................................................................
        PUBWEAK DebugMon_Handler
DebugMon_Handler
        MOVS    r0,#0
        MOVS    r1,#12      ; DebugMon exception number
        B       assert_failed
;.............................................................................
        PUBWEAK PendSV_Handler
PendSV_Handler
        MOVS    r0,#0
        MOVS    r1,#14      ; PendSV exception number
        B       assert_failed
;.............................................................................
        PUBWEAK SysTick_Handler
SysTick_Handler
        MOVS    r0,#0
        MOVS    r1,#15      ; SysTick exception number
        B       assert_failed


;******************************************************************************
;
; Weak IRQ handlers...
;
;.............................................................................
        PUBWEAK  WWDG_IRQHandler
        PUBWEAK  PVD_IRQHandler
        PUBWEAK  TAMPER_STAMP_IRQHandler
        PUBWEAK  RTC_WKUP_IRQHandler
        PUBWEAK  FLASH_IRQHandler
        PUBWEAK  RCC_IRQHandler
        PUBWEAK  EXTI0_IRQHandler
        PUBWEAK  EXTI1_IRQHandler
        PUBWEAK  EXTI2_IRQHandler
        PUBWEAK  EXTI3_IRQHandler
        PUBWEAK  EXTI4_IRQHandler
        PUBWEAK  DMA1_Channel1_IRQHandler
        PUBWEAK  DMA1_Channel2_IRQHandler
        PUBWEAK  DMA1_Channel3_IRQHandler
        PUBWEAK  DMA1_Channel4_IRQHandler
        PUBWEAK  DMA1_Channel5_IRQHandler
        PUBWEAK  DMA1_Channel6_IRQHandler
        PUBWEAK  DMA1_Channel7_IRQHandler
        PUBWEAK  ADC1_IRQHandler
        PUBWEAK  USB_HP_IRQHandler
        PUBWEAK  USB_LP_IRQHandler
        PUBWEAK  DAC_IRQHandler
        PUBWEAK  COMP_IRQHandler
        PUBWEAK  EXTI9_5_IRQHandler
        PUBWEAK  LCD_IRQHandler
        PUBWEAK  TIM9_IRQHandler
        PUBWEAK  TIM10_IRQHandler
        PUBWEAK  TIM11_IRQHandler
        PUBWEAK  TIM2_IRQHandler
        PUBWEAK  TIM3_IRQHandler
        PUBWEAK  TIM4_IRQHandler
        PUBWEAK  I2C1_EV_IRQHandler
        PUBWEAK  I2C1_ER_IRQHandler
        PUBWEAK  I2C2_EV_IRQHandler
        PUBWEAK  I2C2_ER_IRQHandler
        PUBWEAK  SPI1_IRQHandler
        PUBWEAK  SPI2_IRQHandler
        PUBWEAK  USART1_IRQHandler
        PUBWEAK  USART2_IRQHandler
        PUBWEAK  USART3_IRQHandler
        PUBWEAK  EXTI15_10_IRQHandler
        PUBWEAK  RTC_Alarm_IRQHandler
        PUBWEAK  USB_FS_WKUP_IRQHandler
        PUBWEAK  TIM6_IRQHandler
        PUBWEAK  TIM7_IRQHandler
        PUBWEAK  SDIO_IRQHandler
        PUBWEAK  TIM5_IRQHandler
        PUBWEAK  SPI3_IRQHandler
        PUBWEAK  UART4_IRQHandler
        PUBWEAK  UART5_IRQHandler
        PUBWEAK  DMA2_Channel1_IRQHandler
        PUBWEAK  DMA2_Channel2_IRQHandler
        PUBWEAK  DMA2_Channel3_IRQHandler
        PUBWEAK  DMA2_Channel4_IRQHandler
        PUBWEAK  DMA2_Channel5_IRQHandler
        PUBWEAK  AES_IRQHandler
        PUBWEAK  COMP_ACQ_IRQHandler

WWDG_IRQHandler
PVD_IRQHandler
TAMPER_STAMP_IRQHandler
RTC_WKUP_IRQHandler
FLASH_IRQHandler
RCC_IRQHandler
EXTI0_IRQHandler
EXTI1_IRQHandler
EXTI2_IRQHandler
EXTI3_IRQHandler
EXTI4_IRQHandler
DMA1_Channel1_IRQHandler
DMA1_Channel2_IRQHandler
DMA1_Channel3_IRQHandler
DMA1_Channel4_IRQHandler
DMA1_Channel5_IRQHandler
DMA1_Channel6_IRQHandler
DMA1_Channel7_IRQHandler
ADC1_IRQHandler
USB_HP_IRQHandler
USB_LP_IRQHandler
DAC_IRQHandler
COMP_IRQHandler
EXTI9_5_IRQHandler
LCD_IRQHandler
TIM9_IRQHandler
TIM10_IRQHandler
TIM11_IRQHandler
TIM2_IRQHandler
TIM3_IRQHandler
TIM4_IRQHandler
I2C1_EV_IRQHandler
I2C1_ER_IRQHandler
I2C2_EV_IRQHandler
I2C2_ER_IRQHandler
SPI1_IRQHandler
SPI2_IRQHandler
USART1_IRQHandler
USART2_IRQHandler
USART3_IRQHandler
EXTI15_10_IRQHandler
RTC_Alarm_IRQHandler
USB_FS_WKUP_IRQHandler
TIM6_IRQHandler
TIM7_IRQHandler
SDIO_IRQHandler
TIM5_IRQHandler
SPI3_IRQHandler
UART4_IRQHandler
UART5_IRQHandler
DMA2_Channel1_IRQHandler
DMA2_Channel2_IRQHandler
DMA2_Channel3_IRQHandler
DMA2_Channel4_IRQHandler
DMA2_Channel5_IRQHandler
AES_IRQHandler
COMP_ACQ_IRQHandler

        MOV     r0,#0
        MOV     r1,#-1      ; 0xFFFFFFF
        B       assert_failed

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
        PUBLIC  assert_failed
        PUBLIC  Q_onAssert
Q_onAssert
assert_failed
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


        END
