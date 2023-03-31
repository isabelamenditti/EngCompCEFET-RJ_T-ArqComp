;EXECUÇÃO: \Desktop\Eng Comp\Arquiterura de computadores\laboratory\lectures>p3as-win.exe pacman-isabela.as & java -jar p3sim.jar pacman-isabela.exe
;------------------------------------------------------------------------------
; ZONA I: Definicao de constantes
;         Pseudo-instrucao : EQU
;------------------------------------------------------------------------------
IO_WRITE        	EQU     FFFEh
INITIAL_SP     		EQU     FDFFh
CURSOR				EQU     FFFCh
CURSOR_INIT			EQU		FFFFh
TIMER_UNITS			EQU		FFF6h
TIMER_ACTIVATE		EQU		FFF7h
OFF					EQU		0d
ON					EQU 	1d
TECLA_ESQ			EQU		1d
TECLA_DIR			EQU		2d
TECLA_CIMA			EQU		3d
TECLA_BAIXO			EQU		4d
PARADO				EQU		6d
NUM_COLUNA			EQU		79d
NUM_LINHA			EQU		24d
LINHA_INICIO		EQU 	1d  ; inicializaçao do pacman
COLUNA_INICIO		EQU 	39d ; inicializaçao do pacman
PACMAN				EQU		'C'
ESPACO_VAZIO		EQU		' '
COLUNA_SCORE		EQU		13d
PONTUACAO_MAX		EQU		561d
FANTASMINHA			EQU		'$'
LINHA_GHOST1		EQU		15d ; inicializaçao do fantasma1
LINHA_GHOST2		EQU		8d ; inicializaçao do fantasma2
COLUNA_GHOST1		EQU		39d
COLUNA_GHOST2		EQU		39d
RND_MASK			EQU		8016h	; 1000 0000 0001 0110b
LSB_MASK			EQU		0001h	; Mascara para testar o bit menos significativo do Random_Var
NUM_DIRECOES		EQU		6d ; função de gerar a variável aleatória entre [0,n) não está gerando os números 0 e n-1
COLUNA_VIDAS		EQU		74d

;------------------------------------------------------------------------------
; ZONA II: definicao de variaveis
;          Pseudo-instrucoes : WORD - palavra (16 bits)
;                              STR  - sequencia de caracteres (cada ocupa 1 palavra: 16 bits).
;          Cada caracter ocupa 1 palavra
;------------------------------------------------------------------------------

ORIG    				8000h
RowIndex		WORD	0d
ColumnIndex		WORD	0d
TextIndex		WORD	0d

;>>> MAPA
Linha1			STR '# > SCORE 0000 < ############################################### > VIDAS 03 < #'; linha 1
Linha2			STR '########################### ........... ........... ###########################'; linha 2
Linha3			STR '## .......................... ################### .......................... ##'; linha 3
Linha4			STR '########### . ############# . ################### . ############ . ############'; linha 4
Linha5			STR '########### . ############# ....................... ############ . ############'; linha 5
Linha6			STR '########### . ############# . ################### . ############ . ############'; linha 6
Linha7			STR '## .......................... ################### . ........................ ##'; linha 7
Linha8			STR '########################### . ################### . ###########################'; linha 8
Linha9			STR '## .................................... .................................... ##'; linha 9
Linha10			STR '## . ##### . ##### . ##### . ##### . ######### . ##### . ##### . # . ##### . ##'; linha 10
Linha11			STR '## . ##### . #   # . #   # . # ..... # . # . # . #   # . # . # . # . ##### . ##'; linha 11
Linha12			STR '## . ##### . ##### . ##### . # . # . # . # . # . ##### . # . # . # . ##### . ##'; linha 12
Linha13			STR '## . ##### . # ..... # . # . # . # . # . # . # . # . # . # . # . # . ##### . ##'; Linha 13
Linha14			STR '## . ##### . # . # . # . # . # ..... # . # . # . # . # . # . # . # . ##### . ##'; linha 14
Linha15			STR '## . ##### . # . # . # . # . ##### . # . # . # . # . # . # . ##### . ##### . ##'; linha 15
Linha16			STR '## .................................... .................................... ##'; igual a linha 9
Linha17			STR '########################### . ################### . ###########################'; igual a linha 8
Linha18			STR '## .......................... ################### . ........................ ##'; igual a linha 7
Linha19			STR '########### . ############# . ################### . ############ . ############'; igual a linha 6
Linha20			STR '########### . ############# ....................... ############ . ############'; igual a linha 5
Linha21			STR '########### . ############# . ################### . ############ . ############'; igual a linha 4
Linha22			STR '## .......................... ################### .......................... ##'; igual a linha 3
Linha23			STR '########################### ....................... ###########################'; igual a linha 2
Linha24			STR '###############################################################################'; igual a linha 1

