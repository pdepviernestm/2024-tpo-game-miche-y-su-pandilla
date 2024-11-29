import wollok.game.*
import guido.*
import obstaculos.*

object guidoBird {
	var contador = 0
	var property tiempoAparicionPared = 3500
	var property velPared = 250

	method modificarVelPared(aumento) {
	  velPared = velPared + aumento
	}

	method contador1(){
		contador +=1
	}

	method iniciar() {
		game.width(26)
		game.height(26)
		game.cellSize(30)
		game.title('Guido Bird')
	}
	
	method play() {
		game.clear()
		guido.posicionInicial()
		obstaculoManager.inicioColeccion()
		self.iniciar()
		
		game.addVisual(fondo)
		game.addVisual(guido)
		
		// OBSTACULO
		obstaculoManager.getColeccion().forEach({
			obstaculo2 => obstaculo2.forEach({ 
				pared => game.addVisual(pared)
			})
		})
		
		// APRETO ESPACIO -> GUIDO VUELA
		keyboard.space().onPressDo({ guido.volar() })
				
		game.onTick(1000, 'contador en segundos', {
				self.contador1()
				game.say(guido, contador.toString())
		})
		
		// CREACION DE PAREDES CADA 3500
		game.onTick(tiempoAparicionPared, 'aparece pared', {
			obstaculoManager.render()

			//LLAMO AL CONTADOR DE GUIDO Y TIRE MSG

			if((contador%10)==0)
			{
				game.sound("sonidoVamos10.mp3").play()
			}
	
		})

		// caida de guido
		game.onTick(guido.velCaida(), 'caida', {
			guido.caida()
		})

		// IDEA PRINCIPAL (QUE FUNCIONA BIEN)
		 game.onTick(10000, 'aumenta velocidad de caida', {
		 guido.posicionCaida(2)

		 })
	
		game.onTick(20000, 'aumenta velocidad de las paredes', {
		 obstaculoManager.posicionMovimiento(2)
		 })

		
		// Movimiento de las paredes
		game.onTick(self.velPared(), 'velocidad de la pared', {
			obstaculoManager.getColeccion().forEach({ 
				obstaculo2 => obstaculo2.forEach({ 
					pared => obstaculoManager.manejoParedes(pared)
				})
			})
		})
	}
	
	method showMenu() {
		game.clear()	
		self.iniciar()
		game.addVisual(menu)
		obstaculoManager.restart()

		keyboard.x().onPressDo({ 
			game.clear()
			obstaculoManager.restart()
			guido.posicionCaida(1)
			obstaculoManager.posicionMovimiento(1)
			contador = 0
		    velPared = 250
			guido.velCaida(200)
			self.play()
		})		
	}	
}

object fondo{
	method image() = 'guidoAvion2.jpg'
	method position() = game.origin() 
}

object menu {
	method image() = 'menuGuido.png'
	method position() = game.origin()
}

