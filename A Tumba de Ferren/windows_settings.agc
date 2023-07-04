WindowSettings:							// Sub rotina das configurações básicas da tela do jogo
										// .
SetWindowTitle( "A Tumba de Ferren" )	// Define o nome da janela.
SetWindowSize( 1847, 1013, 0 )			// Define o tamanho da janela (atualmente, o mesmo tamanho da imagem das paredes).
SetWindowAllowResize( 0 )				// Define que o tamanho da janela não pode ser alterado.
										// .
SetVirtualResolution( 1847, 1013 ) 		// Define a resolução da tela visivel ao jogador (atualmente, o mesmo tamanho da janela).
SetSyncRate( 60, 0 ) 					// Define o SyncRate do jogo. O jogo inteiro foi se baseado em 60 FPS, que surge no SyncRate 100.
SetScissor( 0,0,0,0 ) 					// Torna o full screen possível (por mais que não seja usado).
										// .
return									// -