;>>> TELA DE GAME OVER
Over1			STR '# > SCORE 0000 < ############################################### > VIDAS 03 < #'; 
Over2			STR '########################### ....................... ###########################'; 
Over3			STR '## .......................... ################### .......................... ##'; 
Over4			STR '########### . ############# . ################### . ############ . ############'; 
Over5			STR '########### . ############# ....................... ############ . ############'; 
Over6			STR '########### . ############# . ################### . ############ . ############'; 
Over7			STR '## .......................... ################### . ........................ ##';
Over8			STR '########################### . ################### . ###########################'; 
Over9			STR '## ......................................................................... ##'; 
Over10			STR '##    #####  #####  #########  #####      ##### #         # #####  #####     ##';  
Over11			STR '##    #   #  #   #  #   #   #  #          #   #  #       #  #      #   #     ##';
Over12			STR '##    #      #####  #   #   #  #          #   #   #     #   #      #   #     ##';
Over13			STR '##    #  ##  #   #  #   #   #  ###   ###  #   #    #   #    ###    #####     ##';
Over14			STR '##    #   #  #   #  #   #   #  #          #   #     # #     #      #    #    ##';
Over15			STR '##    #####  #   #  #   #   #  #####      #####      #      #####  #     #   ##';
Over16			STR '## ......................................................................... ##'; 
Over17			STR '########################### . ################### . ###########################'; 
Over18			STR '## .......................... ################### . ........................ ##'; 
Over19			STR '########### . ############# . ################### . ############ . ############'; 
Over20			STR '########### . ############# ....................... ############ . ############'; 
Over21			STR '########### . ############# . ################### . ############ . ############'; 
Over22			STR '## .......................... ################### .......................... ##'; 
Over23			STR '########################### ....................... ###########################'; 
Over24			STR '###############################################################################';

Over_Champion	STR '########################### . ### VOCE GANHOU ### . ###########################';

Arg_imprimir_str	WORD 0d
Arg_imprimir_linha	WORD 0d
Coluna_Pacman		WORD COLUNA_INICIO
Linha_Pacman		WORD LINHA_INICIO
Address_Pacman		WORD 0d
Ultima_Tecla		WORD PARADO
Score 				WORD 0d
Coluna_Ghost_1		WORD COLUNA_GHOST1
Coluna_Ghost_2		WORD COLUNA_GHOST2
Linha_Ghost_1		WORD LINHA_GHOST1
Linha_Ghost_2		WORD LINHA_GHOST2
Address_Ghost_1		WORD 0d
Address_Ghost_2		WORD 0d
Direcao_Ghost_1		WORD TECLA_DIR ; salva a direção que o fantasma está até ele bater na parede
Direcao_Ghost_2		WORD TECLA_ESQ
Random_Var			WORD A5A5h ; 1010 0101 1010 0101
Random_Var2			WORD A5A5h ; 1010 0101 1010 0101
Lugar_Ghost1		WORD ESPACO_VAZIO
Lugar_Ghost2		WORD ESPACO_VAZIO
Vidas				WORD 3d
;------------------------------------------------------------------------------
; ZONA II: definicao de tabela de interrupções
;------------------------------------------------------------------------------
                	ORIG    FE00h
