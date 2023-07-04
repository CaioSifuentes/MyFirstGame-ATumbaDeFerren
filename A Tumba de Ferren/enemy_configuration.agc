EnemysVariables:

type enemyType 					// Atributos básicos do inimigo.
								// .
	ID as integer				// Seu identificador; onde o sprite é criado.
	health as integer			// Sua vida máxima.
	tribe as integer			// Sua tribo, ou seu tipo (se é um esqueleto, ou esqueleto, ou esqueleto porquê é o único inimigo que eu criei).
								// .
	targetPointX as float	 	// Seu objetivo de caminhada X.
	targetPointY as float	 	// Seu objetivo de caminhada Y.
	movementSpeed as float   	// Sua velocidade de movimento.
	isMovingFlag as integer 	// Flag para saber se o inimigo está se movendo ou não.
								// .
	attackTimer as float		// Timer para duração do ataque.
	collisionSprite as integer 	// Colisão do ataque.
								// .
	enemyDeathTimer as float 	// Timer para a duração dos restos mortais do inimigo.
	
	// Alguns atributos são especificos para a tribo do inimigo, como o 'health'.
	
endtype
global enemy as enemyType[15]	// Define um máximo de 15 inimigos simultâneos.

type enemyImageType							// Por organização, um segundo conjunto de atributos para a imagem dos inimigos.
											// .
	ID as integer							// O identificador da imagem; onde o sprite da imagem é criado
	tribe as integer						// Define o tipo de inimigo. Cada tribo possui um conjunto de animações e sprites diferentes.
	flipState as integer					// Define a direção que o inimigo está virado.
											// .
endtype										// .
global enemyImage as enemyImageType[15]		// -

DIM tribeHealth[5]		// Variavel para a vida de cada tribo (Atualmente só temos uma, ESQUELETOS).
tribeHealth[0] = 5		// Vida do Esqueleto: 10

return

CreateEnemysFunctions:

Function CreateEnemy(enemyTribe, enemyIndex, x, y)			// Função para criar o inimigo.
															// Primeiro parâmetro:            O inimigo é criado conforme sua tribo, atualmente 0 é o único, representando o Skeleton (Esqueleto).
															// Segundo parâmetro:             O indice do inimigo, indo de 1 até 15. Inimigos com indice 0 não podem ser criados para questões de funcionamento do jogo.
															// Terceiro e Quarto parâmetros:  As posições X e Y do inimigo no mapa.
														
	enemy[enemyIndex].tribe = enemyTribe					// Guarda o primeiro parâmetro nos atributos do inimigo.
	enemy[enemyIndex].health = tribeHealth[enemyTribe]		// Guarda a vida do inimigo em seus atributos.
	
	DeleteSprite(enemy[enemyIndex].ID)																								// Delete o sprite do inimigo com o mesmo indice que o que será criado.
	enemy[enemyIndex].ID = CreateSprite(CreateImageColor(155 + enemyTribe * 5, 255 - enemyTribe * 10, 255, 255))					// Cria o sprite de colisão do inimigo.
	SetSpriteScale(enemy[enemyIndex].ID, 40, 75)																					// .
	SetSpriteOffset(enemy[enemyIndex].ID, GetSpriteWidth(enemy[enemyIndex].ID)/2, GetSpriteHeight(enemy[enemyIndex].ID)/2 - 35)		// .
	SetSpriteShape(enemy[enemyIndex].ID, 2)																							// .
	SetSpriteVisible(enemy[enemyIndex].ID, 0)																						// -
																																	// 
	SetSpritePhysicsOn(enemy[enemyIndex].ID, 2)																						// Configura as físicas do inimigo.
	SetSpritePhysicsCanRotate (enemy[enemyIndex].ID, 0)																				// .
	SetSpritePhysicsFriction(enemy[enemyIndex].ID,0)																				// .
	SetSpritePhysicsRestitution(enemy[enemyIndex].ID,0.1)																			// .
	SetSpritePhysicsMass(enemy[enemyIndex].ID, 10000)																				// -
																																	// 
	SetSpritePosition(enemy[enemyIndex].ID, x, y)																					// Define o ponto inicial do inimigo
																																	// 
	CreateEnemyImage(enemy[enemyIndex].tribe, enemyIndex)																			// Chama a funçao para criar uma imagem do inimigo.
																																	// 
