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
  83                     ; 9 void delay_ms(uint16_t ms)
  83                     ; 10 {
  85                     	switch	.text
  86  0000               _delay_ms:
  88  0000 89            	pushw	x
  89  0001 5204          	subw	sp,#4
  90       00000004      OFST:	set	4
  93                     ; 13     for(i = 0; i < ms; i++)
  95  0003 5f            	clrw	x
  96  0004 1f01          	ldw	(OFST-3,sp),x
  99  0006 2019          	jra	L34
 100  0008               L73:
 101                     ; 15         for(j = 0; j < 4000; j++)
 103  0008 5f            	clrw	x
 104  0009 1f03          	ldw	(OFST-1,sp),x
 106  000b               L74:
 107                     ; 17             nop();
 110  000b 9d            nop
 112                     ; 15         for(j = 0; j < 4000; j++)
 115  000c 1e03          	ldw	x,(OFST-1,sp)
 116  000e 1c0001        	addw	x,#1
 117  0011 1f03          	ldw	(OFST-1,sp),x
 121  0013 1e03          	ldw	x,(OFST-1,sp)
 122  0015 a30fa0        	cpw	x,#4000
 123  0018 25f1          	jrult	L74
 124                     ; 13     for(i = 0; i < ms; i++)
 126  001a 1e01          	ldw	x,(OFST-3,sp)
 127  001c 1c0001        	addw	x,#1
 128  001f 1f01          	ldw	(OFST-3,sp),x
 130  0021               L34:
 133  0021 1e01          	ldw	x,(OFST-3,sp)
 134  0023 1305          	cpw	x,(OFST+1,sp)
 135  0025 25e1          	jrult	L73
 136                     ; 20 }
 139  0027 5b06          	addw	sp,#6
 140  0029 81            	ret
 167                     ; 22 void UART_Config(void)
 167                     ; 23 {
 168                     	switch	.text
 169  002a               _UART_Config:
 173                     ; 24     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 175  002a 4f            	clr	a
 176  002b cd0000        	call	_CLK_HSIPrescalerConfig
 178                     ; 26     UART1_DeInit();
 180  002e cd0000        	call	_UART1_DeInit
 182                     ; 28     UART1_Init(
 182                     ; 29         9600,
 182                     ; 30         UART1_WORDLENGTH_8D,
 182                     ; 31         UART1_STOPBITS_1,
 182                     ; 32         UART1_PARITY_NO,
 182                     ; 33         UART1_SYNCMODE_CLOCK_DISABLE,
 182                     ; 34         UART1_MODE_TXRX_ENABLE);
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
 196                     ; 36     UART1_Cmd(ENABLE);
 198  0048 a601          	ld	a,#1
 199  004a cd0000        	call	_UART1_Cmd
 201                     ; 37 }
 204  004d 81            	ret
 240                     ; 39 void UART_SendChar(uint8_t ch)
 240                     ; 40 {
 241                     	switch	.text
 242  004e               _UART_SendChar:
 246                     ; 41     UART1_SendData8(ch);
 248  004e cd0000        	call	_UART1_SendData8
 251  0051               L501:
 252                     ; 42     while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 254  0051 ae0080        	ldw	x,#128
 255  0054 cd0000        	call	_UART1_GetFlagStatus
 257  0057 4d            	tnz	a
 258  0058 27f7          	jreq	L501
 259                     ; 43 }
 262  005a 81            	ret
 298                     ; 45 void UART_SendString(char *str)
 298                     ; 46 {
 299                     	switch	.text
 300  005b               _UART_SendString:
 302  005b 89            	pushw	x
 303       00000000      OFST:	set	0
 306  005c 200d          	jra	L131
 307  005e               L721:
 308                     ; 49         UART_SendChar(*str++);
 310  005e 1e01          	ldw	x,(OFST+1,sp)
 311  0060 1c0001        	addw	x,#1
 312  0063 1f01          	ldw	(OFST+1,sp),x
 313  0065 1d0001        	subw	x,#1
 314  0068 f6            	ld	a,(x)
 315  0069 ade3          	call	_UART_SendChar
 317  006b               L131:
 318                     ; 47     while(*str)
 320  006b 1e01          	ldw	x,(OFST+1,sp)
 321  006d 7d            	tnz	(x)
 322  006e 26ee          	jrne	L721
 323                     ; 51 }
 326  0070 85            	popw	x
 327  0071 81            	ret
 372                     ; 52 void Relay_Control(uint8_t relay, uint8_t state)
 372                     ; 53 {
 373                     	switch	.text
 374  0072               _Relay_Control:
 376  0072 89            	pushw	x
 377       00000000      OFST:	set	0
 380                     ; 54     switch(relay)
 382  0073 9e            	ld	a,xh
 384                     ; 84             break;
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
 399                     ; 56         case 1:
 399                     ; 57             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_3);
 401  008d 0d02          	tnz	(OFST+2,sp)
 402  008f 270d          	jreq	L771
 405  0091 4b08          	push	#8
 406  0093 ae5005        	ldw	x,#20485
 407  0096 cd0000        	call	_GPIO_WriteHigh
 409  0099 84            	pop	a
 411  009a ac2a012a      	jpf	L571
 412  009e               L771:
 413                     ; 58             else      GPIO_WriteLow(GPIOB, GPIO_PIN_3);
 415  009e 4b08          	push	#8
 416  00a0 ae5005        	ldw	x,#20485
 417  00a3 cd0000        	call	_GPIO_WriteLow
 419  00a6 84            	pop	a
 420  00a7 cc012a        	jra	L571
 421  00aa               L731:
 422                     ; 61         case 2:
 422                     ; 62             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_2);
 424  00aa 0d02          	tnz	(OFST+2,sp)
 425  00ac 270b          	jreq	L302
 428  00ae 4b04          	push	#4
 429  00b0 ae5005        	ldw	x,#20485
 430  00b3 cd0000        	call	_GPIO_WriteHigh
 432  00b6 84            	pop	a
 434  00b7 2071          	jra	L571
 435  00b9               L302:
 436                     ; 63             else      GPIO_WriteLow(GPIOB, GPIO_PIN_2);
 438  00b9 4b04          	push	#4
 439  00bb ae5005        	ldw	x,#20485
 440  00be cd0000        	call	_GPIO_WriteLow
 442  00c1 84            	pop	a
 443  00c2 2066          	jra	L571
 444  00c4               L141:
 445                     ; 66         case 3:
 445                     ; 67             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_1);
 447  00c4 0d02          	tnz	(OFST+2,sp)
 448  00c6 270b          	jreq	L702
 451  00c8 4b02          	push	#2
 452  00ca ae5005        	ldw	x,#20485
 453  00cd cd0000        	call	_GPIO_WriteHigh
 455  00d0 84            	pop	a
 457  00d1 2057          	jra	L571
 458  00d3               L702:
 459                     ; 68             else      GPIO_WriteLow(GPIOB, GPIO_PIN_1);
 461  00d3 4b02          	push	#2
 462  00d5 ae5005        	ldw	x,#20485
 463  00d8 cd0000        	call	_GPIO_WriteLow
 465  00db 84            	pop	a
 466  00dc 204c          	jra	L571
 467  00de               L341:
 468                     ; 71         case 4:
 468                     ; 72             if(state) GPIO_WriteHigh(GPIOB, GPIO_PIN_0);
 470  00de 0d02          	tnz	(OFST+2,sp)
 471  00e0 270b          	jreq	L312
 474  00e2 4b01          	push	#1
 475  00e4 ae5005        	ldw	x,#20485
 476  00e7 cd0000        	call	_GPIO_WriteHigh
 478  00ea 84            	pop	a
 480  00eb 203d          	jra	L571
 481  00ed               L312:
 482                     ; 73             else      GPIO_WriteLow(GPIOB, GPIO_PIN_0);
 484  00ed 4b01          	push	#1
 485  00ef ae5005        	ldw	x,#20485
 486  00f2 cd0000        	call	_GPIO_WriteLow
 488  00f5 84            	pop	a
 489  00f6 2032          	jra	L571
 490  00f8               L541:
 491                     ; 76         case 5:
 491                     ; 77             if(state) GPIO_WriteHigh(GPIOC, GPIO_PIN_3);
 493  00f8 0d02          	tnz	(OFST+2,sp)
 494  00fa 270b          	jreq	L712
 497  00fc 4b08          	push	#8
 498  00fe ae500a        	ldw	x,#20490
 499  0101 cd0000        	call	_GPIO_WriteHigh
 501  0104 84            	pop	a
 503  0105 2023          	jra	L571
 504  0107               L712:
 505                     ; 78             else      GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 507  0107 4b08          	push	#8
 508  0109 ae500a        	ldw	x,#20490
 509  010c cd0000        	call	_GPIO_WriteLow
 511  010f 84            	pop	a
 512  0110 2018          	jra	L571
 513  0112               L741:
 514                     ; 81         case 6:
 514                     ; 82             if(state) GPIO_WriteHigh(GPIOC, GPIO_PIN_4);
 516  0112 0d02          	tnz	(OFST+2,sp)
 517  0114 270b          	jreq	L322
 520  0116 4b10          	push	#16
 521  0118 ae500a        	ldw	x,#20490
 522  011b cd0000        	call	_GPIO_WriteHigh
 524  011e 84            	pop	a
 526  011f 2009          	jra	L571
 527  0121               L322:
 528                     ; 83             else      GPIO_WriteLow(GPIOC, GPIO_PIN_4);
 530  0121 4b10          	push	#16
 531  0123 ae500a        	ldw	x,#20490
 532  0126 cd0000        	call	_GPIO_WriteLow
 534  0129 84            	pop	a
 535  012a               L571:
 536                     ; 86 }
 539  012a 85            	popw	x
 540  012b 81            	ret
 567                     ; 87 void Input_Status_Send(void)
 567                     ; 88 {
 568                     	switch	.text
 569  012c               _Input_Status_Send:
 573                     ; 89     input_str[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2) == RESET) ? '1' : '0';
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
 588                     ; 90     input_str[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3) == RESET) ? '1' : '0';
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
 603                     ; 91     input_str[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4) == RESET) ? '1' : '0';
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
 618                     ; 92     input_str[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7) == RESET) ? '1' : '0';
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
 633                     ; 94     input_str[4] = '\r';
 635  0180 350d0004      	mov	_input_str+4,#13
 636                     ; 95     input_str[5] = '\n';
 638  0184 350a0005      	mov	_input_str+5,#10
 639                     ; 96     input_str[6] = '\0';
 641  0188 3f06          	clr	_input_str+6
 642                     ; 98     if((input_str[0] != prev_input_str[0]) ||
 642                     ; 99        (input_str[1] != prev_input_str[1]) ||
 642                     ; 100        (input_str[2] != prev_input_str[2]) ||
 642                     ; 101        (input_str[3] != prev_input_str[3]))
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
 660                     ; 103         UART_SendString(input_str);
 662  01a2 ae0000        	ldw	x,#_input_str
 663  01a5 cd005b        	call	_UART_SendString
 665                     ; 105         prev_input_str[0] = input_str[0];
 667  01a8 450001        	mov	_prev_input_str,_input_str
 668                     ; 106         prev_input_str[1] = input_str[1];
 670  01ab 450102        	mov	_prev_input_str+1,_input_str+1
 671                     ; 107         prev_input_str[2] = input_str[2];
 673  01ae 450203        	mov	_prev_input_str+2,_input_str+2
 674                     ; 108         prev_input_str[3] = input_str[3];
 676  01b1 450304        	mov	_prev_input_str+3,_input_str+3
 677  01b4               L732:
 678                     ; 110 }
 681  01b4 81            	ret
 706                     ; 111 void GPIO_Config(void)
 706                     ; 112 {
 707                     	switch	.text
 708  01b5               _GPIO_Config:
 712                     ; 114     GPIO_Init(GPIOC, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST);
 714  01b5 4be0          	push	#224
 715  01b7 4b02          	push	#2
 716  01b9 ae500a        	ldw	x,#20490
 717  01bc cd0000        	call	_GPIO_Init
 719  01bf 85            	popw	x
 720                     ; 115     GPIO_WriteLow(GPIOC, GPIO_PIN_1);
 722  01c0 4b02          	push	#2
 723  01c2 ae500a        	ldw	x,#20490
 724  01c5 cd0000        	call	_GPIO_WriteLow
 726  01c8 84            	pop	a
 727                     ; 118     GPIO_Init(GPIOB, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // R1
 729  01c9 4be0          	push	#224
 730  01cb 4b08          	push	#8
 731  01cd ae5005        	ldw	x,#20485
 732  01d0 cd0000        	call	_GPIO_Init
 734  01d3 85            	popw	x
 735                     ; 119     GPIO_Init(GPIOB, GPIO_PIN_2, GPIO_MODE_OUT_PP_LOW_FAST); // R2
 737  01d4 4be0          	push	#224
 738  01d6 4b04          	push	#4
 739  01d8 ae5005        	ldw	x,#20485
 740  01db cd0000        	call	_GPIO_Init
 742  01de 85            	popw	x
 743                     ; 120     GPIO_Init(GPIOB, GPIO_PIN_1, GPIO_MODE_OUT_PP_LOW_FAST); // R3
 745  01df 4be0          	push	#224
 746  01e1 4b02          	push	#2
 747  01e3 ae5005        	ldw	x,#20485
 748  01e6 cd0000        	call	_GPIO_Init
 750  01e9 85            	popw	x
 751                     ; 121     GPIO_Init(GPIOB, GPIO_PIN_0, GPIO_MODE_OUT_PP_LOW_FAST); // R4
 753  01ea 4be0          	push	#224
 754  01ec 4b01          	push	#1
 755  01ee ae5005        	ldw	x,#20485
 756  01f1 cd0000        	call	_GPIO_Init
 758  01f4 85            	popw	x
 759                     ; 122     GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_OUT_PP_LOW_FAST); // R5
 761  01f5 4be0          	push	#224
 762  01f7 4b08          	push	#8
 763  01f9 ae500a        	ldw	x,#20490
 764  01fc cd0000        	call	_GPIO_Init
 766  01ff 85            	popw	x
 767                     ; 123     GPIO_Init(GPIOC, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // R6
 769  0200 4be0          	push	#224
 770  0202 4b10          	push	#16
 771  0204 ae500a        	ldw	x,#20490
 772  0207 cd0000        	call	_GPIO_Init
 774  020a 85            	popw	x
 775                     ; 126     GPIO_WriteLow(GPIOB, GPIO_PIN_3);
 777  020b 4b08          	push	#8
 778  020d ae5005        	ldw	x,#20485
 779  0210 cd0000        	call	_GPIO_WriteLow
 781  0213 84            	pop	a
 782                     ; 127     GPIO_WriteLow(GPIOB, GPIO_PIN_2);
 784  0214 4b04          	push	#4
 785  0216 ae5005        	ldw	x,#20485
 786  0219 cd0000        	call	_GPIO_WriteLow
 788  021c 84            	pop	a
 789                     ; 128     GPIO_WriteLow(GPIOB, GPIO_PIN_1);
 791  021d 4b02          	push	#2
 792  021f ae5005        	ldw	x,#20485
 793  0222 cd0000        	call	_GPIO_WriteLow
 795  0225 84            	pop	a
 796                     ; 129     GPIO_WriteLow(GPIOB, GPIO_PIN_0);
 798  0226 4b01          	push	#1
 799  0228 ae5005        	ldw	x,#20485
 800  022b cd0000        	call	_GPIO_WriteLow
 802  022e 84            	pop	a
 803                     ; 130     GPIO_WriteLow(GPIOC, GPIO_PIN_3);
 805  022f 4b08          	push	#8
 806  0231 ae500a        	ldw	x,#20490
 807  0234 cd0000        	call	_GPIO_WriteLow
 809  0237 84            	pop	a
 810                     ; 131     GPIO_WriteLow(GPIOC, GPIO_PIN_4);
 812  0238 4b10          	push	#16
 813  023a ae500a        	ldw	x,#20490
 814  023d cd0000        	call	_GPIO_WriteLow
 816  0240 84            	pop	a
 817                     ; 134     GPIO_Init(GPIOD, GPIO_PIN_2, GPIO_MODE_IN_PU_NO_IT); // DI1
 819  0241 4b40          	push	#64
 820  0243 4b04          	push	#4
 821  0245 ae500f        	ldw	x,#20495
 822  0248 cd0000        	call	_GPIO_Init
 824  024b 85            	popw	x
 825                     ; 135     GPIO_Init(GPIOD, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // DI2
 827  024c 4b40          	push	#64
 828  024e 4b08          	push	#8
 829  0250 ae500f        	ldw	x,#20495
 830  0253 cd0000        	call	_GPIO_Init
 832  0256 85            	popw	x
 833                     ; 136     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_IN_PU_NO_IT); // DI3
 835  0257 4b40          	push	#64
 836  0259 4b10          	push	#16
 837  025b ae500f        	ldw	x,#20495
 838  025e cd0000        	call	_GPIO_Init
 840  0261 85            	popw	x
 841                     ; 137     GPIO_Init(GPIOD, GPIO_PIN_7, GPIO_MODE_IN_PU_NO_IT); // DI4
 843  0262 4b40          	push	#64
 844  0264 4b80          	push	#128
 845  0266 ae500f        	ldw	x,#20495
 846  0269 cd0000        	call	_GPIO_Init
 848  026c 85            	popw	x
 849                     ; 138 }
 852  026d 81            	ret
 908                     ; 139 void main(void)
 908                     ; 140 {
 909                     	switch	.text
 910  026e               _main:
 912  026e 88            	push	a
 913       00000001      OFST:	set	1
 916                     ; 144     UART_Config();
 918  026f cd002a        	call	_UART_Config
 920                     ; 145     GPIO_Config();
 922  0272 cd01b5        	call	_GPIO_Config
 924                     ; 147     UART_SendString("SYSTEM START\r\n");
 926  0275 ae0027        	ldw	x,#L103
 927  0278 cd005b        	call	_UART_SendString
 929  027b               L303:
 930                     ; 152         if(UART1_GetFlagStatus(UART1_FLAG_RXNE) != RESET)
 932  027b ae0020        	ldw	x,#32
 933  027e cd0000        	call	_UART1_GetFlagStatus
 935  0281 4d            	tnz	a
 936  0282 2603          	jrne	L46
 937  0284 cc03a6        	jp	L703
 938  0287               L46:
 939                     ; 154             ch = UART1_ReceiveData8();
 941  0287 cd0000        	call	_UART1_ReceiveData8
 943  028a 6b01          	ld	(OFST+0,sp),a
 945                     ; 156             if((ch == '\r') || (ch == '\n'))
 947  028c 7b01          	ld	a,(OFST+0,sp)
 948  028e a10d          	cp	a,#13
 949  0290 2709          	jreq	L313
 951  0292 7b01          	ld	a,(OFST+0,sp)
 952  0294 a10a          	cp	a,#10
 953  0296 2703          	jreq	L66
 954  0298 cc0390        	jp	L113
 955  029b               L66:
 956  029b               L313:
 957                     ; 158                 rx_buf[index] = '\0';
 959  029b b600          	ld	a,_index
 960  029d 5f            	clrw	x
 961  029e 97            	ld	xl,a
 962  029f 6f07          	clr	(_rx_buf,x)
 963                     ; 161                 if((rx_buf[0]=='S') &&
 963                     ; 162                    (rx_buf[1]=='T') &&
 963                     ; 163                    (rx_buf[2]=='R') &&
 963                     ; 164                    (rx_buf[3]=='\0'))
 965  02a1 b607          	ld	a,_rx_buf
 966  02a3 a153          	cp	a,#83
 967  02a5 2703          	jreq	L07
 968  02a7 cc033f        	jp	L513
 969  02aa               L07:
 971  02aa b608          	ld	a,_rx_buf+1
 972  02ac a154          	cp	a,#84
 973  02ae 2703          	jreq	L27
 974  02b0 cc033f        	jp	L513
 975  02b3               L27:
 977  02b3 b609          	ld	a,_rx_buf+2
 978  02b5 a152          	cp	a,#82
 979  02b7 26f7          	jrne	L513
 981  02b9 3d0a          	tnz	_rx_buf+3
 982  02bb 26f3          	jrne	L513
 983                     ; 166                     UART_SendString("STREAM START\r\n");
 985  02bd ae0018        	ldw	x,#L713
 986  02c0 cd005b        	call	_UART_SendString
 988                     ; 168                     for(i=0;i<60;i++)      /* 60 x 50 ms = 3 sec */
 990  02c3 0f01          	clr	(OFST+0,sp)
 992  02c5               L123:
 993                     ; 170                         input_str[0] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_2)==RESET) ? '1' : '0';
 995  02c5 4b04          	push	#4
 996  02c7 ae500f        	ldw	x,#20495
 997  02ca cd0000        	call	_GPIO_ReadInputPin
 999  02cd 5b01          	addw	sp,#1