INT0				WORD	Tecla_cima_press
INT1				WORD	Tecla_baixo_press
INT2				WORD	Tecla_dir_press
INT3				WORD	Tecla_esq_press
					ORIG	FE0Fh
INT15				WORD	Timer

;------------------------------------------------------------------------------
; ZONA IV: codigo
;        conjunto de instrucoes Assembly, ordenadas de forma a realizar
;        as funcoes pretendidas
;------------------------------------------------------------------------------
                	ORIG    0000h
                	JMP     Main

;------------------------------------------------------------------------------
; Função Temporizador
;------------------------------------------------------------------------------

Timer: 				PUSH R1
                    PUSH R2

					MOV R1, M[Ultima_Tecla] ; verifica qual foi a ultima tecla pressionada

					CMP R1, TECLA_CIMA
					CALL.Z Andar_Cima

					CMP R1, TECLA_BAIXO
					CALL.Z Andar_Baixo

					CMP R1, TECLA_DIR
					CALL.Z Andar_Direita

					CMP R1, TECLA_ESQ
					CALL.Z Andar_Esquerda

                    MOV R2, M[Address_Pacman] ; verificando se colidiu com algum fantasma
                    MOV R1, M[Address_Ghost_1]
                    CMP R1, R2
                    CALL.Z MorteLentaDolorosa

                    MOV R2, M[Address_Pacman]
                    MOV R1, M[Address_Ghost_2]
                    CMP R1, R2
                    CALL.Z MorteLentaDolorosa

                    CALL Mov_Ghost1
					CALL Mov_Ghost2

                    MOV R2, M[Address_Pacman] ; verificando se colidiu com algum fantasma
                    MOV R1, M[Address_Ghost_1]
                    CMP R1, R2
                    CALL.Z MorteLentaDolorosa

                    MOV R2, M[Address_Pacman]
                    MOV R1, M[Address_Ghost_2]
                    CMP R1, R2
                    CALL.Z MorteLentaDolorosa

					CALL Start_Timer ; inicializa o temporizador

					POP R2
                    POP R1

					RTI

;------------------------------------------------------------------------------
; Start_Timer: Define o tempo do temporizador
;------------------------------------------------------------------------------
Start_Timer: 		PUSH R1

					MOV R1, 2d ; 200 ms é o tempo de movimento do pacman
					MOV M[TIMER_UNITS], R1
					MOV R1, ON
					MOV M[TIMER_ACTIVATE], R1

					POP R1

					RET

;------------------------------------------------------------------------------
; Verifica qual tecla foi pressionada
;------------------------------------------------------------------------------
Tecla_cima_press: 	PUSH R1

					MOV R1, TECLA_CIMA
					MOV M[Ultima_Tecla], R1

					POP R1

					RTI

Tecla_baixo_press: 	PUSH R1

					MOV R1, TECLA_BAIXO
					MOV M[Ultima_Tecla], R1

					POP R1

					RTI

Tecla_dir_press: 	PUSH R1

					MOV R1, TECLA_DIR
					MOV M[Ultima_Tecla], R1

					POP R1

					RTI	

Tecla_esq_press: 	PUSH R1

					MOV R1, TECLA_ESQ
					MOV M[Ultima_Tecla], R1

					POP R1

					RTI

;------------------------------------------------------------------------------
; Função que gera o loop para imprimir o mapa e a tela de game over
;------------------------------------------------------------------------------
Imprimir:			PUSH R1
					PUSH R2
					PUSH R3
					PUSH R4

					MOV R3, M[Arg_imprimir_str]
					MOV R2, 0d ; coluna

Loop_imprimir:		MOV R1, M[Arg_imprimir_linha] ; loop para imprimir o mapa
					SHL R1, 8d
					OR  R1, R2
					MOV M[CURSOR], R1

					MOV R4, M[R3]

					MOV M[IO_WRITE], R4
					INC R2
					INC R3
					CMP R2, NUM_COLUNA
					JMP.NZ Loop_imprimir	