EndFunction													// -


Function CreateEnemyImage(enemyImageTribe, enemyImageIndex)		// Função para criar o inimigo.
																// Primeiro parâmetro:	A tribo do inimigo define sua imagem e suas animações.
																// Segundo parâmetro:   O indice do inimigo funciona como seu identificador.

	enemyImage[enemyImageIndex].ID = CreateSprite( 0 )																										// Cria o sprite da imagem do inimigo
	SetSpriteOffset(enemyImage[enemyImageIndex].ID, GetSpriteWidth(enemyImage[enemyImageIndex].ID)/2, GetSpriteHeight(enemyImage[enemyImageIndex].ID)/2)	// .
	SetSpriteShape(enemyImage[enemyImageIndex].ID, 1)																										// -

	if enemyImageTribe = 0											// Se o inimigo for um esqueleto...
		SkeletonAddAnimations(enemyImage[enemyImageIndex].ID)		// ... adiciona animações de esqueleto.
		SetSpriteScale(enemyImage[enemyImageIndex].ID, 0.7, 0.7)	// .
																	// .
	endif															// -


EndFunction														// -

return


EnemyLoop:

// Provavelmente a função mais complexa do jogo. Se resume em TODAS as ações de cada inimigo.
// Tendo em vista que o inimigo é um inteiro em um vetor, um 'FOR' viaja por esse vetor realizando as ações individualmente.

