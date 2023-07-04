DeleteCollisionWalls:		    // Exclui as Collision Walls, uma configuração padrão de colisão do AGK.
								// .
SetPhysicsWallBottom  ( 0 )		// .
SetPhysicsWallTop     ( 0 )		// .
SetPhysicsWallLeft    ( 0 )		// .
SetPhysicsWallRight   ( 0 )		// .
								// .
return							// -

StartPhysics:

SetPhysicsScale(0.05) 		// Configurações de física do jogo.
SetPhysicsGravity(0 , 0)	// -	

return

PlayerPassThroughObjects: 

if room.roomN = 1																	// Conforme a sala atual...
	SetSpriteDepth(room.bottomDeco, 3)												// Define quando um sprite deve ser colisivel e qual sua profundidade conforme a posição do jogador. Dando uma impressão de 3 dimensões.
																					// .	
elseif room.roomN = 2																// .
	if (GetSpriteY(player.ID) + GetSpriteHeight(player.ID)) > 820					// .
		SetSpriteDepth(room.bottomDeco, GetSpriteDepth(player.imageSprite) + 1)		// .
	else																			// .
		SetSpriteDepth(room.bottomDeco, GetSpriteDepth(player.imageSprite) - 1)		// .
	endif																			// .
																					// .
elseif room.roomN = 3																// .
	if (GetSpriteY(player.ID) + GetSpriteHeight(player.ID)) > 730					// .
		SetSpriteDepth(room.bottomDeco, GetSpriteDepth(player.imageSprite) + 2)		// .
	else																			// .
		SetSpriteDepth(room.bottomDeco, GetSpriteDepth(player.imageSprite) - 2)		// .
	endif																			// .
																					// .
	if (GetSpriteY(player.ID) + GetSpriteHeight(player.ID)) > 715					// .
		SetSpriteDepth(columnSprite[0], GetSpriteDepth(player.imageSprite) + 2)		// .
		SetSpriteDepth(columnSprite[1], GetSpriteDepth(player.imageSprite) + 2)		// .
	else																			// .
		SetSpriteDepth(columnSprite[0], GetSpriteDepth(player.imageSprite) - 2)		// .
		SetSpriteDepth(columnSprite[1], GetSpriteDepth(player.imageSprite) - 2)		// .
	endif																			// .
																					// .
	if (GetSpriteY(player.ID) + GetSpriteHeight(player.ID)) > 390					// .
		SetSpriteDepth(columnSprite[2], GetSpriteDepth(player.imageSprite) + 2)		// .
		SetSpriteDepth(columnSprite[3], GetSpriteDepth(player.imageSprite) + 2)		// .
	else																			// .
		SetSpriteDepth(columnSprite[2], GetSpriteDepth(player.imageSprite) - 2)		// .
		SetSpriteDepth(columnSprite[3], GetSpriteDepth(player.imageSprite) - 2)		// .
	endif																			// .
																					// .
endif																				// -
																					
return

/*
=====================================================================================================================================
=====================================================================================================================================
*/

type roomType						// Type responsável por guardas as variáveis de uma sala genérica.
									// -
	decoration     as integer	    // Imagens das decorações/objetos no quarto.
	walls          as integer		// Imagens das paredes no quarto.
	bottomWall     as integer		// Imagem da parte inferior das paredes do quarto. Ela é criada separadamente para sobrepor o jogador, inimigos e decorações, de modo que torne o quarto um pseudo-3d.
	bottomDeco     as integer		// Imagem da parte inferior das decorações. Funciona da mesma maneira da parte inferior das paredes.
									// .
	roomN		   as integer		// O número atual do quarto.
									// .
endtype								// -
global room        as roomType		// Cria a variável - como global, para ser usada dentro da função - onde ficará guardado todos os types.