Pula_linha:			MOV R1, M[Arg_imprimir_linha] ; imprimindo a próxima linha
					INC R1
					CMP R1, NUM_LINHA
					JMP.Z Fim
					MOV M[Arg_imprimir_linha], R1
					MOV R2, 0d
					JMP Loop_imprimir
				
Fim:				POP R4
					POP R3
					POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Imprimir Mapa
;------------------------------------------------------------------------------
Imprimir_mapa:		PUSH R1

					MOV R1, Linha1		
					MOV M[Arg_imprimir_str], R1
					MOV R1, 0d
					MOV M[Arg_imprimir_linha], R1
					CALL Imprimir

					POP R1

					RET

;------------------------------------------------------------------------------
; Imprimir Game Over
;------------------------------------------------------------------------------
Game_Over: 	        PUSH R1
					PUSH R2

					MOV R1, Over2		
					MOV M[Arg_imprimir_str], R1
					MOV R1, 1d
					MOV M[Arg_imprimir_linha], R1
					CALL Imprimir

					JMP Halt

					POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Restart nas posições ao perder vida
;------------------------------------------------------------------------------
Apagar_Posicoes:    PUSH R1
					PUSH R2

                    ; imprimindo o que tinha na posicao do fantasma1 antes dele
                    MOV R2, M[Coluna_Ghost_1]; coluna
					MOV R1, M[Linha_Ghost_1]; linha
					SHL R1, 8d;
					OR R1, R2;

                    MOV M[CURSOR], R1
					MOV R2, M[Lugar_Ghost1] 
					MOV M[IO_WRITE], R2

                    ; imprimindo o que tinha na posicao do fantasma2 antes dele
                    MOV R2, M[Coluna_Ghost_2]; coluna
					MOV R1, M[Linha_Ghost_2]; linha
					SHL R1, 8d;
					OR R1, R2;

                    MOV M[CURSOR], R1
					MOV R2, M[Lugar_Ghost2] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R2

					MOV R1, ESPACO_VAZIO
					MOV M[Lugar_Ghost1], R1
					MOV M[Lugar_Ghost2], R1

                    POP R2
					POP R1

					RET

Atualiza_Address:   PUSH R1

					MOV R1, COLUNA_INICIO ; atualiza posição do pacman
					MOV M[Coluna_Pacman], R1
					MOV R1, LINHA_INICIO
					MOV M[Linha_Pacman], R1

                    CALL Printa_Pacman

					MOV R1, COLUNA_GHOST1
					MOV M[Coluna_Ghost_1], R1
					MOV R1, LINHA_GHOST1
					MOV M[Linha_Ghost_1], R1

                    CALL Fantasmagorico1

					MOV R1, COLUNA_GHOST2
					MOV M[Coluna_Ghost_2], R1
					MOV R1, LINHA_GHOST2
					MOV M[Linha_Ghost_2], R1

                    CALL Fantasmagorico2

					POP R1

					RET

;------------------------------------------------------------------------------
; Verifica as vidas, se é game over ou restart
;------------------------------------------------------------------------------
MorteLentaDolorosa: PUSH R1
					PUSH R2

					MOV R1, M[Vidas] ; verificando quantas vidas tem
					DEC R1
                    MOV M[Vidas], R1

                    ADD R1, 48d
                    MOV R2, COLUNA_VIDAS
					MOV M[CURSOR], R2
					MOV M[IO_WRITE], R1

                    SUB R1, 48d
					CMP R1, 0d ; morreu pra sempre: fim de jogo
					CALL.Z Game_Over

                    CALL Apagar_Posicoes
					CALL Atualiza_Address

					MOV R1, PARADO
                    MOV M[Ultima_Tecla], R1

                    CALL Start_Game					

					POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Começa o jogo
