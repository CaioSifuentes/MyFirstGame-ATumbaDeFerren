// Sub rotina para realizar o ataque do jogador quando o botão esquerdo do mouse for apertado.
PlayerAttack:

if GetPointerPressed()     // Ao clicar com o mouse...
	if attackTimer#  = 0   // ... se um ataque já não estiver acontecendo.
	
		ATTACK_DURATION#  = 0.5		  // Define a constante de duração do ataque em segundos.
		attackTimer#      = Timer()   // Pega os segundos em que o ataque foi feito.
		
		// Animação:
		if GetPointerX() > GetSpriteXByOffset(player.ID)       // -
			flipState = 0								       // .
		elseif GetPointerX()<= GetSpriteXByOffset(player.ID)   // Define a posição que o jogador está olhando para a posição do mouse na tela.
			flipState = 180                                    // .
		endif                                                  // -
	
		player.generalAnimationFlag  = 1   // Indica que o jogador está realizando uma animação.
		player.attackAnimationFlag   = 1   // Indica que o jogador está atacando (animação).
		player.defaultSpeed#         = 0   // Reduz a velocidade do jogador enquanto ele ataca.
		
		if defineAnimation      = 0																  // -
			PlaySprite(player.imageSprite, 10, 0, firstAttackFirstFrame, firstAttackLastFrame)	  // .
			defineAnimation  = 1																  // .
		elseif defineAnimation  = 1																  // Troca entre as duas animações de ataque.
			PlaySprite(player.imageSprite, 8, 0, secondAttackFirstFrame, secondAttackLastFrame)   // .
			defineAnimation  = 0                                                                  // .
		endif                                                                                     // -
	
		// Colisão:
		attackCollisionSprite = CreateSprite(CreateImageColor(255, 25, 255, 255))													 // -	
		SetSpriteScale(attackCollisionSprite, 130, 100)																				 // Cria o sprite de colisão do ataque, define seu tamanho e seu ponto central.
		SetSpriteOffset(attackCollisionSprite, GetSpriteScaleX(attackCollisionSprite)/2, GetSpriteScaleY(attackCollisionSprite)/2)   // .
		SetSpriteVisible(attackCollisionSprite, 0)																					 // Define o sprite como invisvel e adiciona uma forma retângular a ele.
		SetSpriteShape(attackCollisionSprite, 2)																					 // -
		
		if flipState = 0																												// Caso o jogador esteja virado para a direita, ...
			SetSpritePositionByOffset(attackCollisionSprite, GetSpriteXByOffSet(player.ID) + 110, GetSpriteYByOffSet(player.ID) - 30)   // ...o ataque é posicionado na direita.
		elseif flipState = 180																											// Caso o jogador esteja virado para a esquerda, ...
			SetSpritePositionByOffset(attackCollisionSprite, GetSpriteXByOffSet(player.ID) - 110, GetSpriteYByOffSet(player.ID) - 30)	// ...o ataque é posicionado na esquerda.
		endif																															// -
		
	endif
	
	
	
endif

if Timer() >= (attackTimer# + ATTACK_DURATION#)   // Após uma quantidade de segundos definida por ATTACK_DURATION se passar...
	attackTimer#                 = 0			  // o timer é definido para 0, assim, é considerado que o jogador não está mais realizando um ataque.
	player.generalAnimationFlag  = 0			  // Indica que o jogador não está mais realizando uma animação.

	if player.attackAnimationFlag  = 1   // Ao fim do ataque...
		
		// Animação:
		PlaySprite(player.imageSprite, 4, 1, 1, 5)   // A animação 'idle' é realizada.
		player.defaultSpeed#  = 6			     	 // Retorna a velocidade do jogador para o padrão.

		player.movingAnimationFlag  = 0	   // Indica que o jogador está pronto para iniciar a animação de movimento.
		player.attackAnimationFlag  = 0	   // Indica que o jogador não está mais atacando (animação).
		
		// Colisão:
		DeleteSprite(attackCollisionSprite)   // O sprite de colisão do ataque é apagado.
		
		for enemyIndex = 0 to 10
			SetSpriteColor(enemyImage[enemyIndex].ID, 255, 255, 255, 255)
		next enemyIndex
		
	endif
endif

if (Timer() > attackTimer# + 0.2 and Timer() < attackTimer# + 0.23) and attackTimer# <> 0
	for enemyIndex = 0 to 10
		if GetSpriteCollision(enemy[enemyIndex].ID, attackCollisionSprite)
			if enemy[enemyIndex].health > 0
				SetSpriteColor(enemyImage[enemyIndex].ID, 255, 0, 0, 255)
				enemy[enemyIndex].health = enemy[enemyIndex].health - 1
			endif
		endif
	next enemyIndex
endif

return