Function GoToRoom ( roomNumber )		// Cria todos os parâmetros da sala.
	
	room.roomN = roomNumber
	
	DIM collisionWalls[14]		// Sprite de qualquer tipo de colisão (seja com paredes ou objetos).
	DIM roomTiles[12, 9]		// Imagens do chão do quarto.
	
	//----------------------------------------------------------//
	for cwIndex = 0 to 14										// Deleta todos os sprites de 'sala' que existem durante a chamada da função.
		DeleteSprite(collisionWalls[cwIndex])					// .
	next cwIndex												// .
	for indexTileX = 0 to 11									// .
		for indexTileY = 0 to 8									// .					
			DeleteSprite(roomTiles[indexTileX, indexTileY])		// .
		next indexTileY											// .						
	next indexTileX												// .
	DeleteSprite(room.bottomWall)								// .
	DeleteSprite(room.bottomDeco)								// .
	DeleteSprite(room.decoration)								// .
	DeleteSprite(room.walls)									// .
	for deleteEnemyIndex = 0 to 10								// Também deleta todos os inimigos.
		DeleteSprite(enemy[deleteEnemyIndex].ID)				// .
		DeleteSprite(enemyImage[deleteEnemyIndex].ID)			// .
		DeleteSprite(enemy[deleteEnemyIndex].collisionSprite)	// .
	next deleteEnemyIndex										// .
	//----------------------------------------------------------//
	
	
	for cwIndex = 10 to 13																// -
		collisionWalls[cwIndex] = CreateSprite( CreateImageColor( 0, 0, 0, 0 ) )		// Cria 4 sprites do tipo "Collision Wall".
		SetSpritePhysicsOn(collisionWalls[cwIndex], 1)									// Todos os sprites possuem colisão e...
		SetSpriteVisible(collisionWalls[cwIndex], 0)									// são invisiveis.
																						// .
		if cwIndex = 10																	// Conforme o for viaja por cada sprite, uma definição diferente é criada.
			SetSpriteScale(collisionWalls[cwIndex], 1405, 225)                       	// Tamanho da parede de cima.
		elseif cwIndex = 11                                                             // .
			SetSpritePosition(collisionWalls[cwIndex], 0, 225)                       	// Posição da parede da esquerda.
			SetSpriteScale(collisionWalls[cwIndex], 65, 780)							// Tamanho da parede da esquerda.
		elseif cwIndex = 12                                                             // .
			SetSpritePosition(collisionWalls[cwIndex], 1405 - 65, 225)               	// Posição da parede da direita.
			SetSpriteScale(collisionWalls[cwIndex], 65, 780)							// Tamanho da parede da direita
		elseif cwIndex = 13                                                             // .
			SetSpritePosition(collisionWalls[cwIndex], 0, 225 + 780)					// Posição da parede de baixo.
			SetSpriteScale(collisionWalls[cwIndex], 1405, 125)							// Tamanho da parede de baixo.
		endif																			// .
	next cwIndex																		// -
	
	if roomNumber = 1
		player.savePointX = 175		// Define a posição inicial do jogador na sala.
		player.savePointY = 595		// -
		
		for cwIndex = 0 to 2																// -
			collisionWalls[cwIndex] = CreateSprite( CreateImageColor( 0, 0, 0, 0 ) )		// Cria uma quantidade x de sprites do tipo "Collision Wall", onde x é o número de de corações colisiveis no quarto.
			SetSpritePhysicsOn(collisionWalls[cwIndex], 1)									// Todos os sprites possuem colisão e...
			SetSpriteVisible(collisionWalls[cwIndex], 0)									// são invisiveis.
																							// .
			if cwIndex = 0																	// Conforme o for viaja por cada sprite, uma definição diferente é criada.
				SetSpritePosition(collisionWalls[cwIndex], 65, 225)							// Posição da decoração superior esquerdo do quarto.
				SetSpriteScale(collisionWalls[cwIndex], 150, 25)							// Tamanho da decoração superior esquerdo do quarto.
			elseif cwIndex = 1																// .
				SetSpritePosition(collisionWalls[cwIndex], 560, 225)						// Posição da decoração superior-centro.
				SetSpriteScale(collisionWalls[cwIndex], 120, 35)							// Tamanho da decoração superior-centro.
			elseif cwIndex = 2																// .
				SetSpritePosition(collisionWalls[cwIndex], 65, 875)							// Posição da decoração inferior esquerdo do quarto.
				SetSpriteScale(collisionWalls[cwIndex], 90, 130)							// Posição da decoração inferior esquerdo do quarto.
			endif																			// .
		next cwIndex																		// -
		
		CreateEnemy(0, 3, 380, 300)		// Cria os inimigos da sala
		CreateEnemy(0, 2, 1250, 475)	// .
		CreateEnemy(0, 1, 700, 920)		// -
		
	elseif roomNumber = 2
		player.savePointX = 80
		player.savePointY = 790 - GetSpriteHeight(player.ID)/2
		
		for cwIndex = 0 to 3																// Cria as colisões das decorações da sala 2, com parâmetros equivalentes a sala anterior.
			collisionWalls[cwIndex] = CreateSprite( CreateImageColor( 0, 0, 0, 0 ) )		// .
			SetSpritePhysicsOn(collisionWalls[cwIndex], 1)									// .
			SetSpriteVisible(collisionWalls[cwIndex], 0)									// .
																							// .
			if cwIndex = 0																	// .
				SetSpritePosition(collisionWalls[cwIndex], 455, 760)						// .
				SetSpriteScale(collisionWalls[cwIndex], 285, 250)							// .
			elseif cwIndex = 1																// .
				SetSpritePosition(collisionWalls[cwIndex], 65, 225)							// .
				SetSpriteScale(collisionWalls[cwIndex], 220, 90)							// .
			elseif cwIndex = 2																// .
				SetSpritePosition(collisionWalls[cwIndex], 645, 225)						// .
				SetSpriteScale(collisionWalls[cwIndex], 405, 65)							// .
			elseif cwIndex = 3																// .
				SetSpritePosition(collisionWalls[cwIndex], 900, 790)						// .
				SetSpriteScale(collisionWalls[cwIndex], 220, 1)								// .
			endif																			// -
			
		next cwIndex
		
		CreateEnemy(0, 7, 580, 310)		// Cria os inimigos da sala 2.
		CreateEnemy(0, 6, 1250, 410)	// .
		CreateEnemy(0, 5, 760, 565)		// .
		CreateEnemy(0, 4, 1230, 875)	// -
		
	elseif roomNumber = 3
		player.savePointX = 180										// Define a posição inicial do jogador na sala.
		player.savePointY = 330 - GetSpriteHeight(player.ID)/2		// -
		
		for cwIndex = 0 to 6																// Cria as colisões das decorações da sala 3, com parâmetros equivalentes a sala anterior.
			collisionWalls[cwIndex] = CreateSprite( CreateImageColor( 0, 0, 0, 0 ) )		// .
			SetSpritePhysicsOn(collisionWalls[cwIndex], 1)									// .
			SetSpriteVisible(collisionWalls[cwIndex], 0)									// .
																							// .
			if cwIndex = 0																	// .
				SetSpritePosition(collisionWalls[cwIndex], 65, 225)							// .
				SetSpriteScale(collisionWalls[cwIndex], 60, 200)							// .
			elseif cwIndex = 1																// .
				SetSpritePosition(collisionWalls[cwIndex], 65, 670)							// .
				SetSpriteScale(collisionWalls[cwIndex], 60, 60)								// .
			elseif cwIndex = 2																// .
				SetSpritePosition(collisionWalls[cwIndex], 215, 550)						// .
				SetSpriteScale(collisionWalls[cwIndex], 155, 300)							// .
			elseif cwIndex = 3																// .
				SetSpritePosition(collisionWalls[cwIndex], 505, 360)						// .
				SetSpriteScale(collisionWalls[cwIndex], 180, 60)							// .
			elseif cwIndex = 4																// .
				SetSpritePosition(collisionWalls[cwIndex], 975, 360)						// .
				SetSpriteScale(collisionWalls[cwIndex], 180, 60)							// .
			elseif cwIndex = 5																// .
				SetSpritePosition(collisionWalls[cwIndex], 505, 705)						// .
				SetSpriteScale(collisionWalls[cwIndex], 180, 60)							// .
			elseif cwIndex = 6																// .
				SetSpritePosition(collisionWalls[cwIndex], 975, 705)						// .
				SetSpriteScale(collisionWalls[cwIndex], 180, 60)							// .
			endif																			// .
		next cwIndex																		// -
		
		DIM columnSprite[4]																						// Cria os sprites especificos da sala 3, as colunas.
		for columnsIndex = 0 to 3																				// .
			columnSprite[columnsIndex] = CreateSprite( LoadImage( "column_" + str(columnsIndex) + ".png" ) )	// .
			SetSpriteDepth(columnSprite[columnsIndex], GetSpriteDepth(player.ID))								// .
		next columnsIndex																						// -
		
	endif
	
	if roomNumber > 0
		SetFolder( "/" )							// -
		SetFolder( "media" )						// Carrega a pasta onde estão as imagens dos quartos.
		SetFolder( "worldgeneration" )				// Abaixo, carrega a pasta do quarto conforme a entrada do parametro da função.
		SetFolder( "room_" + Str( roomNumber ) )	// -
																									// Carrega o quarto especificado como parâmetro da função.
		room.bottomWall  =  CreateSprite ( LoadImage( "generalRoomDepth.png" ) )					// Carrega a imagem da parede de baixo; conforme explicado na criação das variaveis.
		room.bottomDeco  =  CreateSprite ( LoadImage( "roomDecoDown.png" ) )                        // Carrega a imagem da decoração de baixo; conforme explicado na criação das variaveis.
		room.decoration  =  CreateSprite ( LoadImage( "roomDecoUp.png" ) )		            		// Carrega a imagem das decorações do quarto.
		room.walls       =  CreateSprite ( LoadImage( "roomMap.png" ) )								// Carrega a imagem das paredes.
		
		for indexTileX = 0 to 11																							// -
			for indexTileY = 0 to 8																							// Como uma matriz 8 x 11...
				roomTiles[indexTileX, indexTileY] = CreateSprite ( LoadImage("roomTile_" + str(Random(1, 3)) + ".png") )	// ... cria uma um piso com imagem aleatória...
				SetSpritePosition(roomTiles[indexTileX, indexTileY], indexTileX  * 119, indexTileY * 119)					// ... e adiciona em sua devida posição na matriz.
			next indexTileY																									// Como um todo, a matriz forma o chão inteiro do quarto.
		next indexTileX																										// -
	endif

Endfunction
