// Organiza a ordem / layer dos sprites. A ordem segue a mesma da lista abaixo:

SpriteLayerSettings:
generalSpriteDepth = 0 // Sempre é adicionado + 1 após configurar uma profundidade, assim, as camadas ficam na ordem que está descrita.

SetSpriteDepth(sgui.youDiedScreen, generalSpriteDepth)		// Elementos do GUI.
for i = 0 to 3												// .
	SetSpriteDepth(vgui[i].life, generalSpriteDepth)		// .
	SetSpriteDepth(vgui[i].stamina, generalSpriteDepth)		// .
next i														// .
SetSpriteDepth(sgui.staminaBlock, generalSpriteDepth)		// .
SetSpriteDepth(sgui.lifeBlock, generalSpriteDepth)			// .
SetSpriteDepth(sgui.staticItens, generalSpriteDepth)		// .
SetSpriteDepth(sgui.backPaper, generalSpriteDepth)			// .
generalSpriteDepth = generalSpriteDepth + 1					// -

SetSpriteDepth(player.ID, generalSpriteDepth)				// Elementos de DEBUG.
generalSpriteDepth = generalSpriteDepth + 1					// .
SetSpriteDepth(attackCollisionSprite, generalSpriteDepth)	// .
generalSpriteDepth = generalSpriteDepth + 1					// -

SetSpriteDepth(room.bottomWall, 0)						// Parede e decorativos de baixo do quarto. Dá a impressão que o jogador realmente está em um ambiente de 3 dimensões.
SetSpriteDepth(room.bottomDeco, generalSpriteDepth)		// .
generalSpriteDepth = generalSpriteDepth + 1				// -

for enemyIndex = 0 to 10										// Inimigos e Jogador.
	SetSpriteDepth(enemy[enemyIndex].ID, generalSpriteDepth)	// .
next enemyIndex													// .
SetSpriteDepth(player.imageSprite, generalSpriteDepth)			// .
generalSpriteDepth = generalSpriteDepth + 5						// -

SetSpriteDepth(room.decoration, generalSpriteDepth) 								// Fundos, decorações e outros elementos das salas.
generalSpriteDepth = generalSpriteDepth + 1											// .
SetSpriteDepth(room.walls, generalSpriteDepth)										// .
generalSpriteDepth = generalSpriteDepth + 1											// .
for indexTileX = 0 to 11															// .
	for indexTileY = 0 to 8															// .
		SetSpriteDepth(roomTiles[indexTileX, indexTileY], generalSpriteDepth)		// .
	next indexTileY																	// .
next indexTileX																		// .
generalSpriteDepth = generalSpriteDepth + 1											// -

return
