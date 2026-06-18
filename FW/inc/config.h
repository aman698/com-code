#ifndef __CONFIG_H
#define __CONFIG_H

#define DI1_PORT        GPIOD
#define DI1_PIN         GPIO_PIN_2
#define DI2_PORT        GPIOD
#define DI2_PIN         GPIO_PIN_3
#define DI3_PORT        GPIOD
#define DI3_PIN         GPIO_PIN_4
#define DI4_PORT        GPIOD
#define DI4_PIN         GPIO_PIN_7

/* Relay Outputs */
#define RELAY1_PORT     GPIOB
#define RELAY1_PIN      GPIO_PIN_3
#define RELAY2_PORT     GPIOB
#define RELAY2_PIN      GPIO_PIN_2
#define RELAY3_PORT     GPIOB
#define RELAY3_PIN      GPIO_PIN_1
#define RELAY4_PORT     GPIOB
#define RELAY4_PIN      GPIO_PIN_0
#define RELAY5_PORT     GPIOC
#define RELAY5_PIN      GPIO_PIN_3
#define RELAY6_PORT     GPIOC
#define RELAY6_PIN      GPIO_PIN_4

/* Hardware Reset Input */
#define HARDRST_PORT    GPIOB
#define HARDRST_PIN     GPIO_PIN_7

#endif