Type staticGUIType						// Agrupa todas as variaveis de sprite em que não há alteração conforme atributos do jogador.
										// .
	backPaper as integer				// Sprite de fundo do GUI.
	staticItens as integer				// Sprite de elementos estáticos do GUI.
										// .
	staminaBlock as integer				// Sprite para indicar que a energia do jogador não pode aumentar em certo ponto.
	lifeBlock as integer				// Sprite para indicar que a vida do jogador não pode aumentar em certo ponto.
										// .
	youDiedScreen as integer			// Sprite de mensagem de morte do jogador.
	youDiedCurrentOppacity as integer	// Variavel para definir a opacidade da mensagem de morte do jogador, criando um efeito de animação.
										// .
EndType									// .
global sgui as staticGUIType			// -

Type variableGUIType				// Agrupa todas as variaveis de sprite em que há alteração conforme os atributos do jogador.
									// .
	life as integer					// .
	stamina as integer				// .
									// .
EndType								// .
global vgui as variableGUIType[4]	// -

StartGUI:

DeleteSprite(sgui.backPaper)		// Deleta todas as sprites do GUI (e define a opacidade de morte para 0 novamente, seu valor inicial).
DeleteSprite(sgui.staticItens)		// .
DeleteSprite(sgui.staminaBlock)		// .
DeleteSprite(sgui.lifeBlock)		// .
DeleteSprite(sgui.youDiedScreen)	// .
sgui.youDiedCurrentOppacity = 0		// .
for i = 0 to 3						// .
	DeleteSprite(vgui[i].life)		// .
	DeleteSprite(vgui[i].stamina)	// .
next i								// -


SetFolder( "/" )							// -
SetFolder( "media" )						// Carrega a pasta onde estão as imagens do GUI.
SetFolder( "GUI" )							// -

sgui.backPaper = CreateSprite( LoadImage( "GUIPaper.png" ) )						// Cria todas as sprites do GUI e define a mensagem de morte como invisivel. 
sgui.staticItens = CreateSprite( LoadImage( "StaticItens.png" ) )					// .
sgui.staminaBlock = CreateSprite ( LoadImage ( "staminaBlock.png" ) )				// .
sgui.lifeBlock = CreateSprite ( LoadImage ( "lifeBlock.png" ) )						// .
sgui.youDiedScreen = CreateSprite ( LoadImage ( "youDied.png" ) )					// .
SetSpriteColor(sgui.youDiedScreen, 255, 255, 255, sgui.youDiedCurrentOppacity)		// .
for i = 0 to 3																		// .
vgui[i].life = CreateSprite( LoadImage( "life_" + str( i ) + ".png" ) )				// .
vgui[i].stamina = CreateSprite( LoadImage( "stamina_" + str( i ) + ".png" ) )		// .
next i																				// -

// Classes podem existir quando o jogo estiver completo, sendo delimitadas da seguinte maneira:
// 0 - Sem classe. 1 - Bastião. 2 - Determinado. 3 - Pés Leves.

return

UpdateGUI:								// A subrotina de UpdateGUI funciona em tempo real, em loop, atualizando as informações mutaveis do GUI.

for i = 0 to 3							// Torna os sprites de vida e energia invisivei
SetSpriteVisible(vgui[i].life, 0)		// .
SetSpriteVisible(vgui[i].stamina, 0)	// .
next i									// -

SetSpriteVisible(vgui[player.health].life, 1) 		// Torna apenas o sprite equivalente a vida e estamina do jogador como visiveis.
SetSpriteVisible(vgui[player.stamina].stamina, 1) 	// -

return
