Type GameStart  							// Armazena todas as variaveis que o começo do jogo possui como forma de organização.
											// .
	gameStartedFlag as integer 				// Flag para saber se o jogo começou ou não.
	creditButtonAnimationTimer as float		// Variavel para que a animação do botão dure determinado tempo.
											// .
	startMenu as integer					// Sprite de fundo do menu de inicio.
	creditButton as integer					// Sprite do botão para os créditos.
	creditScreen as integer					// Sprite de fundo dos créditos.
	cursor as integer						// Sprite do cursor.
											// .
EndType										// .
gStart as GameStart							// -

GotoStart:

gStart.gameStartedFLag = 0					// O programa inicia indicando que o jogo ainda não foi iniciado.

SetFolder( "/" )							// -
SetFolder( "media" )						// Carrega a pasta onde estão as imagens do GUI da página inicial do jogo.
SetFolder( "startGUI" )						// -

gStart.startMenu = CreateSprite ( LoadImage ( "startMenu.png" ) )	// Cria o sprite de fundo do menu de início.

gStart.creditButton = CreateSprite ( 0 )												// Cria o sprite do botão para ir aos créditos e adiciona sua animação de apertado.
SetSpriteShapeBox (gStart.creditButton, 177, 44, 80, 13,0)								// .
AddSpriteAnimationFrame (gStart.creditButton, LoadImage ( "creditButtonUP.png" ) )		// .
AddSpriteAnimationFrame (gStart.creditButton, LoadImage ( "creditButtonDOWN.png" ) )	// -

gStart.creditScreen = CreateSprite ( LoadImage ( "creditScreen.png" ) )		// Cria um sprite da tela de crédigos e o configura inicialmente como invisivel.
SetSpriteVisible(gStart.CreditScreen, 0)									// -

SetRawMouseVisible(0)											// -
gStart.cursor = CreateSprite ( LoadImage ( "cursor.png" ) )		// Cria o sprite do cursor do mouse, colocando sua colisão e tornando o cursor real invisível.
SetSpriteShapeBox(gStart.cursor, 0, -7, 2, 2, 0)				// -

return

LoopStartButton:

SetSpritePosition(gStart.cursor, GetPointerX() - 25, GetPointerY() - 5) 	// Posiciona o sprite de cursor nas mesmas cordenadas do mouse.

if GetPointerPressed() and GetSpriteCollision(gStart.cursor, gStart.creditButton)		// -
	SetSpriteFrame (gStart.creditButton, 2)												// Quando o jogador apertar com o botão direito do mouse no botão.
																						// .
																						// .
	creditButtonAnimationTimer = Timer()												// .
																						// .
elseif Timer() > creditButtonAnimationTimer + 0.5 and creditButtonAnimationTimer <> 0	// .
	SetSpriteFrame (gStart.creditButton, 1)												// .
	SetSpriteVisible(gStart.CreditScreen, 1)											// A tela de créditos se torna visivel.
	creditButtonAnimationTimer = 0														// .
endif																					// -

if GetSpriteVisible(gStart.CreditScreen) and KEY_ESCAPE		// Quando a tela de créditos estiver vísivel, se o jogador apertar ESC ela será fechada.
	SetSpriteVisible(gStart.CreditScreen, 0)				// .
endif														// -


if KEY_SPACE and GetSpriteVisible (gStart.CreditScreen) = 0
	
	DeleteSprite (gStart.startMenu)			// Deleta todos os sprites do menu inicial e torna o cursor real visivel novamente.
	DeleteSprite (gStart.creditScreen)		// .
	DeleteSprite (gStart.creditButton)		// .
	DeleteSprite (gStart.cursor)			// .
	SetRawMouseVisible (1)					// -
	
	gStart.gameStartedFLag = 1		// Indica que o jogo começou.
	StartGame(1)					// Começa o jogo na primeira sala.
	
endif

return
