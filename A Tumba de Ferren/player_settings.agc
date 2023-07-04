type playerType					// Agrupa as variaveis que fazem parte dos atributos do jogador. 
	
		// Variaveis virtuais. Aquelas que não tem significado ao jogo, mas ao código.
		ID as integer
		imageSprite as integer
		savePointX as integer
		savePointY as integer
        
        // Flags de animação e movimentação. Valores booleanos para definir se algo está ou não ocorrendo.
        isMoving as integer
        movingAnimationFlag as integer
        attackAnimationFlag as integer
        generalAnimationFlag as integer
        
        // Variaveis de atributo. Aquelas que tem efeito direto ao jogo, e que podem aparecer para o jogador.
        defaultSpeed# as float
        health as integer
        stamina as integer
        class as integer
        
        // Flags de Vida e Dano.
        resistenceFlag as integer
        deathFlag as integer
        
        // Variavel de  "KillCount"
        enemyDeaths as integer
        
endtype							// .
global player as playerType		// -


CreatePlayer:
DeleteSprite(player.ID)											// Cria o sprite de colisão do jogador.
player.ID = CreateSprite(CreateImageColor(255, 0, 0, 255))		// .
SetSpriteScale(player.ID, 58, 68)								// .
SetSpriteVisible(player.ID, 0)									// -

SetSpritePhysicsOn(player.ID,2)					// Inicializa as configurações de física do sprite do jogador.
SetSpritePhysicsCanRotate (player.ID,0)			// .
SetSpritePhysicsFriction(player.ID,0)			// .
SetSpritePhysicsRestitution(player.ID,0.1)		// .
SetSpritePhysicsMass(player.ID, 100)			// -

SetSpritePosition(player.ID, player.savePointX, player.savePointY)		// Posiciona o personagem na posição inicial definida pela sala.

player.health = 2			// Inicializa os atributos do jogador.
player.stamina = 2			// .
player.enemyDeaths = 0		// .
player.defaultSpeed# = 6	// -

DeleteSprite(player.imageSprite)																										// Cria o sprite da imagem do jogador. 
player.imageSprite = CreateSprite(CreateImageColor(0, 0, 0, 0))																			// .
SetSpriteOffset(player.imageSprite, (GetSpriteScaleX(player.imageSprite)/2) - 0.037, (GetSpriteScaleY(player.imageSprite)/2) + 0.385)	// .
SetSpritePositionByOffset(player.imageSprite, GetVirtualWidth()/2, GetVirtualHeight()/2)												// -

return

PlayerDeath:

if player.deathFlag = 0																		// No momento em que o jogador morreu...
	player.health = 0																		// .
	SetSpriteColor(player.imageSprite, 255, 255, 255, 255)									// .
	for enemyIndex = 0 to 10																// Todos os inimigos ficam parados em animação de descanso.
		PlaySprite(enemyImage[enemyIndex].ID, 5, 1, 1, 4)									// .
		SetSpriteColor(enemyImage[enemyIndex].ID, 255, 255, 255, 255)						// .
	next enemyIndex																			// .
	PlaySprite(player.imageSprite, 10, 0, playerDeathFirstFrame, playerDeathLastFrame)		// A animação de morte começa.
	deathTime = Timer()																		// .
endif																						// -
player.defaultSpeed# = 0																	// A velocidade do jogar se torna 0.


sgui.youDiedCurrentOppacity = sgui.youDiedCurrentOppacity + 4						// Uma mensagem de morte aparece lentamente.
SetSpriteColor(sgui.youDiedScreen, 255, 255, 255, sgui.youDiedCurrentOppacity)		// -

player.deathFlag = 1	// O jogador é considerado morto.

if deathTime <> 0 and Timer() >= deathTime + 3	// Após 3 segundos o jogo fecha.
	player.deathFlag = 0						// .
	deathTime = 0								// .
	end											// .
endif											// -

return
