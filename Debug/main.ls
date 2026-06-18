   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.6 - 07 Jan 2026
  14                     	bsct
  15  0000               L3_current_state:
  16  0000 00            	dc.b	0
  17  0001 00            	dc.b	0
  18  0002 00            	dc.b	0
  19  0003 00            	dc.b	0
  78                     ; 13 void delay_ms(uint16_t ms)
  78                     ; 14 {
  80                     	switch	.text
  81  0000               _delay_ms:
  83  0000 89            	pushw	x
  84  0001 5204          	subw	sp,#4
  85       00000004      OFST:	set	4
  88                     ; 17     for(i=0;i<ms;i++)
  90  0003 5f            	clrw	x
  91  0004 1f01          	ldw	(OFST-3,sp),x
  94  0006 2019          	jra	L54
  95  0008               L14:
  96                     ; 19         for(j=0;j<1600;j++)
  98  0008 5f            	clrw	x
  99  0009 1f03          	ldw	(OFST-1,sp),x
 101  000b               L15:
 102                     ; 21             nop();
 105  000b 9d            nop
 107                     ; 19         for(j=0;j<1600;j++)
 110  000c 1e03          	ldw	x,(OFST-1,sp)
 111  000e 1c0001        	addw	x,#1
 112  0011 1f03          	ldw	(OFST-1,sp),x
 116  0013 1e03          	ldw	x,(OFST-1,sp)
 117  0015 a30640        	cpw	x,#1600
 118  0018 25f1          	jrult	L15
 119                     ; 17     for(i=0;i<ms;i++)
 121  001a 1e01          	ldw	x,(OFST-3,sp)
 122  001c 1c0001        	addw	x,#1
 123  001f 1f01          	ldw	(OFST-3,sp),x
 125  0021               L54:
 128  0021 1e01          	ldw	x,(OFST-3,sp)
 129  0023 1305          	cpw	x,(OFST+1,sp)
 130  0025 25e1          	jrult	L14
 131                     ; 24 }
 134  0027 5b06          	addw	sp,#6
 135  0029 81            	ret
 327                     ; 26 uint8_t hal_di_read(uint8_t di_num)
 327                     ; 27 {
 328                     	switch	.text
 329  002a               _hal_di_read:
 331  002a 5203          	subw	sp,#3
 332       00000003      OFST:	set	3
 335                     ; 31     switch (di_num) {
 338                     ; 36         default: return 0;
 339  002c 4a            	dec	a
 340  002d 270c          	jreq	L75
 341  002f 4a            	dec	a
 342  0030 2714          	jreq	L16
 343  0032 4a            	dec	a
 344  0033 271c          	jreq	L36
 345  0035 4a            	dec	a
 346  0036 2724          	jreq	L56
 347  0038               L76:
 350  0038 4f            	clr	a
 352  0039 203d          	jra	L41
 353  003b               L75:
 354                     ; 32         case 1: port = DI1_PORT; pin = DI1_PIN; break;
 356  003b ae500f        	ldw	x,#20495
 357  003e 1f01          	ldw	(OFST-2,sp),x
 361  0040 a604          	ld	a,#4
 362  0042 6b03          	ld	(OFST+0,sp),a
 366  0044 201f          	jra	L502
 367  0046               L16:
 368                     ; 33         case 2: port = DI2_PORT; pin = DI2_PIN; break;
 370  0046 ae500f        	ldw	x,#20495
 371  0049 1f01          	ldw	(OFST-2,sp),x
 375  004b a608          	ld	a,#8
 376  004d 6b03          	ld	(OFST+0,sp),a
 380  004f 2014          	jra	L502
 381  0051               L36:
 382                     ; 34         case 3: port = DI3_PORT; pin = DI3_PIN; break;
 384  0051 ae500f        	ldw	x,#20495
 385  0054 1f01          	ldw	(OFST-2,sp),x
 389  0056 a610          	ld	a,#16
 390  0058 6b03          	ld	(OFST+0,sp),a
 394  005a 2009          	jra	L502
 395  005c               L56:
 396                     ; 35         case 4: port = DI4_PORT; pin = DI4_PIN; break;
 398  005c ae500f        	ldw	x,#20495
 399  005f 1f01          	ldw	(OFST-2,sp),x
 403  0061 a680          	ld	a,#128
 404  0063 6b03          	ld	(OFST+0,sp),a
 408  0065               L502:
 409                     ; 38     return (GPIO_ReadInputPin(port, pin) == SET) ? 0 : 1;
 411  0065 7b03          	ld	a,(OFST+0,sp)
 412  0067 88            	push	a
 413  0068 1e02          	ldw	x,(OFST-1,sp)
 414  006a cd0000        	call	_GPIO_ReadInputPin
 416  006d 5b01          	addw	sp,#1
 417  006f a101          	cp	a,#1
 418  0071 2603          	jrne	L01
 419  0073 4f            	clr	a
 420  0074 2002          	jra	L21
 421  0076               L01:
 422  0076 a601          	ld	a,#1
 423  0078               L21:
 425  0078               L41:
 427  0078 5b03          	addw	sp,#3
 428  007a 81            	ret
 495                     ; 40 void hal_relay_set(uint8_t relay_num, uint8_t state)
 495                     ; 41 {
 496                     	switch	.text
 497  007b               _hal_relay_set:
 499  007b 89            	pushw	x
 500  007c 5203          	subw	sp,#3
 501       00000003      OFST:	set	3
 504                     ; 45     switch(relay_num)
 506  007e 9e            	ld	a,xh
 508                     ; 53         default: return;
 509  007f 4a            	dec	a
 510  0080 2711          	jreq	L702
 511  0082 4a            	dec	a
 512  0083 2719          	jreq	L112
 513  0085 4a            	dec	a
 514  0086 2721          	jreq	L312
 515  0088 4a            	dec	a
 516  0089 2729          	jreq	L512
 517  008b 4a            	dec	a
 518  008c 2731          	jreq	L712
 519  008e 4a            	dec	a
 520  008f 2739          	jreq	L122
 521  0091               L322:
 524  0091 2058          	jra	L02
 525  0093               L702:
 526                     ; 47         case 1: port = RELAY1_PORT; pin = RELAY1_PIN; break;
 528  0093 ae5005        	ldw	x,#20485
 529  0096 1f01          	ldw	(OFST-2,sp),x
 533  0098 a608          	ld	a,#8
 534  009a 6b03          	ld	(OFST+0,sp),a
 538  009c 2035          	jra	L362
 539  009e               L112:
 540                     ; 48         case 2: port = RELAY2_PORT; pin = RELAY2_PIN; break;
 542  009e ae5005        	ldw	x,#20485
 543  00a1 1f01          	ldw	(OFST-2,sp),x
 547  00a3 a604          	ld	a,#4
 548  00a5 6b03          	ld	(OFST+0,sp),a
 552  00a7 202a          	jra	L362
 553  00a9               L312:
 554                     ; 49         case 3: port = RELAY3_PORT; pin = RELAY3_PIN; break;
 556  00a9 ae5005        	ldw	x,#20485
 557  00ac 1f01          	ldw	(OFST-2,sp),x
 561  00ae a602          	ld	a,#2
 562  00b0 6b03          	ld	(OFST+0,sp),a
 566  00b2 201f          	jra	L362
 567  00b4               L512:
 568                     ; 50         case 4: port = RELAY4_PORT; pin = RELAY4_PIN; break;
 570  00b4 ae5005        	ldw	x,#20485
 571  00b7 1f01          	ldw	(OFST-2,sp),x
 575  00b9 a601          	ld	a,#1
 576  00bb 6b03          	ld	(OFST+0,sp),a
 580  00bd 2014          	jra	L362
 581  00bf               L712:
 582                     ; 51         case 5: port = RELAY5_PORT; pin = RELAY5_PIN; break;
 584  00bf ae500a        	ldw	x,#20490
 585  00c2 1f01          	ldw	(OFST-2,sp),x
 589  00c4 a608          	ld	a,#8
 590  00c6 6b03          	ld	(OFST+0,sp),a
 594  00c8 2009          	jra	L362
 595  00ca               L122:
 596                     ; 52         case 6: port = RELAY6_PORT; pin = RELAY6_PIN; break;
 598  00ca ae500a        	ldw	x,#20490
 599  00cd 1f01          	ldw	(OFST-2,sp),x
 603  00cf a610          	ld	a,#16
 604  00d1 6b03          	ld	(OFST+0,sp),a
 608  00d3               L362:
 609                     ; 56     if(state)          // 1 = ON
 611  00d3 0d05          	tnz	(OFST+2,sp)
 612  00d5 270b          	jreq	L562
 613                     ; 57         GPIO_WriteLow(port, pin);
 615  00d7 7b03          	ld	a,(OFST+0,sp)
 616  00d9 88            	push	a
 617  00da 1e02          	ldw	x,(OFST-1,sp)
 618  00dc cd0000        	call	_GPIO_WriteLow
 620  00df 84            	pop	a
 622  00e0 2009          	jra	L762
 623  00e2               L562:
 624                     ; 59         GPIO_WriteHigh(port, pin);
 626  00e2 7b03          	ld	a,(OFST+0,sp)
 627  00e4 88            	push	a
 628  00e5 1e02          	ldw	x,(OFST-1,sp)
 629  00e7 cd0000        	call	_GPIO_WriteHigh
 631  00ea 84            	pop	a
 632  00eb               L762:
 633                     ; 60 }
 634  00eb               L02:
 637  00eb 5b05          	addw	sp,#5
 638  00ed 81            	ret
 664                     ; 61 void sensor_reader_update(void){
 665                     	switch	.text
 666  00ee               _sensor_reader_update:
 670                     ; 62     current_state.di1 = hal_di_read(1);
 672  00ee a601          	ld	a,#1
 673  00f0 cd002a        	call	_hal_di_read
 675  00f3 b700          	ld	L3_current_state,a
 676                     ; 63     current_state.di2 = hal_di_read(2);
 678  00f5 a602          	ld	a,#2
 679  00f7 cd002a        	call	_hal_di_read
 681  00fa b701          	ld	L3_current_state+1,a
 682                     ; 64     current_state.di3 = hal_di_read(3);
 684  00fc a603          	ld	a,#3
 685  00fe cd002a        	call	_hal_di_read
 687  0101 b702          	ld	L3_current_state+2,a
 688                     ; 65     current_state.di4 = hal_di_read(4);
 690  0103 a604          	ld	a,#4
 691  0105 cd002a        	call	_hal_di_read
 693  0108 b703          	ld	L3_current_state+3,a
 694                     ; 66 }
 697  010a 81            	ret
 721                     ; 67 void relay_off(void){
 722                     	switch	.text
 723  010b               _relay_off:
 727                     ; 68     hal_relay_set(1,1);
 729  010b ae0101        	ldw	x,#257
 730  010e cd007b        	call	_hal_relay_set
 732                     ; 69     hal_relay_set(2,1);
 734  0111 ae0201        	ldw	x,#513
 735  0114 cd007b        	call	_hal_relay_set
 737                     ; 70     hal_relay_set(3,1);
 739  0117 ae0301        	ldw	x,#769
 740  011a cd007b        	call	_hal_relay_set
 742                     ; 71     hal_relay_set(4,1);
 744  011d ae0401        	ldw	x,#1025
 745  0120 cd007b        	call	_hal_relay_set
 747                     ; 72     hal_relay_set(5,1);
 749  0123 ae0501        	ldw	x,#1281
 750  0126 cd007b        	call	_hal_relay_set
 752                     ; 73     hal_relay_set(6,1);
 754  0129 ae0601        	ldw	x,#1537
 755  012c cd007b        	call	_hal_relay_set
 757                     ; 74 }
 760  012f 81            	ret
 784                     ; 75 void sensor_reader_init(void)
 784                     ; 76 {
 785                     	switch	.text
 786  0130               _sensor_reader_init:
 790                     ; 78     sensor_reader_update();
 792  0130 adbc          	call	_sensor_reader_update
 794                     ; 79 }
 797  0132 81            	ret
 824                     ; 81 void UART_Config(void)
 824                     ; 82 {
 825                     	switch	.text
 826  0133               _UART_Config:
 830                     ; 83     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 832  0133 4f            	clr	a
 833  0134 cd0000        	call	_CLK_HSIPrescalerConfig
 835                     ; 85     UART1_DeInit();
 837  0137 cd0000        	call	_UART1_DeInit
 839                     ; 87     UART1_Init(9600,
 839                     ; 88                UART1_WORDLENGTH_8D,
 839                     ; 89                UART1_STOPBITS_1,
 839                     ; 90                UART1_PARITY_NO,
 839                     ; 91                UART1_SYNCMODE_CLOCK_DISABLE,
 839                     ; 92                UART1_MODE_TXRX_ENABLE);
 841  013a 4b0c          	push	#12
 842  013c 4b80          	push	#128
 843  013e 4b00          	push	#0
 844  0140 4b00          	push	#0
 845  0142 4b00          	push	#0
 846  0144 ae2580        	ldw	x,#9600
 847  0147 89            	pushw	x
 848  0148 ae0000        	ldw	x,#0
 849  014b 89            	pushw	x
 850  014c cd0000        	call	_UART1_Init
 852  014f 5b09          	addw	sp,#9
 853                     ; 94     UART1_Cmd(ENABLE);
 855  0151 a601          	ld	a,#1
 856  0153 cd0000        	call	_UART1_Cmd
 858                     ; 95 }
 861  0156 81            	ret
 897                     ; 97 void UART_SendChar(uint8_t c)
 897                     ; 98 {
 898                     	switch	.text
 899  0157               _UART_SendChar:
 903                     ; 99     UART1_SendData8(c);
 905  0157 cd0000        	call	_UART1_SendData8
 908  015a               L153:
 909                     ; 100     while(UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 911  015a ae0080        	ldw	x,#128
 912  015d cd0000        	call	_UART1_GetFlagStatus
 914  0160 4d            	tnz	a
 915  0161 27f7          	jreq	L153
 916                     ; 101 }
 919  0163 81            	ret
 955                     ; 103 void UART_SendString(char *s)
 955                     ; 104 {
 956                     	switch	.text
 957  0164               _UART_SendString:
 959  0164 89            	pushw	x
 960       00000000      OFST:	set	0
 963  0165 200d          	jra	L573
 964  0167               L373:
 965                     ; 106         UART_SendChar(*s++);
 967  0167 1e01          	ldw	x,(OFST+1,sp)
 968  0169 1c0001        	addw	x,#1
 969  016c 1f01          	ldw	(OFST+1,sp),x
 970  016e 1d0001        	subw	x,#1
 971  0171 f6            	ld	a,(x)
 972  0172 ade3          	call	_UART_SendChar
 974  0174               L573:
 975                     ; 105     while(*s)
 977  0174 1e01          	ldw	x,(OFST+1,sp)
 978  0176 7d            	tnz	(x)
 979  0177 26ee          	jrne	L373
 980                     ; 107 }
 983  0179 85            	popw	x
 984  017a 81            	ret
1010                     ; 109 void hal_gpio_init(void)
1010                     ; 110 {
1011                     	switch	.text
1012  017b               _hal_gpio_init:
1016                     ; 112     GPIO_Init(DI1_PORT, DI1_PIN, GPIO_MODE_IN_PU_NO_IT);
1018  017b 4b40          	push	#64
1019  017d 4b04          	push	#4
1020  017f ae500f        	ldw	x,#20495
1021  0182 cd0000        	call	_GPIO_Init
1023  0185 85            	popw	x
1024                     ; 113     GPIO_Init(DI2_PORT, DI2_PIN, GPIO_MODE_IN_PU_NO_IT);
1026  0186 4b40          	push	#64
1027  0188 4b08          	push	#8
1028  018a ae500f        	ldw	x,#20495
1029  018d cd0000        	call	_GPIO_Init
1031  0190 85            	popw	x
1032                     ; 114     GPIO_Init(DI3_PORT, DI3_PIN, GPIO_MODE_IN_PU_NO_IT);
1034  0191 4b40          	push	#64
1035  0193 4b10          	push	#16
1036  0195 ae500f        	ldw	x,#20495
1037  0198 cd0000        	call	_GPIO_Init
1039  019b 85            	popw	x
1040                     ; 115     GPIO_Init(DI4_PORT, DI4_PIN, GPIO_MODE_IN_PU_NO_IT);
1042  019c 4b40          	push	#64
1043  019e 4b80          	push	#128
1044  01a0 ae500f        	ldw	x,#20495
1045  01a3 cd0000        	call	_GPIO_Init
1047  01a6 85            	popw	x
1048                     ; 117     GPIO_Init(RELAY1_PORT, RELAY1_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
1050  01a7 4bf0          	push	#240
1051  01a9 4b08          	push	#8
1052  01ab ae5005        	ldw	x,#20485
1053  01ae cd0000        	call	_GPIO_Init
1055  01b1 85            	popw	x
1056                     ; 118     GPIO_Init(RELAY2_PORT, RELAY2_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
1058  01b2 4bf0          	push	#240
1059  01b4 4b04          	push	#4
1060  01b6 ae5005        	ldw	x,#20485
1061  01b9 cd0000        	call	_GPIO_Init
1063  01bc 85            	popw	x
1064                     ; 119     GPIO_Init(RELAY3_PORT, RELAY3_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
1066  01bd 4bf0          	push	#240
1067  01bf 4b02          	push	#2
1068  01c1 ae5005        	ldw	x,#20485
1069  01c4 cd0000        	call	_GPIO_Init
1071  01c7 85            	popw	x
1072                     ; 120     GPIO_Init(RELAY4_PORT, RELAY4_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
1074  01c8 4bf0          	push	#240
1075  01ca 4b01          	push	#1
1076  01cc ae5005        	ldw	x,#20485
1077  01cf cd0000        	call	_GPIO_Init
1079  01d2 85            	popw	x
1080                     ; 121     GPIO_Init(RELAY5_PORT, RELAY5_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
1082  01d3 4bf0          	push	#240
1083  01d5 4b08          	push	#8
1084  01d7 ae500a        	ldw	x,#20490
1085  01da cd0000        	call	_GPIO_Init
1087  01dd 85            	popw	x
1088                     ; 122     GPIO_Init(RELAY6_PORT, RELAY6_PIN, GPIO_MODE_OUT_PP_HIGH_FAST);
1090  01de 4bf0          	push	#240
1091  01e0 4b10          	push	#16
1092  01e2 ae500a        	ldw	x,#20490
1093  01e5 cd0000        	call	_GPIO_Init
1095  01e8 85            	popw	x
1096                     ; 125     hal_relay_set(1,0);
1098  01e9 ae0100        	ldw	x,#256
1099  01ec cd007b        	call	_hal_relay_set
1101                     ; 126     hal_relay_set(2,0);
1103  01ef ae0200        	ldw	x,#512
1104  01f2 cd007b        	call	_hal_relay_set
1106                     ; 127     hal_relay_set(3,0);
1108  01f5 ae0300        	ldw	x,#768
1109  01f8 cd007b        	call	_hal_relay_set
1111                     ; 128     hal_relay_set(4,0);
1113  01fb ae0400        	ldw	x,#1024
1114  01fe cd007b        	call	_hal_relay_set
1116                     ; 129     hal_relay_set(5,0);
1118  0201 ae0500        	ldw	x,#1280
1119  0204 cd007b        	call	_hal_relay_set
1121                     ; 130     hal_relay_set(6,0);
1123  0207 ae0600        	ldw	x,#1536
1124  020a cd007b        	call	_hal_relay_set
1126                     ; 131     delay_ms(3000);
1128  020d ae0bb8        	ldw	x,#3000
1129  0210 cd0000        	call	_delay_ms
1131                     ; 132     GPIO_Init(HARDRST_PORT, HARDRST_PIN, GPIO_MODE_IN_PU_NO_IT);
1133  0213 4b40          	push	#64
1134  0215 4b80          	push	#128
1135  0217 ae5005        	ldw	x,#20485
1136  021a cd0000        	call	_GPIO_Init
1138  021d 85            	popw	x
1139                     ; 133 }
1142  021e 81            	ret
1167                     ; 134 uint8_t UART_ReadChar(void)
1167                     ; 135 {
1168                     	switch	.text
1169  021f               _UART_ReadChar:
1173  021f               L324:
1174                     ; 136     while(UART1_GetFlagStatus(UART1_FLAG_RXNE) == RESET);
1176  021f ae0020        	ldw	x,#32
1177  0222 cd0000        	call	_UART1_GetFlagStatus
1179  0225 4d            	tnz	a
1180  0226 27f7          	jreq	L324
1181                     ; 137     return UART1_ReceiveData8();
1183  0228 cd0000        	call	_UART1_ReceiveData8
1187  022b 81            	ret
1243                     ; 139 void process_command(char *cmd)
1243                     ; 140 {
1244                     	switch	.text
1245  022c               _process_command:
1247  022c 89            	pushw	x
1248  022d 89            	pushw	x
1249       00000002      OFST:	set	2
1252                     ; 144     if(cmd[0] == 'R' &&
1252                     ; 145        cmd[1] >= '1' &&
1252                     ; 146        cmd[1] <= '6' &&
1252                     ; 147        cmd[2] == ',' &&
1252                     ; 148        (cmd[3] == '0' || cmd[3] == '1') &&
1252                     ; 149        cmd[4] == '\0')
1254  022e f6            	ld	a,(x)
1255  022f a152          	cp	a,#82
1256  0231 265f          	jrne	L554
1258  0233 e601          	ld	a,(1,x)
1259  0235 a131          	cp	a,#49
1260  0237 2559          	jrult	L554
1262  0239 e601          	ld	a,(1,x)
1263  023b a137          	cp	a,#55
1264  023d 2453          	jruge	L554
1266  023f e602          	ld	a,(2,x)
1267  0241 a12c          	cp	a,#44
1268  0243 264d          	jrne	L554
1270  0245 e603          	ld	a,(3,x)
1271  0247 a130          	cp	a,#48
1272  0249 2706          	jreq	L754
1274  024b e603          	ld	a,(3,x)
1275  024d a131          	cp	a,#49
1276  024f 2641          	jrne	L554
1277  0251               L754:
1279  0251 1e03          	ldw	x,(OFST+1,sp)
1280  0253 6d04          	tnz	(4,x)
1281  0255 263b          	jrne	L554
1282                     ; 151         relay_num = cmd[1] - '0';
1284  0257 1e03          	ldw	x,(OFST+1,sp)
1285  0259 e601          	ld	a,(1,x)
1286  025b a030          	sub	a,#48
1287  025d 6b01          	ld	(OFST-1,sp),a
1289                     ; 152         state = cmd[3] - '0';
1291  025f 1e03          	ldw	x,(OFST+1,sp)
1292  0261 e603          	ld	a,(3,x)
1293  0263 a030          	sub	a,#48
1294  0265 6b02          	ld	(OFST+0,sp),a
1296                     ; 154         hal_relay_set(relay_num, state);
1298  0267 7b02          	ld	a,(OFST+0,sp)
1299  0269 97            	ld	xl,a
1300  026a 7b01          	ld	a,(OFST-1,sp)
1301  026c 95            	ld	xh,a
1302  026d cd007b        	call	_hal_relay_set
1304                     ; 156         UART_SendString("Relay ");
1306  0270 ae000d        	ldw	x,#L164
1307  0273 cd0164        	call	_UART_SendString
1309                     ; 157         UART_SendChar(cmd[1]);
1311  0276 1e03          	ldw	x,(OFST+1,sp)
1312  0278 e601          	ld	a,(1,x)
1313  027a cd0157        	call	_UART_SendChar
1315                     ; 158         UART_SendString(" = ");
1317  027d ae0009        	ldw	x,#L364
1318  0280 cd0164        	call	_UART_SendString
1320                     ; 159         UART_SendChar(cmd[3]);
1322  0283 1e03          	ldw	x,(OFST+1,sp)
1323  0285 e603          	ld	a,(3,x)
1324  0287 cd0157        	call	_UART_SendChar
1326                     ; 160         UART_SendString("\r\n");
1328  028a ae0006        	ldw	x,#L564
1329  028d cd0164        	call	_UART_SendString
1332  0290 2006          	jra	L764
1333  0292               L554:
1334                     ; 164         UART_SendString("ERR\r\n");
1336  0292 ae0000        	ldw	x,#L174
1337  0295 cd0164        	call	_UART_SendString
1339  0298               L764:
1340                     ; 166 }
1343  0298 5b04          	addw	sp,#4
1344  029a 81            	ret
1372                     ; 167 void system_init(void)
1372                     ; 168 {
1373                     	switch	.text
1374  029b               _system_init:
1378                     ; 169     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
1380  029b 4f            	clr	a
1381  029c cd0000        	call	_CLK_HSIPrescalerConfig
1383                     ; 170     hal_gpio_init();
1385  029f cd017b        	call	_hal_gpio_init
1387                     ; 171     relay_off();
1389  02a2 cd010b        	call	_relay_off
1391                     ; 172     UART_Config();
1393  02a5 cd0133        	call	_UART_Config
1395                     ; 173     sensor_reader_init();
1397  02a8 cd0130        	call	_sensor_reader_init
1399                     ; 174 }
1402  02ab 81            	ret
1457                     ; 176 void main_loop(void)
1457                     ; 177 {
1458                     	switch	.text
1459  02ac               _main_loop:
1461  02ac 520c          	subw	sp,#12
1462       0000000c      OFST:	set	12
1465                     ; 179     uint8_t idx = 0;
1467  02ae 0f0c          	clr	(OFST+0,sp)
1469  02b0               L135:
1470                     ; 184         c = UART_ReadChar();
1472  02b0 cd021f        	call	_UART_ReadChar
1474  02b3 6b0b          	ld	(OFST-1,sp),a
1476                     ; 186         if(c == '\r' || c == '\n')
1478  02b5 7b0b          	ld	a,(OFST-1,sp)
1479  02b7 a10d          	cp	a,#13
1480  02b9 2706          	jreq	L735
1482  02bb 7b0b          	ld	a,(OFST-1,sp)
1483  02bd a10a          	cp	a,#10
1484  02bf 261c          	jrne	L535
1485  02c1               L735:
1486                     ; 188             rx_buf[idx] = '\0';
1488  02c1 96            	ldw	x,sp
1489  02c2 1c0003        	addw	x,#OFST-9
1490  02c5 9f            	ld	a,xl
1491  02c6 5e            	swapw	x
1492  02c7 1b0c          	add	a,(OFST+0,sp)
1493  02c9 2401          	jrnc	L05
1494  02cb 5c            	incw	x
1495  02cc               L05:
1496  02cc 02            	rlwa	x,a
1497  02cd 7f            	clr	(x)
1498                     ; 190             if(idx > 0)
1500  02ce 0d0c          	tnz	(OFST+0,sp)
1501  02d0 2707          	jreq	L145
1502                     ; 192                 process_command(rx_buf);
1504  02d2 96            	ldw	x,sp
1505  02d3 1c0003        	addw	x,#OFST-9
1506  02d6 cd022c        	call	_process_command
1508  02d9               L145:
1509                     ; 195             idx = 0;
1511  02d9 0f0c          	clr	(OFST+0,sp)
1514  02db 20d3          	jra	L135
1515  02dd               L535:
1516                     ; 199             if(idx < sizeof(rx_buf)-1)
1518  02dd 7b0c          	ld	a,(OFST+0,sp)
1519  02df a107          	cp	a,#7
1520  02e1 24cd          	jruge	L135
1521                     ; 201                 rx_buf[idx++] = c;
1523  02e3 96            	ldw	x,sp
1524  02e4 1c0003        	addw	x,#OFST-9
1525  02e7 1f01          	ldw	(OFST-11,sp),x
1527  02e9 7b0c          	ld	a,(OFST+0,sp)
1528  02eb 97            	ld	xl,a
1529  02ec 0c0c          	inc	(OFST+0,sp)
1531  02ee 9f            	ld	a,xl
1532  02ef 5f            	clrw	x
1533  02f0 97            	ld	xl,a
1534  02f1 72fb01        	addw	x,(OFST-11,sp)
1535  02f4 7b0b          	ld	a,(OFST-1,sp)
1536  02f6 f7            	ld	(x),a
1537  02f7 20b7          	jra	L135
1562                     ; 206 int main(void)
1562                     ; 207 {
1563                     	switch	.text
1564  02f9               _main:
1568                     ; 208     system_init();
1570  02f9 ada0          	call	_system_init
1572                     ; 209     main_loop();
1574  02fb adaf          	call	_main_loop
1576  02fd               L755:
1577                     ; 211     while(1);
1579  02fd 20fe          	jra	L755
1639                     	xdef	_main
1640                     	xdef	_main_loop
1641                     	xdef	_system_init
1642                     	xdef	_process_command
1643                     	xdef	_UART_ReadChar
1644                     	xdef	_hal_gpio_init
1645                     	xdef	_UART_SendString
1646                     	xdef	_UART_SendChar
1647                     	xdef	_UART_Config
1648                     	xdef	_sensor_reader_init
1649                     	xdef	_relay_off
1650                     	xdef	_sensor_reader_update
1651                     	xdef	_hal_relay_set
1652                     	xdef	_hal_di_read
1653                     	xdef	_delay_ms
1654                     	xref	_UART1_GetFlagStatus
1655                     	xref	_UART1_SendData8
1656                     	xref	_UART1_ReceiveData8
1657                     	xref	_UART1_Cmd
1658                     	xref	_UART1_Init
1659                     	xref	_UART1_DeInit
1660                     	xref	_GPIO_ReadInputPin
1661                     	xref	_GPIO_WriteLow
1662                     	xref	_GPIO_WriteHigh
1663                     	xref	_GPIO_Init
1664                     	xref	_CLK_HSIPrescalerConfig
1665                     .const:	section	.text
1666  0000               L174:
1667  0000 4552520d      	dc.b	"ERR",13
1668  0004 0a00          	dc.b	10,0
1669  0006               L564:
1670  0006 0d0a00        	dc.b	13,10,0
1671  0009               L364:
1672  0009 203d2000      	dc.b	" = ",0
1673  000d               L164:
1674  000d 52656c617920  	dc.b	"Relay ",0
1694                     	end
