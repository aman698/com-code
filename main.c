// input trigger
#include "stm8s_conf.h"

uint8_t rx_buf[16];
uint8_t index = 0;
char input_str[7];
char prev_input_str[7] = {'X','X','X','X','\r','\n','\0'};

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
void Relay_Control(uint8_t relay, uint8_t state)
{
    switch(relay)
    {
        case 1:
            if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_3);
            else      GPIO_WriteLow(GPIOB, GPIO_PIN_3);
            break;

        case 2:
            if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_2);
            else      GPIO_WriteLow(GPIOB, GPIO_PIN_2);
            break;

        case 3:
            if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_1);
            else      GPIO_WriteLow(GPIOB, GPIO_PIN_1);
            break;

        case 4:
            if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
            else      GPIO_WriteLow(GPIOB, GPIO_PIN_0);
            break;

        case 5:
            if(state) GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
            else      GPIO_WriteLow(GPIOC, GPIO_PIN_3);
            break;

        case 6:
            if(state) GPIO_WriteHigh(GPIOC, GPIO_PIN_4);
            else      GPIO_WriteLow(GPIOC, GPIO_PIN_4);
            break;
    }
}
void Input_Status_Send(void)
{
    input_str[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2) == RESET) ? '1' : '0';
    input_str[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3) == RESET) ? '1' : '0';
    input_str[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4) == RESET) ? '1' : '0';
    input_str[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7) == RESET) ? '1' : '0';

    input_str[4] = '\r';
    input_str[5] = '\n';
    input_str[6] = '\0';

    if((input_str[0] != prev_input_str[0]) ||
       (input_str[1] != prev_input_str[1]) ||
       (input_str[2] != prev_input_str[2]) ||
       (input_str[3] != prev_input_str[3]))
    {
        UART_SendString(input_str);

        prev_input_str[0] = input_str[0];
        prev_input_str[1] = input_str[1];
        prev_input_str[2] = input_str[2];
        prev_input_str[3] = input_str[3];
    }
}
void GPIO_Config(void)
{
    /* COM selector LOW = RS232 */
    GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
    GPIO_WriteLow(GPIOC, GPIO_PIN_1);

    /* Relay Outputs */
    GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // R1
    GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // R2
    GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST); // R3
    GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // R4
    GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // R5
    GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // R6

    /* All relays OFF */
    GPIO_WriteLow(GPIOB, GPIO_PIN_3);
    GPIO_WriteLow(GPIOB, GPIO_PIN_2);
    GPIO_WriteLow(GPIOB, GPIO_PIN_1);
    GPIO_WriteLow(GPIOB, GPIO_PIN_0);
    GPIO_WriteLow(GPIOC, GPIO_PIN_3);
    GPIO_WriteLow(GPIOC, GPIO_PIN_4);

    /* Inputs with pullups */
    GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT); // DI1
    GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // DI2
    GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT); // DI3
    GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT); // DI4
}
void main(void)
{
    uint8_t ch;
    uint8_t i;

    UART_Config();
    GPIO_Config();

    UART_SendString("SYSTEM START\r\n");

    while(1)
    {
        /* Receive UART command */
        if(UART1_GetFlagStatus(UART1_FLAG_RXNE) != RESET)
        {
            ch = UART1_ReceiveData8();

            if((ch == '\r') || (ch == '\n'))
            {
                rx_buf[index] = '\0';

                /* STR command : stream inputs for 3 sec */
                if((rx_buf[0]=='S') &&
                   (rx_buf[1]=='T') &&
                   (rx_buf[2]=='R') &&
                   (rx_buf[3]=='\0'))
                {
                    UART_SendString("STREAM START\r\n");

                    for(i=0;i<60;i++)      /* 60 x 50 ms = 3 sec */
                    {
                        input_str[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2)==RESET) ? '1' : '0';
                        input_str[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3)==RESET) ? '1' : '0';
                        input_str[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4)==RESET) ? '1' : '0';
                        input_str[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7)==RESET) ? '1' : '0';
                        input_str[4] = '\r';
                        input_str[5] = '\n';
                        input_str[6] = '\0';

                        UART_SendString(input_str);

                        delay_ms(50);
                    }

                    UART_SendString("STREAM STOP\r\n");
                }

                /* Relay commands R1,1 ... R6,0 */
                else if((rx_buf[0] == 'R') &&
                        (rx_buf[1] >= '1') &&
                        (rx_buf[1] <= '6') &&
                        (rx_buf[2] == ',') &&
                        ((rx_buf[3] == '0') || (rx_buf[3] == '1')))
                {
                    Relay_Control(rx_buf[1]-'0',
                                  rx_buf[3]-'0');

                    UART_SendString("R");
                    UART_SendChar(rx_buf[1]);
                    UART_SendString(",");
                    UART_SendChar(rx_buf[3]);
                    UART_SendString(" OK\r\n");
                }

                index = 0;
            }
            else
            {
                if(index < sizeof(rx_buf)-1)
                {
                    rx_buf[index++] = ch;
                }
                else
                {
                    index = 0;
                }
            }
        }

        /* Send input state automatically when changed */
        Input_Status_Send();
    }
}