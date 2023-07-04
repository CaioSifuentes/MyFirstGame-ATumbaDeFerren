PlayerMovement:		// Sub rotina para definir a movimentação do jogador.

SetSpritePositionByOffset(player.imageSprite, GetSpriteXByOffset(player.ID), GetSpriteYByOffset(player.ID) - 0.4) // Posiciona a imagem do jogador na mesma posição do jogador a todo momento.


// Movimentação básica de 8 direções.
if KEY_D																														// Ao apertar a letra D...
	if attackTimer# = 0																											// Se o jogador não estiver atacando, ele se vira para a direita.
		flipState = 0																											// .
	endif																														// .
	SetSpritePositionByOffset(player.ID, GetSpriteXByOffset(player.ID) + playerSpeed#, GetSpriteYByOffset(player.ID))			// E se move para a direita conforme sua velocidade.
endif																															// .
if KEY_A																														// Ao apertar a letra A...
	if attackTimer# = 0																											// Se o jogador não estiver atacando, ele vira para a esquerda.
		flipState = 180																											// .
	endif																														// .
	SetSpritePositionByOffset(player.ID, GetSpriteXByOffset(player.ID) + playerSpeed# *(-1), GetSpriteYByOffset(player.ID))		// E se move para a esquerda conforme sua velocidade.
endif																															// .
if KEY_W																														// Ao apertar a letra W...
	SetSpritePositionByOffset(player.ID, GetSpriteXByOffset(player.ID), GetSpriteYByOffset(player.ID) + playerSpeed# *(-1))		// Se move para cima conforme sua velocidade.
endif																															// .
if KEY_S																														// Ao apertar a letra S...
	SetSpritePositionByOffset(player.ID, GetSpriteXByOffset(player.ID), GetSpriteYByOffset(player.ID) + playerSpeed#)			// Se move para baixo conforme sua velocidade.
endif																															// -

if ((KEY_D and KEY_W) or (KEY_D and KEY_S) or (KEY_A and KEY_W) or (KEY_A and KEY_S))	// Redução da velocidade ao se mover na diagonal.
	playerSpeed# = player.defaultSpeed# / 1.5											// .
else																					// .
	playerSpeed# = player.defaultSpeed#													// Retorna a velocidade normal caso não esteja se movendo na diagonal.
endif																					// -

SetSpriteFlip(player.imageSprite, flipState, 0)		// Muda a direção em que o jogador está olhando, conforme a variavel definida.

return


// Configurações de animação de movimentação do jogador.
PlayerMovementAnimation:

if (KEY_D = 0 and KEY_A = 0 and KEY_W = 0 and KEY_S = 0) or playerSpeed# = 0									// Define quando o jogador está ou não se movendo.
	player.isMoving = 0																							// .
elseif ((KEY_D and KEY_A) and (KEY_W = 0 and KEY_S = 0)) or ((KEY_W and KEY_S and (KEY_D = 0 and KEY_A = 0)))	// .
	player.isMoving = 0																							// .
else																											// .
	player.isMoving = 1																							// .
endif																											// -

if player.isMoving = 1																					// Se estiver se movendo...
	if player.movingAnimationFlag = 0 and player.generalAnimationFlag = 0								// e não estiver atacando ou já realizando a animação de correr...
		PlaySprite(player.imageSprite, playerSpeed# * 1.7, 1, runningFirstFrame, runningLastFrame)		// inicia a animação de corrida.
		player.movingAnimationFlag = 1																	// .
	endif																								// .
endif																									// .
if player.isMoving = 0																					// Se não estiver se movendo...
	if player.movingAnimationFlag = 1 and player.attackAnimationFlag = 0								// e não não estiver atacando ou já realizado a animação de estar parado...
		PlaySprite(player.imageSprite, 3, 1, idleFirstFrame, idleLastFrame)								// inicia a animação de descanso.
	endif																								// .
	player.movingAnimationFlag = 0																		// .
endif																									// -

return