;------------------------------------------------------------------------------
Start_Game: 		PUSH R1
					PUSH R2
					PUSH R3

					;>>> POSICAO DO PACMAN NA MEMÓRIA
					MOV R1, M[Linha_Pacman]
					MOV R2, M[Coluna_Pacman]
					MOV R3, NUM_COLUNA

					MUL R1, R3 ; resultado fica em R3
					ADD R3, R2 ; numero de posicoes de memoria que é preciso andar

					ADD R2, Linha2
					MOV M[Address_Pacman], R2

					;>>> POSICAO FANTASMINHAS NA MEMÓRIA
					;FANTASMA 1
					MOV R1, M[Linha_Ghost_1]
					MOV R2, M[Coluna_Ghost_1]
					MOV R3, NUM_COLUNA

					MUL R1, R3 ; resultado fica em R3
					ADD R3, R2 ; numero de posicoes de memoria que é preciso andar

					ADD R2, Linha16
					MOV M[Address_Ghost_1], R2

					;FANTASMA 2
					MOV R1, M[Linha_Ghost_2]
					MOV R2, M[Coluna_Ghost_2]
					MOV R3, NUM_COLUNA

					MUL R1, R3 ; resultado fica em R3
					ADD R3, R2 ; numero de posicoes de memoria que é preciso andar

					ADD R2, Linha9
					MOV M[Address_Ghost_2], R2

					POP R3
					POP R2
					POP R1

					RET		

;------------------------------------------------------------------------------
; Função Random - Gerar número aleatório
;------------------------------------------------------------------------------
Numero_Aleatorio:	PUSH R1
					PUSH R2

            		MOV	R1, LSB_MASK
					AND	R1, M[Random_Var] ; R1 = bit menos significativo de M[Random_Var]
					BR.Z Rnd_Rotate
					MOV	R1, RND_MASK
					XOR	M[Random_Var], R1

Rnd_Rotate:			ROR	M[Random_Var], 1

					MOV R1, M[Random_Var]
					MOV R2, NUM_DIRECOES
					DIV R1, R2
					MOV M[Random_Var], R2
					
					POP R2
					POP	R1

					RET

;------------------------------------------------------------------------------
; Funções do movimento dos fantasmas
;------------------------------------------------------------------------------
Mov_Ghost1:			PUSH R1
                    PUSH R2
                    PUSH R3
                    PUSH R4
					
Restart:			MOV R1, M[Direcao_Ghost_1]

					CMP R1, TECLA_CIMA
					JMP.Z Mov_Cima_1

					CMP R1, TECLA_BAIXO
					JMP.Z Mov_Baixo_1

					CMP R1, TECLA_DIR
					JMP.Z Mov_Direita_1

					CMP R1, TECLA_ESQ
					JMP.Z Mov_Esquerda_1

Parede_1:			CALL Numero_Aleatorio ; chama a função de gerar numero aleatorio

					MOV R2, M[Random_Var] ; verifica se o numero escolhido não era o mesmo que já havia antes, se for, chama de volta
					MOV R1, M[Direcao_Ghost_1]
					CMP R1, R2 ; comparando pra eliminar a tendência de ir na mesma direção errada que já estava antes
					JMP.Z Parede_1

					MOV M[Direcao_Ghost_1], R2
					JMP Restart

Mov_Cima_1:			MOV R1, M[Address_Ghost_1] ; R1 salva o endereço do fantasma
					SUB R1, NUM_COLUNA
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_1

                    MOV R4, M[Address_Ghost_2] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_1

					MOV R4, M[Coluna_Ghost_1]; coluna
					MOV R3, M[Linha_Ghost_1]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost1] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost1], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Linha_Ghost_1];
					DEC R4
					MOV M[Linha_Ghost_1], R4

					MOV M[Address_Ghost_1], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico1

                    JMP Finalmente1

Mov_Baixo_1:		MOV R1, M[Address_Ghost_1] ; R1 salva o endereço do fantasma
					ADD R1, NUM_COLUNA
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_1

                    MOV R4, M[Address_Ghost_2] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_1

					MOV R4, M[Coluna_Ghost_1]; coluna
					MOV R3, M[Linha_Ghost_1]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost1] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost1], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Linha_Ghost_1];
					INC R4
					MOV M[Linha_Ghost_1], R4

					MOV M[Address_Ghost_1], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico1

                    JMP Finalmente1

