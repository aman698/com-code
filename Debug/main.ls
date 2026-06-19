   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  72                     ; 3 void delay_ms(uint16_t ms)
  72                     ; 4 {
  74                     	switch	.text
  75  0000               _delay_ms:
  77  0000 89            	pushw	x
  78  0001 5204          	subw	sp,#4
  79       00000004      OFST:	set	4
  82                     ; 7     for(i = 0; i < ms; i++)
  84  0003 5f            	clrw	x
  85  0004 1f01          	ldw	(OFST-3,sp),x
  88  0006 2019          	jra	L34
  89  0008               L73:
  90                     ; 9         for(j = 0; j < 4000; j++)
  92  0008 5f            	clrw	x
  93  0009 1f03          	ldw	(OFST-1,sp),x
  95  000b               L74:
  96                     ; 11             nop();
  99  000b 9d            nop
 101                     ; 9         for(j = 0; j < 4000; j++)
 104  000c 1e03          	ldw	x,(OFST-1,sp)
 105  000e 1c0001        	addw	x,#1
 106  0011 1f03          	ldw	(OFST-1,sp),x
 110  0013 1e03          	ldw	x,(OFST-1,sp)
 111  0015 a30fa0        	cpw	x,#4000
 112  0018 25f1          	jrult	L74
 113                     ; 7     for(i = 0; i < ms; i++)
 115  001a 1e01          	ldw	x,(OFST-3,sp)
 116  001c 1c0001        	addw	x,#1
 117  001f 1f01          	ldw	(OFST-3,sp),x
 119  0021               L34:
 122  0021 1e01          	ldw	x,(OFST-3,sp)
 123  0023 1305          	cpw	x,(OFST+1,sp)
 124  0025 25e1          	jrult	L73
 125                     ; 14 }
 128  0027 5b06          	addw	sp,#6
 129  0029 81            	ret
 156                     ; 16 void UART_Config(void)
 156                     ; 17 {
 157                     	switch	.text
 158  002a               _UART_Config:
 162                     ; 18     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 164  002a 4f            	clr	a
 165  002b cd0000        	call	_CLK_HSIPrescalerConfig
 167                     ; 20     UART1_DeInit();
 169  002e cd0000        	call	_UART1_DeInit
 171                     ; 22     UART1_Init(
 171                     ; 23         9600,
 171                     ; 24         UART1_WORDLENGTH_8D,
 171                     ; 25         UART1_STOPBITS_1,
 171                     ; 26         UART1_PARITY_NO,
 171                     ; 27         UART1_SYNCMODE_CLOCK_DISABLE,
 171                     ; 28         UART1_MODE_TXRX_ENABLE);
 173  0031 4b0c          	push	#12
 174  0033 4b80          	push	#128
 175  0035 4b00          	push	#0
 176  0037 4b00          	push	#0
 177  0039 4b00          	push	#0
 178  003b ae2580        	ldw	x,#9600
 179  003e 89            	pushw	x
 180  003f ae0000        	ldw	x,#0
 181  0042 89            	pushw	x
 182  0043 cd0000        	call	_UART1_Init
 184  0046 5b09          	addw	sp,#9
 185                     ; 30     UART1_Cmd(ENABLE);
 187  0048 a601          	ld	a,#1
 188  004a cd0000        	call	_UART1_Cmd
 190                     ; 31 }
 193  004d 81            	ret
 229                     ; 33 void UART_SendChar(uint8_t ch)
 229                     ; 34 {
 230                     	switch	.text
 231  004e               _UART_SendChar:
 235                     ; 35     UART1_SendData8(ch);
 237  004e cd0000        	call	_UART1_SendData8
 240  0051               L501:
 241                     ; 36     while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 243  0051 ae0080        	ldw	x,#128
 244  0054 cd0000        	call	_UART1_GetFlagStatus
 246  0057 4d            	tnz	a
 247  0058 27f7          	jreq	L501
 248                     ; 37 }
 251  005a 81            	ret
 287                     ; 39 void UART_SendString(char *str)
 287                     ; 40 {
 288                     	switch	.text
 289  005b               _UART_SendString:
 291  005b 89            	pushw	x
 292       00000000      OFST:	set	0
 295  005c 200d          	jra	L131
 296  005e               L721:
 297                     ; 43         UART_SendChar(*str++);
 299  005e 1e01          	ldw	x,(OFST+1,sp)
 300  0060 1c0001        	addw	x,#1
 301  0063 1f01          	ldw	(OFST+1,sp),x
 302  0065 1d0001        	subw	x,#1
 303  0068 f6            	ld	a,(x)
 304  0069 ade3          	call	_UART_SendChar
 306  006b               L131:
 307                     ; 41     while(*str)
 309  006b 1e01          	ldw	x,(OFST+1,sp)
 310  006d 7d            	tnz	(x)
 311  006e 26ee          	jrne	L721
 312                     ; 45 }
 315  0070 85            	popw	x
 316  0071 81            	ret
 340                     ; 47 void GPIO_Config(void)
 340                     ; 48 {
 341                     	switch	.text
 342  0072               _GPIO_Config:
 346                     ; 50     GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT);   // DI1
 348  0072 4b40          	push	#64
 349  0074 4b04          	push	#4
 350  0076 ae500f        	ldw	x,#20495
 351  0079 cd0000        	call	_GPIO_Init
 353  007c 85            	popw	x
 354                     ; 51     GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT);   // DI2
 356  007d 4b40          	push	#64
 357  007f 4b08          	push	#8
 358  0081 ae500f        	ldw	x,#20495
 359  0084 cd0000        	call	_GPIO_Init
 361  0087 85            	popw	x
 362                     ; 52     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT);   // DI3
 364  0088 4b40          	push	#64
 365  008a 4b10          	push	#16
 366  008c ae500f        	ldw	x,#20495
 367  008f cd0000        	call	_GPIO_Init
 369  0092 85            	popw	x
 370                     ; 53     GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT);   // DI4
 372  0093 4b40          	push	#64
 373  0095 4b80          	push	#128
 374  0097 ae500f        	ldw	x,#20495
 375  009a cd0000        	call	_GPIO_Init
 377  009d 85            	popw	x
 378                     ; 54 }
 381  009e 81            	ret
 421                     ; 56 void main(void)
 421                     ; 57 {
 422                     	switch	.text
 423  009f               _main:
 425  009f 5207          	subw	sp,#7
 426       00000007      OFST:	set	7
 429                     ; 60     UART_Config();
 431  00a1 ad87          	call	_UART_Config
 433                     ; 61     GPIO_Config();
 435  00a3 adcd          	call	_GPIO_Config
 437  00a5               L361:
 438                     ; 66         msg[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2)==RESET) ? '1' : '0';
 440  00a5 4b04          	push	#4
 441  00a7 ae500f        	ldw	x,#20495
 442  00aa cd0000        	call	_GPIO_ReadInputPin
 444  00ad 5b01          	addw	sp,#1
 445  00af 4d            	tnz	a
 446  00b0 2604          	jrne	L02
 447  00b2 a631          	ld	a,#49
 448  00b4 2002          	jra	L22
 449  00b6               L02:
 450  00b6 a630          	ld	a,#48
 451  00b8               L22:
 452  00b8 6b01          	ld	(OFST-6,sp),a
 454                     ; 67         msg[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3)==RESET) ? '1' : '0';
 456  00ba 4b08          	push	#8
 457  00bc ae500f        	ldw	x,#20495
 458  00bf cd0000        	call	_GPIO_ReadInputPin
 460  00c2 5b01          	addw	sp,#1
 461  00c4 4d            	tnz	a
 462  00c5 2604          	jrne	L42
 463  00c7 a631          	ld	a,#49
 464  00c9 2002          	jra	L62
 465  00cb               L42:
 466  00cb a630          	ld	a,#48
 467  00cd               L62:
 468  00cd 6b02          	ld	(OFST-5,sp),a
 470                     ; 68         msg[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4)==RESET) ? '1' : '0';
 472  00cf 4b10          	push	#16
 473  00d1 ae500f        	ldw	x,#20495
 474  00d4 cd0000        	call	_GPIO_ReadInputPin
 476  00d7 5b01          	addw	sp,#1
 477  00d9 4d            	tnz	a
 478  00da 2604          	jrne	L03
 479  00dc a631          	ld	a,#49
 480  00de 2002          	jra	L23
 481  00e0               L03:
 482  00e0 a630          	ld	a,#48
 483  00e2               L23:
 484  00e2 6b03          	ld	(OFST-4,sp),a
 486                     ; 69         msg[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7)==RESET) ? '1' : '0';
 488  00e4 4b80          	push	#128
 489  00e6 ae500f        	ldw	x,#20495
 490  00e9 cd0000        	call	_GPIO_ReadInputPin
 492  00ec 5b01          	addw	sp,#1
 493  00ee 4d            	tnz	a
 494  00ef 2604          	jrne	L43
 495  00f1 a631          	ld	a,#49
 496  00f3 2002          	jra	L63
 497  00f5               L43:
 498  00f5 a630          	ld	a,#48
 499  00f7               L63:
 500  00f7 6b04          	ld	(OFST-3,sp),a
 502                     ; 71         msg[4] = '\r';
 504  00f9 a60d          	ld	a,#13
 505  00fb 6b05          	ld	(OFST-2,sp),a
 507                     ; 72         msg[5] = '\n';
 509  00fd a60a          	ld	a,#10
 510  00ff 6b06          	ld	(OFST-1,sp),a
 512                     ; 73         msg[6] = '\0';
 514  0101 0f07          	clr	(OFST+0,sp)
 516                     ; 75         UART_SendString(msg);
 518  0103 96            	ldw	x,sp
 519  0104 1c0001        	addw	x,#OFST-6
 520  0107 cd005b        	call	_UART_SendString
 522                     ; 77         delay_ms(50);
 524  010a ae0032        	ldw	x,#50
 525  010d cd0000        	call	_delay_ms
 528  0110 2093          	jra	L361
 541                     	xdef	_main
 542                     	xdef	_GPIO_Config
 543                     	xdef	_UART_SendString
 544                     	xdef	_UART_SendChar
 545                     	xdef	_UART_Config
 546                     	xdef	_delay_ms
 547                     	xref	_UART1_GetFlagStatus
 548                     	xref	_UART1_SendData8
 549                     	xref	_UART1_Cmd
 550                     	xref	_UART1_Init
 551                     	xref	_UART1_DeInit
 552                     	xref	_GPIO_ReadInputPin
 553                     	xref	_GPIO_Init
 554                     	xref	_CLK_HSIPrescalerConfig
 573                     	end