1000  02cf 4d            	tnz	a
1001  02d0 2604          	jrne	L44
1002  02d2 a631          	ld	a,#49
1003  02d4 2002          	jra	L64
1004  02d6               L44:
1005  02d6 a630          	ld	a,#48
1006  02d8               L64:
1007  02d8 b700          	ld	_input_str,a
1008                     ; 171                         input_str[1] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_3)==RESET) ? '1' : '0';
1010  02da 4b08          	push	#8
1011  02dc ae500f        	ldw	x,#20495
1012  02df cd0000        	call	_GPIO_ReadInputPin
1014  02e2 5b01          	addw	sp,#1
1015  02e4 4d            	tnz	a
1016  02e5 2604          	jrne	L05
1017  02e7 a631          	ld	a,#49
1018  02e9 2002          	jra	L25
1019  02eb               L05:
1020  02eb a630          	ld	a,#48
1021  02ed               L25:
1022  02ed b701          	ld	_input_str+1,a
1023                     ; 172                         input_str[2] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_4)==RESET) ? '1' : '0';
1025  02ef 4b10          	push	#16
1026  02f1 ae500f        	ldw	x,#20495
1027  02f4 cd0000        	call	_GPIO_ReadInputPin
1029  02f7 5b01          	addw	sp,#1
1030  02f9 4d            	tnz	a
1031  02fa 2604          	jrne	L45
1032  02fc a631          	ld	a,#49
1033  02fe 2002          	jra	L65
1034  0300               L45:
1035  0300 a630          	ld	a,#48
1036  0302               L65:
1037  0302 b702          	ld	_input_str+2,a
1038                     ; 173                         input_str[3] = (GPIO_ReadInputPin(GPIOD, GPIO_PIN_7)==RESET) ? '1' : '0';
1040  0304 4b80          	push	#128
1041  0306 ae500f        	ldw	x,#20495
1042  0309 cd0000        	call	_GPIO_ReadInputPin
1044  030c 5b01          	addw	sp,#1
1045  030e 4d            	tnz	a
1046  030f 2604          	jrne	L06
1047  0311 a631          	ld	a,#49
1048  0313 2002          	jra	L26
1049  0315               L06:
1050  0315 a630          	ld	a,#48
1051  0317               L26:
1052  0317 b703          	ld	_input_str+3,a
1053                     ; 174                         input_str[4] = '\r';
1055  0319 350d0004      	mov	_input_str+4,#13
1056                     ; 175                         input_str[5] = '\n';
1058  031d 350a0005      	mov	_input_str+5,#10
1059                     ; 176                         input_str[6] = '\0';
1061  0321 3f06          	clr	_input_str+6
1062                     ; 178                         UART_SendString(input_str);
1064  0323 ae0000        	ldw	x,#_input_str
1065  0326 cd005b        	call	_UART_SendString
1067                     ; 180                         delay_ms(50);
1069  0329 ae0032        	ldw	x,#50
1070  032c cd0000        	call	_delay_ms
1072                     ; 168                     for(i=0;i<60;i++)      /* 60 x 50 ms = 3 sec */
1074  032f 0c01          	inc	(OFST+0,sp)
1078  0331 7b01          	ld	a,(OFST+0,sp)
1079  0333 a13c          	cp	a,#60
1080  0335 258e          	jrult	L123
1081                     ; 183                     UART_SendString("STREAM STOP\r\n");
1083  0337 ae000a        	ldw	x,#L723
1084  033a cd005b        	call	_UART_SendString
1087  033d 204d          	jra	L133
1088  033f               L513:
1089                     ; 187                 else if((rx_buf[0] == 'R') &&
1089                     ; 188                         (rx_buf[1] >= '1') &&
1089                     ; 189                         (rx_buf[1] <= '6') &&
1089                     ; 190                         (rx_buf[2] == ',') &&
1089                     ; 191                         ((rx_buf[3] == '0') || (rx_buf[3] == '1')))
1091  033f b607          	ld	a,_rx_buf
1092  0341 a152          	cp	a,#82
1093  0343 2647          	jrne	L133
1095  0345 b608          	ld	a,_rx_buf+1
1096  0347 a131          	cp	a,#49
1097  0349 2541          	jrult	L133
1099  034b b608          	ld	a,_rx_buf+1
1100  034d a137          	cp	a,#55
1101  034f 243b          	jruge	L133
1103  0351 b609          	ld	a,_rx_buf+2
1104  0353 a12c          	cp	a,#44
1105  0355 2635          	jrne	L133
1107  0357 b60a          	ld	a,_rx_buf+3
1108  0359 a130          	cp	a,#48
1109  035b 2706          	jreq	L533
1111  035d b60a          	ld	a,_rx_buf+3
1112  035f a131          	cp	a,#49
1113  0361 2629          	jrne	L133
1114  0363               L533:
1115                     ; 193                     Relay_Control(rx_buf[1]-'0',
1115                     ; 194                                   rx_buf[3]-'0');
1117  0363 b60a          	ld	a,_rx_buf+3
1118  0365 a030          	sub	a,#48
1119  0367 97            	ld	xl,a
1120  0368 b608          	ld	a,_rx_buf+1
1121  036a a030          	sub	a,#48
1122  036c 95            	ld	xh,a
1123  036d cd0072        	call	_Relay_Control
1125                     ; 196                     UART_SendString("R");
1127  0370 ae0008        	ldw	x,#L733
1128  0373 cd005b        	call	_UART_SendString
1130                     ; 197                     UART_SendChar(rx_buf[1]);
1132  0376 b608          	ld	a,_rx_buf+1
1133  0378 cd004e        	call	_UART_SendChar
1135                     ; 198                     UART_SendString(",");
1137  037b ae0006        	ldw	x,#L143
1138  037e cd005b        	call	_UART_SendString
1140                     ; 199                     UART_SendChar(rx_buf[3]);
1142  0381 b60a          	ld	a,_rx_buf+3
1143  0383 cd004e        	call	_UART_SendChar
1145                     ; 200                     UART_SendString(" OK\r\n");
1147  0386 ae0000        	ldw	x,#L343
1148  0389 cd005b        	call	_UART_SendString
1150  038c               L133:
1151                     ; 203                 index = 0;
1153  038c 3f00          	clr	_index
1155  038e 2016          	jra	L703
1156  0390               L113:
1157                     ; 207                 if(index < sizeof(rx_buf)-1)
1159  0390 b600          	ld	a,_index
1160  0392 a10f          	cp	a,#15
1161  0394 240e          	jruge	L743
1162                     ; 209                     rx_buf[index++] = ch;
1164  0396 b600          	ld	a,_index
1165  0398 97            	ld	xl,a
1166  0399 3c00          	inc	_index
1167  039b 9f            	ld	a,xl
1168  039c 5f            	clrw	x
1169  039d 97            	ld	xl,a
1170  039e 7b01          	ld	a,(OFST+0,sp)
1171  03a0 e707          	ld	(_rx_buf,x),a
1173  03a2 2002          	jra	L703
1174  03a4               L743:
1175                     ; 213                     index = 0;
1177  03a4 3f00          	clr	_index
1178  03a6               L703:
1179                     ; 219         Input_Status_Send();
1181  03a6 cd012c        	call	_Input_Status_Send
1184  03a9 ac7b027b      	jpf	L303
1238                     	xdef	_main
1239                     	xdef	_GPIO_Config
1240                     	xdef	_Input_Status_Send
1241                     	xdef	_Relay_Control
1242                     	xdef	_UART_SendString
1243                     	xdef	_UART_SendChar
1244                     	xdef	_UART_Config
1245                     	xdef	_delay_ms
1246                     	xdef	_prev_input_str
1247                     	switch	.ubsct
1248  0000               _input_str:
1249  0000 000000000000  	ds.b	7
1250                     	xdef	_input_str
1251                     	xdef	_index
1252  0007               _rx_buf:
1253  0007 000000000000  	ds.b	16
1254                     	xdef	_rx_buf
1255                     	xref	_UART1_GetFlagStatus
1256                     	xref	_UART1_SendData8
1257                     	xref	_UART1_ReceiveData8
1258                     	xref	_UART1_Cmd
1259                     	xref	_UART1_Init
1260                     	xref	_UART1_DeInit
1261                     	xref	_GPIO_ReadInputPin
1262                     	xref	_GPIO_WriteLow
1263                     	xref	_GPIO_WriteHigh
1264                     	xref	_GPIO_Init
1265                     	xref	_CLK_HSIPrescalerConfig
1266                     .const:	section	.text
1267  0000               L343:
1268  0000 204f4b0d      	dc.b	" OK",13
1269  0004 0a00          	dc.b	10,0
1270  0006               L143:
1271  0006 2c00          	dc.b	",",0
1272  0008               L733:
1273  0008 5200          	dc.b	"R",0
1274  000a               L723:
1275  000a 53545245414d  	dc.b	"STREAM STOP",13
1276  0016 0a00          	dc.b	10,0
1277  0018               L713:
1278  0018 53545245414d  	dc.b	"STREAM START",13
1279  0025 0a00          	dc.b	10,0
1280  0027               L103:
1281  0027 53595354454d  	dc.b	"SYSTEM START",13
1282  0034 0a00          	dc.b	10,0
1302                     	end
