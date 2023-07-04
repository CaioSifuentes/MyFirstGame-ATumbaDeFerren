CallEnemySprites:

// Cada Inimigo possui funções separadas de sprites. Assim quando um inimigo é criado, a função especifica para seu tipo é chamada.
// Atualmente possuimos um total de 1 inimigo. Esqueletinho é perfeito.

Function SkeletonAddAnimations(enemyID)
	
// Animação do inimigo (esqueleto) parado.
SetFolder( "/" )
SetFolder( "media" )
SetFolder( "enemyAnimations" )
SetFolder( "skeleton" )
SetFolder( "idle" )
AddSpriteAnimationFrame ( enemyID, LoadImage ( "idle_1.png" ) )     // 1
AddSpriteAnimationFrame ( enemyID, LoadImage ( "idle_2.png" ) )     // 2
AddSpriteAnimationFrame ( enemyID, LoadImage ( "idle_3.png" ) )     // 3
AddSpriteAnimationFrame ( enemyID, LoadImage ( "idle_4.png" ) )     // 4


// Animação do inimigo (esqueleto) se movendo.
SetFolder( "/" )
SetFolder( "media" )
SetFolder( "enemyAnimations" )
SetFolder( "skeleton" )
SetFolder( "walk" )
AddSpriteAnimationFrame ( enemyID, LoadImage ( "walk_1.png" ) )     // 5
AddSpriteAnimationFrame ( enemyID, LoadImage ( "walk_2.png" ) )     // 6
AddSpriteAnimationFrame ( enemyID, LoadImage ( "walk_3.png" ) )     // 7
AddSpriteAnimationFrame ( enemyID, LoadImage ( "walk_4.png" ) )     // 8


// Animação do inimigo (esqueleto) atacando.
SetFolder( "/" )
SetFolder( "media" )
SetFolder( "enemyAnimations" )
SetFolder( "skeleton" )
SetFolder( "attack" )
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_1.png" ) )     // 9
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_2.png" ) )     // 10
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_3.png" ) )     // 11
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_4.png" ) )     // 12
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_5.png" ) )     // 13
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_6.png" ) )     // 14
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_7.png" ) )     // 15
AddSpriteAnimationFrame ( enemyID, LoadImage ( "attack_8.png" ) )     // 16


// Animação do inimigo (esqueleto) morrendo.
SetFolder( "/" )
SetFolder( "media" )
SetFolder( "enemyAnimations" )
SetFolder( "skeleton" )
SetFolder( "death" )
AddSpriteAnimationFrame ( enemyID, LoadImage ( "edeath_1.png" ) )     // 17
AddSpriteAnimationFrame ( enemyID, LoadImage ( "edeath_2.png" ) )     // 18
AddSpriteAnimationFrame ( enemyID, LoadImage ( "edeath_3.png" ) )     // 19
AddSpriteAnimationFrame ( enemyID, LoadImage ( "edeath_4.png" ) )     // 20

EndFunction

return
