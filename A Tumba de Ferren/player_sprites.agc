CallPlayerAnimations:

// Animação do jogador parado.
#constant idleFirstFrame = 1
#constant idleLastFrame = 10

SetFolder( "/" )
SetFolder( "media" )
SetFolder( "playerAnimations" )
SetFolder( "idle" )
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_1.png" ) )     // 1
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_2.png" ) )     // 2
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_3.png" ) )     // 3
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_4.png" ) )     // 4
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_5.png" ) )     // 5
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_6.png" ) )     // 6
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_7.png" ) )     // 7
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_8.png" ) )     // 8
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_9.png" ) )     // 9
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "idle_10.png" ) )    // 10


// Animação do jogador correndo
#constant runningFirstFrame = 11
#constant runningLastFrame = 20

SetFolder( "/" )
SetFolder( "media" )
SetFolder( "playerAnimations" )
SetFolder( "running" )
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_1.png" ) )   // 11  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_2.png" ) )   // 12
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_3.png" ) )   // 13
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_4.png" ) )   // 14
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_5.png" ) )   // 15
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_6.png" ) )   // 16
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_7.png" ) )   // 17
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_8.png" ) )   // 18
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_9.png" ) )   // 19
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "running_10.png" ) )  // 20


// Animação do jogador atacando (1)
#constant firstAttackFirstFrame = 21
#constant firstAttackLastFrame = 26

SetFolder( "/" )
SetFolder( "media" )
SetFolder( "playerAnimations" )
SetFolder( "attacks" )
SetFolder( "attack1" )
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack_1.png" ) )   // 21  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack_2.png" ) )   // 22
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack_3.png" ) )   // 23
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack_4.png" ) )   // 24
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack_5.png" ) )   // 25
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack_6.png" ) )   // 26


// Animação do jogador atacando (2)
#constant secondAttackFirstFrame = 27
#constant secondAttackLastFrame = 30

SetFolder( "/" )
SetFolder( "media" )
SetFolder( "playerAnimations" )
SetFolder( "attacks" )
SetFolder( "attack2" )
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack2_1.png" ) )   // 27  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack2_2.png" ) )   // 28
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack2_3.png" ) )   // 29
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "attack2_4.png" ) )   // 30


// Animação do jogador sendo atacado
#constant playerDeathFirstFrame = 31
#constant playerDeathLastFrame = 40

SetFolder( "/" )
SetFolder( "media" )
SetFolder( "playerAnimations" )
SetFolder( "death" )
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_1.png" ) )   // 31  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_2.png" ) )   // 32 
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_3.png" ) )   // 33  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_4.png" ) )   // 34  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_5.png" ) )   // 35  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_6.png" ) )   // 36 
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_7.png" ) )   // 37  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_8.png" ) )   // 38  
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_9.png" ) )   // 39 
AddSpriteAnimationFrame ( player.imageSprite, LoadImage ( "death_10.png" ) )  // 40  

return
