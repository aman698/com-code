#include "stm8s_conf.h"

typedef struct 
{
    uint8_t di1;
    uint8_t di2;
    uint8_t di3;
    uint8_t di4;
} sensor_state_t;

static sensor_state_t current_state = {0, 0, 0, 0};

void delay_ms(uint16_t ms)
{
    uint16_t i,j;

    for(i=0;i<ms;i++)
    {
        for(j=0;j<1600;j++)
        {
            nop();
        }
    }
}

uint8_t hal_di_read(uint8_t di_num)
{
    GPIO_TypeDef *port;
    GPIO_Pin_TypeDef pin;
    
    switch (di_num) {
        case 1: port = DI1_PORT; pin = DI1_PIN; break;
        case 2: port = DI2_PORT; pin = DI2_PIN; break;
        case 3: port = DI3_PORT; pin = DI3_PIN; break;
        case 4: port = DI4_PORT; pin = DI4_PIN; break;
        default: return 0;
    }
    return (GPIO_ReadInputPin(port, pin) == SET) ? 0 : 1;
}
void hal_relay_set(uint8_t relay_num, uint8_t state)
{
    GPIO_TypeDef *port;
    GPIO_Pin_TypeDef pin;

    switch(relay_num)
    {
        case 1: port = RELAY1_PORT; pin = RELAY1_PIN; break;
        case 2: port = RELAY2_PORT; pin = RELAY2_PIN; break;
        case 3: port = RELAY3_PORT; pin = RELAY3_PIN; break;
        case 4: port = RELAY4_PORT; pin = RELAY4_PIN; break;
        case 5: port = RELAY5_PORT; pin = RELAY5_PIN; break;
        case 6: port = RELAY6_PORT; pin = RELAY6_PIN; break;
        default: return;
    }

    if(state)          // 1 = ON
        GPIO_WriteLow(port, pin);
    else               // 0 = OFF
        GPIO_WriteHigh(port, pin);
}
void sensor_reader_update(void){
    current_state.di1 = hal_di_read(1);
    current_state.di2 = hal_di_read(2);
    current_state.di3 = hal_di_read(3);
    current_state.di4 = hal_di_read(4);
}
void relay_off(void){
    hal_relay_set(1,1);
    hal_relay_set(2,1);
    hal_relay_set(3,1);
    hal_relay_set(4,1);
    hal_relay_set(5,1);
    hal_relay_set(6,1);
}
void sensor_reader_init(void)
{
    /* GPIO is already initialized by hal_gpio_init() */
    sensor_reader_update();
}

void UART_Config(void)
{
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);

    UART1_DeInit();

    UART1_Init(9600,
               UART1_WORDLENGTH_8D,
               UART1_STOPBITS_1,
               UART1_PARITY_NO,
               UART1_SYNCMODE_CLOCK_DISABLE,
               UART1_MODE_TXRX_ENABLE);

    UART1_Cmd(ENABLE);
}

void UART_SendChar(uint8_t c)
{
    UART1_SendData8(c);
    while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
}

void UART_SendString(char *s)
{
    while(*s)
        UART_SendChar(*s++);
}

void hal_gpio_init(void)
{
    /* ===== Digital Inputs (Sensors) ===== */
    GPIO_Init(DI1_PORT, DI1_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(DI2_PORT, DI2_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(DI3_PORT, DI3_PIN, GPIO_MODE_IN_PU_NO_IT);
    GPIO_Init(DI4_PORT, DI4_PIN, GPIO_MODE_IN_PU_NO_IT);

    GPIO_Init(RELAY1_PORT, RELAY1_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY2_PORT, RELAY2_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY3_PORT, RELAY3_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY4_PORT, RELAY4_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY5_PORT, RELAY5_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
    GPIO_Init(RELAY6_PORT, RELAY6_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);

    /* All OFF */
    hal_relay_set(1,0);
    hal_relay_set(2,0);
    hal_relay_set(3,0);
    hal_relay_set(4,0);
    hal_relay_set(5,0);
    hal_relay_set(6,0);
    delay_ms(3000);
    GPIO_Init(HARDRST_PORT, HARDRST_PIN, GPIO_MODE_IN_PU_NO_IT);
}
uint8_t UART_ReadChar(void)
{
    while(UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);
    return UART1_ReceiveData8();
}
void process_command(char *cmd)
{
    uint8_t relay_num;
    uint8_t state;

    if(cmd[0] == 'R' &&
       cmd[1] >= '1' &&
       cmd[1] <= '6' &&
       cmd[2] == ',' &&
       (cmd[3] == '0' || cmd[3] == '1') &&
       cmd[4] == '\0')
    {
        relay_num = cmd[1] - '0';
        state = cmd[3] - '0';

        hal_relay_set(relay_num, state);

        UART_SendString("Relay ");
        UART_SendChar(cmd[1]);
        UART_SendString(" = ");
        UART_SendChar(cmd[3]);
        UART_SendString("\r\n");
    }
    else
    {
        UART_SendString("ERR\r\n");
    }
}
void system_init(void)
{
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
    hal_gpio_init();
    relay_off();
    UART_Config();
    sensor_reader_init();
}

void main_loop(void)
{
    char rx_buf[8];
    uint8_t idx = 0;
    uint8_t c;

    while(1)
    {
        c = UART_ReadChar();

        if(c == '\r' || c == '\n')
        {
            rx_buf[idx] = '\0';

            if(idx > 0)
            {
                process_command(rx_buf);
            }

            idx = 0;
        }
        else
        {
            if(idx < sizeof(rx_buf)-1)
            {
                rx_buf[idx++] = c;
            }
        }
    }
}
int main(void)
{
    system_init();
    main_loop();

    while(1);
}