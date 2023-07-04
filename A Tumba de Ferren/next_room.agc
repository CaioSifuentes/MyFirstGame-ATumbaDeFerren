UnlockRoom:		// Desbloqueia uma porta para próxima sala conforme a sala atual e o número de inimigos mortos.

if room.roomN = 1												// Na sala 1...
																// .
	if player.enemyDeaths = 3 and GetSpriteExists(door) = 0		// Se o jogador matar três inimigos e já não existir uma porta.
		door = CreateSprite ( CreateImageColor (0, 0, 0, 0) )	// Abre uma porta para próxima sala.
		SetSpriteShape(door, 2)									// .
		SetSpritePosition(door, 1335, 440)						// .
		SetSpriteSize(door, 10, 110)							// -

		SetFolder( "/" )										// -
		SetFolder( "media" )									// .
		SetFolder( "GUI" )										// Abre a pasta onde estão as imagens do GUI.
		arrow = CreateSprite ( LoadImage ("xArrow.png") )		// Assim como carrega uma seta para indicar onde o jogador deve ir.
		SetSpritePosition(arrow, 1280, 490)						// .
	endif														// -
	
	if GetSpriteCollision(player.iD, door)						// Caso o jogador colida com a porta, ele passa para a próxima sala.
		DeleteSprite(arrow)										// .
		DeleteSprite(door)										// .
		StartGame(2)											// .
	endif														// .
endif															// -


if room.roomN = 2															// Na sala 2...
																			// .
	if player.enemyDeaths = 4 and GetSpriteExists(door) = 0					// Se o jogador matar quatro inimigos e já não existir uma porta.
		door = CreateSprite ( CreateImageColor (0, 0, 0, 0) )				// Abre uma porta para a próxima sala.
		SetSpriteShape(door, 2)												// .
		SetSpritePosition(door, 825, 290)									// .
		SetSpriteSize(door, 110, 10)										// -
																			
		SetFolder( "/" )													// -
		SetFolder( "media" )												// .
		SetFolder( "GUI" )													// Abre a pasta onde estão as imagens do GUI.
		arrow = CreateSprite ( LoadImage ("xArrow.png") )					// Assim como carrega uma seta para indicar onde o jogador deve ir.
		SetSpritePosition(arrow, 790, 330)									// .
	endif																	// -
																			
	if GetSpriteCollision(player.iD, door)									// Caso o jogador colida com a porta, ele finaliza o jogo. Em questão de salas, só temos 2 salas.
		DeleteSprite(arrow)													// .
		DeleteSprite(door)													// .
		DeleteAllSprites()													// .
		player.enemyDeaths = 0												// .
		SetFolder( "/" )													// .
		SetFolder( "media" )												// .
		SetFolder( "GUI" )													// .
		farinhaNaCumbuca = CreateSprite( LoadImage ("finalMessage.png") )	// -
	endif
endif

return