Mov_Direita_1:		MOV R1, M[Address_Ghost_1] ; R1 salva o endereço do fantasma
					INC R1
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_1

                    MOV R4, M[Address_Ghost_2] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_1

					MOV R4, M[Coluna_Ghost_1]; coluna
					MOV R3, M[Linha_Ghost_1]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost1] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost1], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Coluna_Ghost_1];
					INC R4
					MOV M[Coluna_Ghost_1], R4

					MOV M[Address_Ghost_1], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico1

                    JMP Finalmente1

Mov_Esquerda_1: 	MOV R1, M[Address_Ghost_1] ; R1 salva o endereço do fantasma
					DEC R1
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_1

                    MOV R4, M[Address_Ghost_2] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_1

					MOV R4, M[Coluna_Ghost_1]; coluna
					MOV R3, M[Linha_Ghost_1]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost1] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost1], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Coluna_Ghost_1];
					DEC R4
					MOV M[Coluna_Ghost_1], R4

					MOV M[Address_Ghost_1], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico1
					
Finalmente1:		POP R4
					POP R3
					POP R2
					POP R1

					RET

;>>> Inicializando Fantasma 2

Mov_Ghost2:			PUSH R1
                    PUSH R2
                    PUSH R3
                    PUSH R4
					
Restart2:			MOV R1, M[Direcao_Ghost_2]

					CMP R1, TECLA_CIMA
					JMP.Z Mov_Cima_2

					CMP R1, TECLA_BAIXO
					JMP.Z Mov_Baixo_2

					CMP R1, TECLA_DIR
					JMP.Z Mov_Direita_2

					CMP R1, TECLA_ESQ
					JMP.Z Mov_Esquerda_2

Parede_2:			CALL Numero_Aleatorio ; chama a função de gerar numero aleatorio

					MOV R2, M[Random_Var] ; verifica se o numero escolhido não era o mesmo que já havia antes, se for, chama de volta
					MOV R1, M[Direcao_Ghost_2]
					CMP R1, R2 ; comparando pra eliminar a tendência de ir na mesma direção errada que já estava antes
					JMP.Z Parede_2

					MOV M[Direcao_Ghost_2], R2
					JMP Restart2

Mov_Cima_2:			MOV R1, M[Address_Ghost_2] ; R1 salva o endereço do fantasma
					SUB R1, NUM_COLUNA
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_2

                    MOV R4, M[Address_Ghost_1] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_2

					MOV R4, M[Coluna_Ghost_2]; coluna
					MOV R3, M[Linha_Ghost_2]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost2] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost2], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Linha_Ghost_2];
					DEC R4
					MOV M[Linha_Ghost_2], R4

					MOV M[Address_Ghost_2], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico2

                    JMP Finalmente2

Mov_Baixo_2:		MOV R1, M[Address_Ghost_2] ; R1 salva o endereço do fantasma
					ADD R1, NUM_COLUNA
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_2

                    MOV R4, M[Address_Ghost_1] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_2

					MOV R4, M[Coluna_Ghost_2]; coluna
					MOV R3, M[Linha_Ghost_2]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost2] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost2], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Linha_Ghost_2];
					INC R4
					MOV M[Linha_Ghost_2], R4

					MOV M[Address_Ghost_2], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico2

                    JMP Finalmente2

Mov_Direita_2:		MOV R1, M[Address_Ghost_2] ; R1 salva o endereço do fantasma
					INC R1
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_2

                    MOV R4, M[Address_Ghost_1] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_2

					MOV R4, M[Coluna_Ghost_2]; coluna
					MOV R3, M[Linha_Ghost_2]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost2] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost2], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Coluna_Ghost_2];
					INC R4
					MOV M[Coluna_Ghost_2], R4

					MOV M[Address_Ghost_2], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico2

                    JMP Finalmente2

