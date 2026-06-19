   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  14                     	bsct
  15  0000               _index:
  16  0000 00            	dc.b	0
  17  0001               _prev_input_str:
  18  0001 58            	dc.b	88
  19  0002 58            	dc.b	88
  20  0003 58            	dc.b	88
  21  0004 58            	dc.b	88
  22  0005 0d            	dc.b	13
  23  0006 0a            	dc.b	10
  24  0007 00            	dc.b	0
  83                     ; 10 void delay_ms(uint16_t ms)
  83                     ; 11 {
  85                     	switch	.text
  86  0000               _delay_ms:
  88  0000 89            	pushw	x
  89  0001 5204          	subw	sp,#4
  90       00000004      OFST:	set	4
  93                     ; 14     for(i = 0; i < ms; i++)
  95  0003 5f            	clrw	x
  96  0004 1f01          	ldw	(OFST-3,sp),x
  99  0006 2019          	jra	L34
 100  0008               L73:
 101                     ; 16         for(j = 0; j < 4000; j++)
 103  0008 5f            	clrw	x
 104  0009 1f03          	ldw	(OFST-1,sp),x
 106  000b               L74:
 107                     ; 18             nop();
 110  000b 9d            nop
 112                     ; 16         for(j = 0; j < 4000; j++)
 115  000c 1e03          	ldw	x,(OFST-1,sp)
 116  000e 1c0001        	addw	x,#1
 117  0011 1f03          	ldw	(OFST-1,sp),x
 121  0013 1e03          	ldw	x,(OFST-1,sp)
 122  0015 a30fa0        	cpw	x,#4000
 123  0018 25f1          	jrult	L74
 124                     ; 14     for(i = 0; i < ms; i++)
 126  001a 1e01          	ldw	x,(OFST-3,sp)
 127  001c 1c0001        	addw	x,#1
 128  001f 1f01          	ldw	(OFST-3,sp),x
 130  0021               L34:
 133  0021 1e01          	ldw	x,(OFST-3,sp)
 134  0023 1305          	cpw	x,(OFST+1,sp)
 135  0025 25e1          	jrult	L73
 136                     ; 21 }
 139  0027 5b06          	addw	sp,#6
 140  0029 81            	ret
 167                     ; 23 void UART_Config(void)
 167                     ; 24 {
 168                     	switch	.text
 169  002a               _UART_Config:
 173                     ; 25     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 175  002a 4f            	clr	a
 176  002b cd0000        	call	_CLK_HSIPrescalerConfig
 178                     ; 27     UART1_DeInit();
 180  002e cd0000        	call	_UART1_DeInit
 182                     ; 29     UART1_Init(
 182                     ; 30         9600,
 182                     ; 31         UART1_WORDLENGTH_8D,
 182                     ; 32         UART1_STOPBITS_1,
 182                     ; 33         UART1_PARITY_NO,
 182                     ; 34         UART1_SYNCMODE_CLOCK_DISABLE,
 182                     ; 35         UART1_MODE_TXRX_ENABLE);
 184  0031 4b0c          	push	#12
 185  0033 4b80          	push	#128
 186  0035 4b00          	push	#0
 187  0037 4b00          	push	#0
 188  0039 4b00          	push	#0
 189  003b ae2580        	ldw	x,#9600
 190  003e 89            	pushw	x
 191  003f ae0000        	ldw	x,#0
 192  0042 89            	pushw	x
 193  0043 cd0000        	call	_UART1_Init
 195  0046 5b09          	addw	sp,#9
 196                     ; 37     UART1_Cmd(ENABLE);
 198  0048 a601          	ld	a,#1
 199  004a cd0000        	call	_UART1_Cmd
 201                     ; 38 }
 204  004d 81            	ret
 240                     ; 40 void UART_SendChar(uint8_t ch)
 240                     ; 41 {
 241                     	switch	.text
 242  004e               _UART_SendChar:
 246                     ; 42     UART1_SendData8(ch);
 248  004e cd0000        	call	_UART1_SendData8
 251  0051               L501:
 252                     ; 43     while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 254  0051 ae0080        	ldw	x,#128
 255  0054 cd0000        	call	_UART1_GetFlagStatus
 257  0057 4d            	tnz	a
 258  0058 27f7          	jreq	L501
 259                     ; 44 }
 262  005a 81            	ret
 298                     ; 46 void UART_SendString(char *str)
 298                     ; 47 {
 299                     	switch	.text
 300  005b               _UART_SendString:
 302  005b 89            	pushw	x
 303       00000000      OFST:	set	0
 306  005c 200d          	jra	L131
 307  005e               L721:
 308                     ; 50         UART_SendChar(*str++);
 310  005e 1e01          	ldw	x,(OFST+1,sp)
 311  0060 1c0001        	addw	x,#1
 312  0063 1f01          	ldw	(OFST+1,sp),x
 313  0065 1d0001        	subw	x,#1
 314  0068 f6            	ld	a,(x)
 315  0069 ade3          	call	_UART_SendChar
 317  006b               L131:
 318                     ; 48     while(*str)
 320  006b 1e01          	ldw	x,(OFST+1,sp)
 321  006d 7d            	tnz	(x)
 322  006e 26ee          	jrne	L721
 323                     ; 52 }
 326  0070 85            	popw	x
 327  0071 81            	ret
 372                     ; 53 void Relay_Control(uint8_t relay, uint8_t state)
 372                     ; 54 {
 373                     	switch	.text
 374  0072               _Relay_Control:
 376  0072 89            	pushw	x
 377       00000000      OFST:	set	0
 380                     ; 55     switch(relay)
 382  0073 9e            	ld	a,xh
 384                     ; 85             break;
 385  0074 4a            	dec	a
 386  0075 2716          	jreq	L531
 387  0077 4a            	dec	a
 388  0078 2730          	jreq	L731
 389  007a 4a            	dec	a
 390  007b 2747          	jreq	L141
 391  007d 4a            	dec	a
 392  007e 275e          	jreq	L341
 393  0080 4a            	dec	a
 394  0081 2775          	jreq	L541
 395  0083 4a            	dec	a
 396  0084 2603cc0112    	jreq	L741
 397  0089 ac2a012a      	jpf	L571
 398  008d               L531:
 399                     ; 57         case 1:
 399                     ; 58             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_3);
 401  008d 0d02          	tnz	(OFST+2,sp)
 402  008f 270d          	jreq	L771
 405  0091 4b08          	push	#8
 406  0093 ae5005        	ldw	x,#20485
 407  0096 cd0000        	call	_GPIO_WriteHigh
 409  0099 84            	pop	a
 411  009a ac2a012a      	jpf	L571
 412  009e               L771:
 413                     ; 59             else      GPIO_WriteLow(GPIOB, GPIO_PIN_3);
 415  009e 4b08          	push	#8
 416  00a0 ae5005        	ldw	x,#20485
 417  00a3 cd0000        	call	_GPIO_WriteLow
 419  00a6 84            	pop	a
 420  00a7 cc012a        	jra	L571
 421  00aa               L731:
 422                     ; 62         case 2:
 422                     ; 63             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_2);
 424  00aa 0d02          	tnz	(OFST+2,sp)
 425  00ac 270b          	jreq	L302
 428  00ae 4b04          	push	#4
 429  00b0 ae5005        	ldw	x,#20485
 430  00b3 cd0000        	call	_GPIO_WriteHigh
 432  00b6 84            	pop	a
 434  00b7 2071          	jra	L571
 435  00b9               L302:
 436                     ; 64             else      GPIO_WriteLow(GPIOB, GPIO_PIN_2);
 438  00b9 4b04          	push	#4
 439  00bb ae5005        	ldw	x,#20485
 440  00be cd0000        	call	_GPIO_WriteLow
 442  00c1 84            	pop	a
 443  00c2 2066          	jra	L571
 444  00c4               L141:
 445                     ; 67         case 3:
 445                     ; 68             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_1);
 447  00c4 0d02          	tnz	(OFST+2,sp)
 448  00c6 270b          	jreq	L702
 451  00c8 4b02          	push	#2
 452  00ca ae5005        	ldw	x,#20485
 453  00cd cd0000        	call	_GPIO_WriteHigh
 455  00d0 84            	pop	a
 457  00d1 2057          	jra	L571
 458  00d3               L702:
 459                     ; 69             else      GPIO_WriteLow(GPIOB, GPIO_PIN_1);
 461  00d3 4b02          	push	#2
 462  00d5 ae5005        	ldw	x,#20485
 463  00d8 cd0000        	call	_GPIO_WriteLow
 465  00db 84            	pop	a
 466  00dc 204c          	jra	L571
 467  00de               L341:
 468                     ; 72         case 4:
 468                     ; 73             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
 470  00de 0d02          	tnz	(OFST+2,sp)
 471  00e0 270b          	jreq	L312
 474  00e2 4b01          	push	#1
 475  00e4 ae5005        	ldw	x,#20485
 476  00e7 cd0000        	call	_GPIO_WriteHigh
 478  00ea 84            	pop	a
 480  00eb 203d          	jra	L571
 481  00ed               L312:
 482                     ; 74             else      GPIO_WriteLow(GPIOB, GPIO_PIN_0);
 484  00ed 4b01          	push	#1
 485  00ef ae5005        	ldw	x,#20485
 486  00f2 cd0000        	call	_GPIO_WriteLow
 488  00f5 84            	pop	a
 489  00f6 2032          	jra	L571
 490  00f8               L541:
 491                     ; 77         case 5:
 491                     ; 78             if(state) GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 493  00f8 0d02          	tnz	(OFST+2,sp)
 494  00fa 270b          	jreq	L712
 497  00fc 4b08          	push	#8
 498  00fe ae500a        	ldw	x,#20490
 499  0101 cd0000        	call	_GPIO_WriteHigh
 501  0104 84            	pop	a
 503  0105 2023          	jra	L571
 504  0107               L712:
 505                     ; 79             else      GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 507  0107 4b08          	push	#8
 508  0109 ae500a        	ldw	x,#20490
 509  010c cd0000        	call	_GPIO_WriteLow
 511  010f 84            	pop	a
 512  0110 2018          	jra	L571
 513  0112               L741:
 514                     ; 82         case 6:
 514                     ; 83             if(state) GPIO_WriteHigh(GPIOC, GPIO_PIN_4);
 516  0112 0d02          	tnz	(OFST+2,sp)
 517  0114 270b          	jreq	L322
 520  0116 4b10          	push	#16
 521  0118 ae500a        	ldw	x,#20490
 522  011b cd0000        	call	_GPIO_WriteHigh
 524  011e 84            	pop	a
 526  011f 2009          	jra	L571
 527  0121               L322:
 528                     ; 84             else      GPIO_WriteLow(GPIOC, GPIO_PIN_4);
 530  0121 4b10          	push	#16
 531  0123 ae500a        	ldw	x,#20490
 532  0126 cd0000        	call	_GPIO_WriteLow
 534  0129 84            	pop	a
 535  012a               L571:
 536                     ; 87 }
 539  012a 85            	popw	x
 540  012b 81            	ret
 567                     ; 88 void Input_Status_Send(void)
 567                     ; 89 {
 568                     	switch	.text
 569  012c               _Input_Status_Send:
 573                     ; 90     input_str[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2) == RESET) ? '1' : '0';
 575  012c 4b04          	push	#4
 576  012e ae500f        	ldw	x,#20495
 577  0131 cd0000        	call	_GPIO_ReadInputPin
 579  0134 5b01          	addw	sp,#1
 580  0136 4d            	tnz	a
 581  0137 2604          	jrne	L02
 582  0139 a631          	ld	a,#49
 583  013b 2002          	jra	L22
 584  013d               L02:
 585  013d a630          	ld	a,#48
 586  013f               L22:
 587  013f b700          	ld	_input_str,a
 588                     ; 91     input_str[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3) == RESET) ? '1' : '0';
 590  0141 4b08          	push	#8
 591  0143 ae500f        	ldw	x,#20495
 592  0146 cd0000        	call	_GPIO_ReadInputPin
 594  0149 5b01          	addw	sp,#1
 595  014b 4d            	tnz	a
 596  014c 2604          	jrne	L42
 597  014e a631          	ld	a,#49
 598  0150 2002          	jra	L62
 599  0152               L42:
 600  0152 a630          	ld	a,#48
 601  0154               L62:
 602  0154 b701          	ld	_input_str+1,a
 603                     ; 92     input_str[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4) == RESET) ? '1' : '0';
 605  0156 4b10          	push	#16
 606  0158 ae500f        	ldw	x,#20495
 607  015b cd0000        	call	_GPIO_ReadInputPin
 609  015e 5b01          	addw	sp,#1
 610  0160 4d            	tnz	a
 611  0161 2604          	jrne	L03
 612  0163 a631          	ld	a,#49
 613  0165 2002          	jra	L23
 614  0167               L03:
 615  0167 a630          	ld	a,#48
 616  0169               L23:
 617  0169 b702          	ld	_input_str+2,a
 618                     ; 93     input_str[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7) == RESET) ? '1' : '0';
 620  016b 4b80          	push	#128
 621  016d ae500f        	ldw	x,#20495
 622  0170 cd0000        	call	_GPIO_ReadInputPin
 624  0173 5b01          	addw	sp,#1
 625  0175 4d            	tnz	a
 626  0176 2604          	jrne	L43
 627  0178 a631          	ld	a,#49
 628  017a 2002          	jra	L63
 629  017c               L43:
 630  017c a630          	ld	a,#48
 631  017e               L63:
 632  017e b703          	ld	_input_str+3,a
 633                     ; 95     input_str[4] = '\r';
 635  0180 350d0004      	mov	_input_str+4,#13
 636                     ; 96     input_str[5] = '\n';
 638  0184 350a0005      	mov	_input_str+5,#10
 639                     ; 97     input_str[6] = '\0';
 641  0188 3f06          	clr	_input_str+6
 642                     ; 99     if((input_str[0] != prev_input_str[0]) ||
 642                     ; 100        (input_str[1] != prev_input_str[1]) ||
 642                     ; 101        (input_str[2] != prev_input_str[2]) ||
 642                     ; 102        (input_str[3] != prev_input_str[3]))
 644  018a b600          	ld	a,_input_str
 645  018c b101          	cp	a,_prev_input_str
 646  018e 2612          	jrne	L142
 648  0190 b601          	ld	a,_input_str+1
 649  0192 b102          	cp	a,_prev_input_str+1
 650  0194 260c          	jrne	L142
 652  0196 b602          	ld	a,_input_str+2
 653  0198 b103          	cp	a,_prev_input_str+2
 654  019a 2606          	jrne	L142
 656  019c b603          	ld	a,_input_str+3
 657  019e b104          	cp	a,_prev_input_str+3
 658  01a0 2712          	jreq	L732
 659  01a2               L142:
 660                     ; 104         UART_SendString(input_str);
 662  01a2 ae0000        	ldw	x,#_input_str
 663  01a5 cd005b        	call	_UART_SendString
 665                     ; 106         prev_input_str[0] = input_str[0];
 667  01a8 450001        	mov	_prev_input_str,_input_str
 668                     ; 107         prev_input_str[1] = input_str[1];
 670  01ab 450102        	mov	_prev_input_str+1,_input_str+1
 671                     ; 108         prev_input_str[2] = input_str[2];
 673  01ae 450203        	mov	_prev_input_str+2,_input_str+2
 674                     ; 109         prev_input_str[3] = input_str[3];
 676  01b1 450304        	mov	_prev_input_str+3,_input_str+3
 677  01b4               L732:
 678                     ; 111 }
 681  01b4 81            	ret
 706                     ; 112 void GPIO_Config(void)
 706                     ; 113 {
 707                     	switch	.text
 708  01b5               _GPIO_Config:
 712                     ; 115     GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 714  01b5 4be0          	push	#224
 715  01b7 4b02          	push	#2
 716  01b9 ae500a        	ldw	x,#20490
 717  01bc cd0000        	call	_GPIO_Init
 719  01bf 85            	popw	x
 720                     ; 116     GPIO_WriteLow(GPIOC, GPIO_PIN_1);
 722  01c0 4b02          	push	#2
 723  01c2 ae500a        	ldw	x,#20490
 724  01c5 cd0000        	call	_GPIO_WriteLow
 726  01c8 84            	pop	a
 727                     ; 119     GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // R1
 729  01c9 4be0          	push	#224
 730  01cb 4b08          	push	#8
 731  01cd ae5005        	ldw	x,#20485
 732  01d0 cd0000        	call	_GPIO_Init
 734  01d3 85            	popw	x
 735                     ; 120     GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // R2
 737  01d4 4be0          	push	#224
 738  01d6 4b04          	push	#4
 739  01d8 ae5005        	ldw	x,#20485
 740  01db cd0000        	call	_GPIO_Init
 742  01de 85            	popw	x
 743                     ; 121     GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST); // R3
 745  01df 4be0          	push	#224
 746  01e1 4b02          	push	#2
 747  01e3 ae5005        	ldw	x,#20485
 748  01e6 cd0000        	call	_GPIO_Init
 750  01e9 85            	popw	x
 751                     ; 122     GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // R4
 753  01ea 4be0          	push	#224
 754  01ec 4b01          	push	#1
 755  01ee ae5005        	ldw	x,#20485
 756  01f1 cd0000        	call	_GPIO_Init
 758  01f4 85            	popw	x
 759                     ; 123     GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // R5
 761  01f5 4be0          	push	#224
 762  01f7 4b08          	push	#8
 763  01f9 ae500a        	ldw	x,#20490
 764  01fc cd0000        	call	_GPIO_Init
 766  01ff 85            	popw	x
 767                     ; 124     GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // R6
 769  0200 4be0          	push	#224
 770  0202 4b10          	push	#16
 771  0204 ae500a        	ldw	x,#20490
 772  0207 cd0000        	call	_GPIO_Init
 774  020a 85            	popw	x
 775                     ; 127     GPIO_WriteLow(GPIOB, GPIO_PIN_3);
 777  020b 4b08          	push	#8
 778  020d ae5005        	ldw	x,#20485
 779  0210 cd0000        	call	_GPIO_WriteLow
 781  0213 84            	pop	a
 782                     ; 128     GPIO_WriteLow(GPIOB, GPIO_PIN_2);
 784  0214 4b04          	push	#4
 785  0216 ae5005        	ldw	x,#20485
 786  0219 cd0000        	call	_GPIO_WriteLow
 788  021c 84            	pop	a
 789                     ; 129     GPIO_WriteLow(GPIOB, GPIO_PIN_1);
 791  021d 4b02          	push	#2
 792  021f ae5005        	ldw	x,#20485
 793  0222 cd0000        	call	_GPIO_WriteLow
 795  0225 84            	pop	a
 796                     ; 130     GPIO_WriteLow(GPIOB, GPIO_PIN_0);
 798  0226 4b01          	push	#1
 799  0228 ae5005        	ldw	x,#20485
 800  022b cd0000        	call	_GPIO_WriteLow
 802  022e 84            	pop	a
 803                     ; 131     GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 805  022f 4b08          	push	#8
 806  0231 ae500a        	ldw	x,#20490
 807  0234 cd0000        	call	_GPIO_WriteLow
 809  0237 84            	pop	a
 810                     ; 132     GPIO_WriteLow(GPIOC, GPIO_PIN_4);
 812  0238 4b10          	push	#16
 813  023a ae500a        	ldw	x,#20490
 814  023d cd0000        	call	_GPIO_WriteLow
 816  0240 84            	pop	a
 817                     ; 135     GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT); // DI1
 819  0241 4b40          	push	#64
 820  0243 4b04          	push	#4
 821  0245 ae500f        	ldw	x,#20495
 822  0248 cd0000        	call	_GPIO_Init
 824  024b 85            	popw	x
 825                     ; 136     GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // DI2
 827  024c 4b40          	push	#64
 828  024e 4b08          	push	#8
 829  0250 ae500f        	ldw	x,#20495
 830  0253 cd0000        	call	_GPIO_Init
 832  0256 85            	popw	x
 833                     ; 137     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT); // DI3
 835  0257 4b40          	push	#64
 836  0259 4b10          	push	#16
 837  025b ae500f        	ldw	x,#20495
 838  025e cd0000        	call	_GPIO_Init
 840  0261 85            	popw	x
 841                     ; 138     GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT); // DI4
 843  0262 4b40          	push	#64
 844  0264 4b80          	push	#128
 845  0266 ae500f        	ldw	x,#20495
 846  0269 cd0000        	call	_GPIO_Init
 848  026c 85            	popw	x
 849                     ; 139 }
 852  026d 81            	ret
 896                     ; 140 void main(void)
 896                     ; 141 {
 897                     	switch	.text
 898  026e               _main:
 900  026e 88            	push	a
 901       00000001      OFST:	set	1
 904                     ; 144     UART_Config();
 906  026f cd002a        	call	_UART_Config
 908                     ; 145     GPIO_Config();
 910  0272 cd01b5        	call	_GPIO_Config
 912                     ; 147     UART_SendString("SYSTEM START\r\n");
 914  0275 ae000a        	ldw	x,#L572
 915  0278 cd005b        	call	_UART_SendString
 917  027b               L772:
 918                     ; 152         if(UART1_GetFlagStatus(UART1_FLAG_RXNE) != RESET)
 920  027b ae0020        	ldw	x,#32
 921  027e cd0000        	call	_UART1_GetFlagStatus
 923  0281 4d            	tnz	a
 924  0282 277a          	jreq	L303
 925                     ; 154             ch = UART1_ReceiveData8();
 927  0284 cd0000        	call	_UART1_ReceiveData8
 929  0287 6b01          	ld	(OFST+0,sp),a
 931                     ; 156             if((ch == '\r') || (ch == '\n'))
 933  0289 7b01          	ld	a,(OFST+0,sp)
 934  028b a10d          	cp	a,#13
 935  028d 2706          	jreq	L703
 937  028f 7b01          	ld	a,(OFST+0,sp)
 938  0291 a10a          	cp	a,#10
 939  0293 2657          	jrne	L503
 940  0295               L703:
 941                     ; 158                 rx_buf[index] = '\0';
 943  0295 b600          	ld	a,_index
 944  0297 5f            	clrw	x
 945  0298 97            	ld	xl,a
 946  0299 6f07          	clr	(_rx_buf,x)
 947                     ; 160                 if((rx_buf[0] == 'R') &&
 947                     ; 161                 (rx_buf[1] >= '1') &&
 947                     ; 162                 (rx_buf[1] <= '6') &&
 947                     ; 163                 (rx_buf[2] == ',') &&
 947                     ; 164                 ((rx_buf[3] == '0') || (rx_buf[3] == '1')))
 949  029b b607          	ld	a,_rx_buf
 950  029d a152          	cp	a,#82
 951  029f 2647          	jrne	L113
 953  02a1 b608          	ld	a,_rx_buf+1
 954  02a3 a131          	cp	a,#49
 955  02a5 2541          	jrult	L113
 957  02a7 b608          	ld	a,_rx_buf+1
 958  02a9 a137          	cp	a,#55
 959  02ab 243b          	jruge	L113
 961  02ad b609          	ld	a,_rx_buf+2
 962  02af a12c          	cp	a,#44
 963  02b1 2635          	jrne	L113
 965  02b3 b60a          	ld	a,_rx_buf+3
 966  02b5 a130          	cp	a,#48
 967  02b7 2706          	jreq	L313
 969  02b9 b60a          	ld	a,_rx_buf+3
 970  02bb a131          	cp	a,#49
 971  02bd 2629          	jrne	L113
 972  02bf               L313:
 973                     ; 166                     Relay_Control(rx_buf[1] - '0',
 973                     ; 167                                   rx_buf[3] - '0');
 975  02bf b60a          	ld	a,_rx_buf+3
 976  02c1 a030          	sub	a,#48
 977  02c3 97            	ld	xl,a
 978  02c4 b608          	ld	a,_rx_buf+1
 979  02c6 a030          	sub	a,#48
 980  02c8 95            	ld	xh,a
 981  02c9 cd0072        	call	_Relay_Control
 983                     ; 169                     UART_SendString("R");
 985  02cc ae0008        	ldw	x,#L513
 986  02cf cd005b        	call	_UART_SendString
 988                     ; 170                     UART_SendChar(rx_buf[1]);
 990  02d2 b608          	ld	a,_rx_buf+1
 991  02d4 cd004e        	call	_UART_SendChar
 993                     ; 171                     UART_SendString(",");
 995  02d7 ae0006        	ldw	x,#L713
 996  02da cd005b        	call	_UART_SendString
 998                     ; 172                     UART_SendChar(rx_buf[3]);
1000  02dd b60a          	ld	a,_rx_buf+3
1001  02df cd004e        	call	_UART_SendChar
1003                     ; 173                     UART_SendString(" OK\r\n");
1005  02e2 ae0000        	ldw	x,#L123
1006  02e5 cd005b        	call	_UART_SendString
1008  02e8               L113:
1009                     ; 176                 index = 0;
1011  02e8 3f00          	clr	_index
1013  02ea 2012          	jra	L303
1014  02ec               L503:
1015                     ; 180                 if(index < sizeof(rx_buf)-1)
1017  02ec b600          	ld	a,_index
1018  02ee a10f          	cp	a,#15
1019  02f0 240c          	jruge	L303
1020                     ; 182                     rx_buf[index++] = ch;
1022  02f2 b600          	ld	a,_index
1023  02f4 97            	ld	xl,a
1024  02f5 3c00          	inc	_index
1025  02f7 9f            	ld	a,xl
1026  02f8 5f            	clrw	x
1027  02f9 97            	ld	xl,a
1028  02fa 7b01          	ld	a,(OFST+0,sp)
1029  02fc e707          	ld	(_rx_buf,x),a
1030  02fe               L303:
1031                     ; 188         Input_Status_Send();
1033  02fe cd012c        	call	_Input_Status_Send
1036  0301 ac7b027b      	jpf	L772
1090                     	xdef	_main
1091                     	xdef	_GPIO_Config
1092                     	xdef	_Input_Status_Send
1093                     	xdef	_Relay_Control
1094                     	xdef	_UART_SendString
1095                     	xdef	_UART_SendChar
1096                     	xdef	_UART_Config
1097                     	xdef	_delay_ms
1098                     	xdef	_prev_input_str
1099                     	switch	.ubsct
1100  0000               _input_str:
1101  0000 000000000000  	ds.b	7
1102                     	xdef	_input_str
1103                     	xdef	_index
1104  0007               _rx_buf:
1105  0007 000000000000  	ds.b	16
1106                     	xdef	_rx_buf
1107                     	xref	_UART1_GetFlagStatus
1108                     	xref	_UART1_SendData8
1109                     	xref	_UART1_ReceiveData8
1110                     	xref	_UART1_Cmd
1111                     	xref	_UART1_Init
1112                     	xref	_UART1_DeInit
1113                     	xref	_GPIO_ReadInputPin
1114                     	xref	_GPIO_WriteLow
1115                     	xref	_GPIO_WriteHigh
1116                     	xref	_GPIO_Init
1117                     	xref	_CLK_HSIPrescalerConfig
1118                     .const:	section	.text
1119  0000               L123:
1120  0000 204f4b0d      	dc.b	" OK",13
1121  0004 0a00          	dc.b	10,0
1122  0006               L713:
1123  0006 2c00          	dc.b	",",0
1124  0008               L513:
1125  0008 5200          	dc.b	"R",0
1126  000a               L572:
1127  000a 53595354454d  	dc.b	"SYSTEM START",13
1128  0017 0a00          	dc.b	10,0
1148                     	end
