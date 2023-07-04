#constant    KEY_W            GetRawKeyState(87)		// -
#constant    KEY_S            GetRawKeyState(83)		// Constantes para definir teclas usadas no jogo.
#constant    KEY_A            GetRawKeyState(65)		// .
#constant    KEY_D            GetRawKeyState(68)		// .
#constant    KEY_SPACE        GetRawKeyPressed(32)		// .
#constant    KEY_ESCAPE       GetRawKeyPressed(27)		// -

// ==============================================================================|
// Título: A Tumba de Ferren													 |
// Autor: Caio César Sifuentes Barcelos                                          |
// Curso: IF - BCC / 1° Periodo                                                  |
// ------------------------------------------------------------------------------|
// OBS: Nomes após um "#" indicam que a subrotina da linha está naquele arquivo. |
// ==============================================================================|

// Configurações gerais;
#include "windows_settings.agc" 			// Configura a tela do jogo.
gosub WindowSettings						// -  #windows_settings
#include "game_start.agc"					// Definições do inicio do jogo.
gosub GotoStart								// -  #game_start

#include "world_configuration.agc"			// Funções e Subrotinas para a criação das salas.
#include "next_room.agc"					// Cria Subrotinas para o funcionamento do sistema de mudança de salas.
gosub DeleteCollisionWalls					// Deleta as Collision Walls, uma configuração padrão do AGK.  #world_configuration
gosub StartPhysics							// Inicia as físicas do mapa, com seus atributos definidos.    #world_configuration

#include "enemy_configuration.agc" 			// Cria Funções, Subrotinas e variaveis para a criação e funcionamento de inimigos.
gosub EnemysVariables						// .  #enemy_configuration
gosub CreateEnemysFunctions					// -  #enemy_configuration
#include "enemys_sprites.agc"				// Adiciona as animações dos inimigos.
gosub CallEnemySprites						// .  #enemys_sprites

#include "player_settings.agc" 				// Cria Funções, Subrotinas e variaveis para a criação e funcionamento do jogador.
#include "player_sprites.agc" 				// Adiciona as animações do personagem.
#include "player_movement.agc" 				// Cria Funções e Subrotinas para a movimentação (e animação de movimentação) do jogador.
#include "player_attacks.agc" 				// Cria Funções e Subrotinas para o ataque (e animação de ataque) do jogador.

#include "GUI.agc"							// Cria Subrotinas para a criação e o funcionamento do GUI.

#include "spritelayer_configuration.agc" 	// Define as posições, nas camadas, de cada sprite. O posicionamento é feito na ordem de aparição do arquivo. De cima para baixo.

do
	
	if gStart.gameStartedFLag = 1			// Teste se o jogo começou. Se sim, roda o loop de funcionamento do jogo.
		
		gosub SpriteLayerSettings			// Configura a ordem das sprites.  #spritelayer_configuration

		gosub UpdateGUI						// Atualiza o GUI do personagem conforme seus atributos.  #GUI
		gosub UnlockRoom					// Desbloqueia uma nova sala caso o jogador tenha derrotado todos os inimigos da atual.  #next_room
		
		if player.deathFlag = 0				// Testa se o jogador está vivo.
			
			gosub PlayerMovement 			// Movimenta o jogador conforme os comandos dados.  #player_movement
			gosub PlayerMovementAnimation 	// Configura a animação do jogador conforme o movimento.  #player_movement
			
			gosub PlayerAttack				// Faz com que o jogador ataque, conforme os comandos dados.  #player_attacks
			
			gosub EnemyLoop					// Realiza todas as ações de cada inimigo, exceto por sua criação.  #enemy_configuration

		endif
		
		gosub PlayerPassThroughObjects		// Posiciona a camada de decorações de acordo com a posição do jogador, conforme a sala. Dando uma impressão de 3 dimensões.  #world_configuration
		
		if player.health <= 0				// Caso a vida do jogador chegue a zero...
			gosub PlayerDeath				// ... uma subrotina define o jogador como morto.  #player_settings
		endif								// -
		
		SetFolder( "/" )																	// -
		SetFolder( "media" )																// Carrega a pasta de sons do jogo e...
		SetFolder( "sound" )																// .	
		if GetMusicPlaying() = 0															// ... se nenhuma música estiver tocando, uma aleatória começa.
			PlayMusic ( LoadMusic ( "backSong_" + Str(Random (1 , 10) ) + ".mp3" ) )		// .
		endif																				// -
	
	else
											// -
		gosub LoopStartButton				// Enquanto o jogo não começou ainda, executa um loop em paralelo apenas para a tela inicial.  #game_start
											// -
	endif
	
	
	gosub DebugGame							// Sub-rotina para Debug do jogo.  #main
	
	
    Sync()
loop


Function StartGame(roomNumber) 						// Função para iniciar o jogo.
													// .
	GoToRoom(roomNumber)							// Chama a função para criar o mapa. O mapa é definido pelo seu número.
													// .
	gosub CreatePlayer								// Cria o sprite do jogador e define seus atributos.
	gosub CallPlayerAnimations						// Adiciona as animações do jogador.
	PlaySprite(player.imageSprite, 3, 1, 1, 5)		// Inicia a primeira animação do jogador como ele estando parado.
													// .
	gosub StartGUI									// Cria o GUI.
	gosub UpdateGUI									// Atualiza o GUI conforme as variaveis de atributo do jogador.
													// .
Endfunction											// -


DebugGame: // Sub-rotina para todos os sitemas de Debug necessários para os testes do jogo.-----------------// -
																											// .
																											// .
	if debugTF = 0																							// .
		if GetRawKeyPressed(84)																				// .
			debugTF = 1																						// .
			SetPhysicsDebugOn ( )																			// .
		endif																								// .
	elseif debugTF = 1																						// .
		if GetRawKeyPressed(84)																				// .
			debugTF = 0																						// .
			SetPhysicsDebugOff ( )																			// .
		endif																								// .
																											// .
		Print( "DEBUG MODE ON" )																			// .
																											// .
		Print( "FPS:" + str( ScreenFPS() ) )																// .
		Print( "Timer:" + str( Timer() ) )						 											// .
	endif																									// .
																											// .
return //Debug ---------------------------------------------------------------------------------------------// -