Mov_Esquerda_2: 	MOV R1, M[Address_Ghost_2] ; R1 salva o endereço do fantasma
					DEC R1
					MOV R2, M[R1] ; R2 salva o conteudo que está no proximo endereço do fantasma

					CMP R2, '#' ; verificando se é uma parede
					JMP.Z Parede_2

                    MOV R4, M[Address_Ghost_1] ; verificando se os fantasmas estão colidindo
					CMP R1, R4
					JMP.Z Parede_2

					MOV R4, M[Coluna_Ghost_2]; coluna
					MOV R3, M[Linha_Ghost_2]; linha
					SHL R3, 8d;
					OR R3, R4;

					MOV M[CURSOR], R3
					MOV R4, M[Lugar_Ghost2] ; imprimindo o que tinha na posicao do fantasma antes dele
					MOV M[IO_WRITE], R4

					MOV M[Lugar_Ghost2], R2 ; atualiza o que tem na posição que o fantasma está

					MOV R4, M[Coluna_Ghost_2];
					DEC R4
					MOV M[Coluna_Ghost_2], R4

					MOV M[Address_Ghost_2], R1 ; atualizando o endereço do fantasma

					CALL Fantasmagorico2
					
Finalmente2:		POP R4
					POP R3
					POP R2
					POP R1

					RET
;------------------------------------------------------------------------------
; Printando Fantasminhas
;------------------------------------------------------------------------------
Fantasmagorico1: 	PUSH R1
					PUSH R2
					PUSH R3
				
					MOV R2, M[Coluna_Ghost_1]; coluna
					MOV R1, M[Linha_Ghost_1]; linha
					SHL R1, 8d;
					OR R1, R2;
					MOV M[CURSOR], R1

					MOV R3, FANTASMINHA
					MOV M[IO_WRITE], R3
					
					POP R3
					POP R2
					POP R1

					RET

Fantasmagorico2: 	PUSH R1
					PUSH R2
					PUSH R3

					MOV R2, M[Coluna_Ghost_2]; coluna
					MOV R1, M[Linha_Ghost_2]; linha
					SHL R1, 8d;
					OR R1, R2;
					MOV M[CURSOR], R1

					MOV R3, FANTASMINHA
					MOV M[IO_WRITE], R3

					POP R3
					POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Funções do movimento do Pacman
;------------------------------------------------------------------------------
Andar_Cima:			PUSH R1
					PUSH R2

					MOV R2, M[Address_Pacman]
					SUB R2, NUM_COLUNA
					MOV R1, M[R2]

					CMP R1, '#' ; verificando se é uma parede
					JMP.Z Fim_Andar_Cima

					MOV M[Address_Pacman], R2 ; atualizando o endereço do pacman

					CMP R1, '.'
					CALL.Z Pontua_Comidinha

					CALL Printa_Espaco

					MOV R1, M[Linha_Pacman]
					DEC R1
					MOV M[Linha_Pacman], R1
					CALL Printa_Pacman

Fim_Andar_Cima:		POP R2
					POP R1

					RET

Andar_Baixo: 		PUSH R1
					PUSH R2

					MOV R2, M[Address_Pacman]
					ADD R2, NUM_COLUNA
					MOV R1, M[R2]

					CMP R1, '#' ; verificando se é uma parede
					JMP.Z Fim_Andar_Baixo

					MOV M[Address_Pacman], R2 ; atualizando o endereço do pacman

					CMP R1, '.' ;  verificando se é uma comidinha
					CALL.Z Pontua_Comidinha

					CALL Printa_Espaco

					MOV R1, M[Linha_Pacman]
					INC R1
					MOV M[Linha_Pacman], R1
					CALL Printa_Pacman

Fim_Andar_Baixo:	POP R2
					POP R1

					RET