for enemyIndex = 0 to 10
	
	SetSpritePositionByOffset(enemyImage[enemyIndex].ID, GetSpriteXByOffset(enemy[enemyIndex].ID), GetSpriteYByOffset(enemy[enemyIndex].ID)) // Define a posição da imagem em cima do sprite do inimigo.
	
	if enemy[enemyIndex].tribe = 0		// Define que todas as ações abaixo são apenas tomadas por inimigos da tribo 0 (esqueletos).
		
		if enemy[enemyIndex].health > 0		// Realiza as ações abaixo apenas se o inimigo estiver vivo.
			
			enemyX# = GetSpriteXByOffset(enemy[enemyIndex].ID)													// Adquire o versor do vetor que está entre o ponto das cordenadas do jogador e do inimigo.
			enemyY# = GetSpriteYByOffset(enemy[enemyIndex].ID)													// .
			enemy[enemyIndex].targetPointX = GetSpriteXByOffset(player.ID)										// .
			enemy[enemyIndex].targetPointY = GetSpriteYByOffset(player.ID)										// .
			enemy[enemyIndex].movementSpeed = 3																	// .
																												// .
			travelVectorX# = enemy[enemyIndex].targetPointX - enemyX#											// .
			travelVectorY# = enemy[enemyIndex].targetPointY - enemyY#											// .
			travelMagnitude# = sqrt( (travelVectorX# * travelVectorX#) + (travelVectorY# * travelVectorY#) )	// .
			travelVectorX# = (travelVectorX# / travelMagnitude#) * enemy[enemyIndex].movementSpeed				// Cada componente deste versor é multiplicado pela velocidade do inimigo.
			travelVectorY# = (travelVectorY# / travelMagnitude#) * enemy[enemyIndex].movementSpeed				// .
			
			
			if travelMagnitude# > 110 and (GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) < 9 or GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) > 16)	// Se o inimigo estiver distante demais e não estiver realizar a animação de ataque...
				SetSpritePositionByOffset(enemy[enemyIndex].ID, enemyX# + travelVectorX#, enemyY# + travelVectorY#)											// ... ele se move na direção do jogador.
				if enemy[enemyIndex].isMovingFlag <> 1																										// .
					PlaySprite(enemyImage[enemyIndex].ID, 10, 1, 5, 8)																						// .
				endif																																		// .
				enemy[enemyIndex].isMovingFlag = 1																											// -
				
			elseif travelMagnitude# < 100 and (GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) < 9 or GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) > 16)	// Se o inimigo estiver próximo demais e não estiver realizar a animação de ataque...
				SetSpritePositionByOffset(enemy[enemyIndex].ID, enemyX# + travelVectorX# * -1, enemyY# + travelVectorY# * -1 )									// ... ele se move na direção contrário do jogador.
				if enemy[enemyIndex].isMovingFlag <> 1																											// .
					PlaySprite(enemyImage[enemyIndex].ID, 10, 1, 5, 8)																							// .
				endif																																			// .
				enemy[enemyIndex].isMovingFlag = 1																												// -
			
			
			else	// Ataque genérico do inimigo da tribo 0, realizado apenas quando o inimigo estiver parado adjacente ao jogador.
				if enemy[enemyIndex].attackTimer = 0
					if (GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) < 9 or GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) > 16)		// Apenas enquanto o inimigo não estiver atacando...
						PlaySprite(enemyImage[enemyIndex].ID, 10, 0, 9, 16)																	// ... inicia a animação de ataque.
						
						enemy[enemyIndex].collisionSprite = CreateSprite( CreateImageColor( 0, 0, 0, 0) )
						SetSpriteScale(enemy[enemyIndex].collisionSprite, 165, 150)																				 						 // Cria o sprite de colisão do ataque, define seu tamanho e seu ponto central.
						SetSpriteOffset(enemy[enemyIndex].collisionSprite, GetSpriteScaleX(enemy[enemyIndex].collisionSprite)/2, GetSpriteScaleY(enemy[enemyIndex].collisionSprite)/2)   // .
						SetSpriteVisible(enemy[enemyIndex].collisionSprite, 0)																					 						 // Define o sprite como invisvel e adiciona uma forma retângular a ele.
						SetSpriteShape(enemy[enemyIndex].collisionSprite, 2)																					 						 // -
						
						if 	enemyImage[enemyIndex].flipState = 0							   																							// Caso o inimigo esteja virado para a direita, ...
							SetSpritePositionByOffset(enemy[enemyIndex].collisionSprite, GetSpriteXByOffSet(enemy[enemyIndex].ID) + 75, GetSpriteYByOffSet(enemy[enemyIndex].ID))   	// ...o ataque é posicionado na direita.
						elseif enemyImage[enemyIndex].flipState = 180																													// Caso o inimigo esteja virado para a esquerda, ...
							SetSpritePositionByOffset(enemy[enemyIndex].collisionSprite, GetSpriteXByOffSet(enemy[enemyIndex].ID) - 75, GetSpriteYByOffSet(enemy[enemyIndex].ID))		// ...o ataque é posicionado na esquerda.
						endif																																							// -
			
					endif																													// -
					
					enemy[enemyIndex].attackTimer = Timer()
					
				elseif Timer() > enemy[enemyIndex].attackTimer + 0.7 and Timer() < enemy[enemyIndex].attackTimer + 0.75		// Em um pequeno periodo, se o jogador estiver colidindo com o ataque durante sua animação, ele perde vida.
					if GetSpriteCollision(player.ID, enemy[enemyIndex].collisionSprite) and player.resistenceFlag = 0		// .
						SetSpriteColor(player.imageSprite, 255, 0, 0, 255)													// .
						player.health = player.health - 1																	// .
						player.resistenceFlag = 1																			// -
					endif
					
				elseif Timer() > enemy[enemyIndex].attackTimer + 0.8			// Encerra o ataque
					SetSpriteColor(player.imageSprite, 255, 255, 255, 255)		// .
					DeleteSprite(enemy[enemyIndex].collisionSprite)				// .
					PlaySprite(enemyImage[enemyIndex].ID, 10, 1, 1, 4)			// .
					player.resistenceFlag = 0									// .
					enemy[enemyIndex].attackTimer = 0							// -
					
				endif
				
				enemy[enemyIndex].isMovingFlag = 0
				
			endif
			
			if (GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) < 9 or GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) > 16)		// -
				if GetSpriteXByOffset(player.ID) > GetSpriteX(enemy[enemyIndex].ID)													// Se o inimigo não estiver realizando nenhuma animação de ataque...
					enemyImage[enemyIndex].flipState = 0																			// .
				else																												// Muda a direção que ele está olhando baseado na posição X do jogador.
					enemyImage[enemyIndex].flipState = 180																			// .
				endif																												// .
			endif																													// -
			SetSpriteFlip(enemyImage[enemyIndex].ID, enemyImage[enemyIndex].flipState, 0)											// Muda a direção do inimigo para a direção definida.
			
			
			
			enemyX# = GetSpriteXByOffset(enemy[enemyIndex].ID)													// Adquire o versor do vetor que está entre o ponto das cordenadas do inimigo e de um outro inimigo.
			enemyY# = GetSpriteYByOffset(enemy[enemyIndex].ID)													// Esse trecho do código da uma impressão de inteligência ao inimigo e mais aleatoriedade do jogo.
			enemy[enemyIndex].targetPointX = GetSpriteXByOffset(enemy[enemyIndex + 1].ID)						// .
			enemy[enemyIndex].targetPointY = GetSpriteYByOffset(enemy[enemyIndex + 1].ID)						// .
			enemy[enemyIndex].movementSpeed = 3																	// .
																												// .
			travelVectorX# = enemy[enemyIndex].targetPointX - enemyX#											// .
			travelVectorY# = enemy[enemyIndex].targetPointY - enemyY#											// .
			travelMagnitude# = sqrt( (travelVectorX# * travelVectorX#) + (travelVectorY# * travelVectorY#) )	// .
			travelVectorX# = (travelVectorX# / travelMagnitude#) * enemy[enemyIndex].movementSpeed				// .
			travelVectorY# = (travelVectorY# / travelMagnitude#) * enemy[enemyIndex].movementSpeed				// -
			if travelMagnitude# < 200 and (GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) < 9 or GetSpriteCurrentFrame(enemyImage[enemyIndex].ID) > 16)	// Move o inimigo conforme o vetor encontrado, mantendo uma distância de 200'.
				SetSpritePositionByOffset(enemy[enemyIndex].ID, enemyX# + travelVectorX# * -0.5, enemyY# + travelVectorY# * -0.5 )							// .
			endif																																			// -
			
		endif
		
		
		if enemy[enemyIndex].health <= 0																							// Quando o inimigo chegar a 0 de vida...
			if GetSpriteCurrentFrame (enemyImage[enemyIndex].ID) < 17 or GetSpriteCurrentFrame (enemyImage[enemyIndex].ID) > 20		// Enquanto não estiver realizando animação de morte...
				SetSpriteColor(enemyImage[enemyIndex].ID, 255, 255, 255, 255)														// .
				PlaySprite(enemyImage[enemyIndex].ID, 10, 0, 17, 20)																// Ele apresenta esta animação, morrendo.
				SetSpritePhysicsOff(enemy[enemyIndex].ID)																			// .
																																	// .
				enemy[enemyIndex].enemyDeathTimer = Timer()																			// .
																																	// .
				if GetSpriteExists(enemy[enemyIndex].ID)																			// .
					player.enemyDeaths = player.enemyDeaths + 1																		// Matar o inimigo aumenta a quantidade de inimigos mortos.
				endif																												// .
																																	// .
			endif																													// -
			
			if Timer() > enemy[enemyIndex].enemyDeathTimer + 1		// Deleta todo o inimigo após 1 segundo morto.
				DeleteSprite ( enemyImage[enemyIndex].ID )			// .
				DeleteSprite ( enemy[enemyIndex].ID )				// .
				DeleteSprite ( enemy[enemyIndex].collisionSprite )	// .
			endif													// -
			
		endif																														// -
		
		
		if GetSpriteY(player.ID) > GetSpriteY(enemy[enemyIndex].ID) + GetSpriteHeight(enemy[enemyIndex].ID)		// Caso o jogador esteja na frente do inimigo, posiciona ele atrás...
			SetSpriteDepth(enemyImage[enemyIndex].ID, GetSpriteDepth(player.imageSprite) + 1)					// .
		else																									// Caso o jogador esteja atrás do inimigo, posiciona ele na frente...
			SetSpriteDepth(enemyImage[enemyIndex].ID, GetSpriteDepth(player.imageSprite) - 1)					// .
		endif																									// -


	endif	// Termina as ações da tribo 0.
	
next enemyIndex		// Passa para o próximo inimigo.

return



