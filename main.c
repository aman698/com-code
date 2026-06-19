// input trigger

#include "stm8s.h"

void delay_ms(uint16_t ms)
{
    uint16_t i, j;

    for(i = 0; i < ms; i++)
    {
        for(j = 0; j < 4000; j++)
        {
            nop();
        }
    }
}

void UART_Config(void)
{
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);

    UART1_DeInit();

    UART1_Init(
        9600,
        UART1_WORDLENGTH_8D,
        UART1_STOPBITS_1,
        UART1_PARITY_NO,
        UART1_SYNCMODE_CLOCK_DISABLE,
        UART1_MODE_TXRX_ENABLE);

    UART1_Cmd(ENABLE);
}

void UART_SendChar(uint8_t ch)
{
    UART1_SendData8(ch);
    while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
}

void UART_SendString(char *str)
{
    while(*str)
    {
        UART_SendChar(*str++);
    }
}

void GPIO_Config(void)
{
    /* Inputs with pullups */
    GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);   // DI1
    GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);   // DI2
    GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);   // DI3
    GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT);   // DI4
}

void main(void)
{
    char msg[7];

    UART_Config();
    GPIO_Config();

    while(1)
    {
        /* Active low inputs */
        msg[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2)==RESET) ? '1' : '0';
        msg[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3)==RESET) ? '1' : '0';
        msg[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4)==RESET) ? '1' : '0';
        msg[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7)==RESET) ? '1' : '0';

        msg[4] = '\r';
        msg[5] = '\n';
        msg[6] = '\0';

        UART_SendString(msg);

        delay_ms(50);
    }
}