Andar_Esquerda: 	PUSH R1
					PUSH R2

					MOV R2, M[Address_Pacman]
					DEC R2
					MOV R1, M[R2]

					CMP R1, '#' ; verificando se é uma parede
					JMP.Z Fim_Andar_Esquerda

					MOV M[Address_Pacman], R2 ; atualizando o endereço do pacman
					
					CMP R1, '.' ;  verificando se é uma comidinha
					CALL.Z Pontua_Comidinha

					CALL Printa_Espaco

					MOV R1, M[Coluna_Pacman]
					DEC R1
					MOV M[Coluna_Pacman], R1
					CALL Printa_Pacman

Fim_Andar_Esquerda:	POP R2
					POP R1

					RET

Andar_Direita:		PUSH R1
					PUSH R2

					MOV R2, M[Address_Pacman]
					INC R2
					MOV R1, M[R2]

					CMP R1, '#' ; verificando se é uma parede
					JMP.Z Fim_Andar_Direita

					MOV M[Address_Pacman], R2 ; atualizando o endereço do pacman

					CMP R1, '.' ;  verificando se é uma comidinha
					CALL.Z Pontua_Comidinha

					CALL Printa_Espaco

					MOV R1, M[Coluna_Pacman]
					INC R1
					MOV M[Coluna_Pacman], R1
					CALL Printa_Pacman

Fim_Andar_Direita:	POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Pacman 
;------------------------------------------------------------------------------
Printa_Pacman: 	    PUSH R1
					PUSH R2
					PUSH R3
				
					MOV R2, M[Coluna_Pacman]; coluna
					MOV R1, M[Linha_Pacman]; linha
					SHL R1, 8d;
					OR R1, R2;
					MOV M[CURSOR], R1

					MOV R3, PACMAN
					MOV M[IO_WRITE], R3

					MOV R1, M[Score]
					CMP R1, PONTUACAO_MAX
					JMP.Z Game_Over
					
					POP R3
					POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Comidinha
;------------------------------------------------------------------------------
Printa_Espaco: 		PUSH R1
					PUSH R2
					PUSH R3

					MOV R2, M[Coluna_Pacman]; coluna
					MOV R1, M[Linha_Pacman]; linha
					SHL R1, 8d;
					OR R1, R2;
					MOV M[CURSOR], R1

					MOV R3, ESPACO_VAZIO
					MOV M[IO_WRITE], R3

					MOV R1, M[Address_Pacman]
					MOV R2, ESPACO_VAZIO
					MOV M[R1], R2 ; imprimindo espaço vazio na memória
					
					POP R3
					POP R2
					POP R1

					RET

Pontua_Comidinha:	PUSH R1
					PUSH R2
					PUSH R3
					PUSH R4
					
					MOV R1, M[Score] ; aumentando a pontuação
					INC R1
					MOV M[Score], R1

					MOV R4, COLUNA_SCORE; coluna
					
Calcula_Unidade: 	MOV M[CURSOR], R4
		
					MOV R3, 10d ; pegando a quantidade de comidinha pra printar no score
					
					DIV R1, R3 ; R1 é o quociente da divisão e R3 o resto

					ADD R3, 48d
					MOV M[IO_WRITE], R3

					CMP R1, 0d ;  comparando se o quociente é zero
					JMP.Z Final_Pontua

					DEC R4
					JMP Calcula_Unidade

Final_Pontua:		POP R4
					POP R3
					POP R2
					POP R1

					RET

;------------------------------------------------------------------------------
; Função Main
;------------------------------------------------------------------------------
Main:				ENI

					MOV	R1, INITIAL_SP
					MOV	SP, R1		 	; We need to initialize the stack
    				MOV	R1, CURSOR_INIT		; We need to initialize the cursor 
					MOV	M[ CURSOR ], R1		; with value CURSOR_INIT

    				CALL Imprimir_mapa
					CALL Start_Game

					CALL Printa_Pacman
					CALL Fantasmagorico1
					CALL Fantasmagorico2		

					CALL Start_Timer

Cycle: 		BR		Cycle
Halt:       BR		Halt