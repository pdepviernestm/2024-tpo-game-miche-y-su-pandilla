import wollok.game.*
import guido.*
import obstaculos.*

object guidoBird {
	var contador = 0
	var property tiempoAparicionPared = 3500
	// var property contadorGuido = 0
	// var property contadorPared = 0
	var property velPared = 250

	method modificarVelPared(aumento) {
	  velPared = velPared + aumento
	}

	// method sumarContGuido() {
	// 	contadorGuido += 1
	// }

	// method sumarContPared() {
	// 	contadorPared += 1
	  
	// }

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
		obstaculo.inicioColeccion()
		self.iniciar()
		
		game.addVisual(fondo)
		game.addVisual(guido)
		
		// OBSTACULO
		obstaculo.getColeccion().forEach({
			obstaculo2 => obstaculo2.forEach({ 
				pared => game.addVisual(pared)
			})
		})
		
		// APRETO ESPACIO -> GUIDO VUELA
		keyboard.space().onPressDo({ guido.volar() })
				
		// CREACION DE PAREDES CADA 3500
		game.onTick(tiempoAparicionPared, 'aparece pared', {
			obstaculo.render()
			// self.sumarContPared()

			//LLAMO AL CONTADOR DE GUIDO Y TIRE MSG
			self.contador1()
			game.schedule(0, { game.say(guido, contador.toString() )})

			if((contador%10)==0)
			{
				game.sound("sonidoVamos10.mp3").play()
			}
	
		})


		// contador de guido
		game.schedule(3500, { game.say(guido, contador.toString() )})
		// caida de guido
		game.onTick(guido.velCaida(), 'caida', {
			guido.caida()
		})

// IDEA PRINCIPAL (QUE NO FUNCIONA BIEN)
		// game.onTick(17500, 'aumenta velocidad de caida', {
		// 	guido.fallSpeed(100)
			
		// })
		

		//  game.onTick(17500, 'aumenta velocidad de caida', {
		//  //	variable.modificarVelPared(-100)
		//  	self.modificarVelPared(-100)
		//  })	

			// Movimiento de las paredes
		game.onTick(self.velPared(), 'velocidad de la pared', {
			obstaculo.getColeccion().forEach({ 
				obstaculo2 => obstaculo2.forEach({ 
					pared => obstaculo.manejoParedes(pared)
				})
			})
		})
	}
	
	method showMenu() {
		game.clear()	
		self.iniciar()
		game.addVisual(menu)
		obstaculo.restart()

		keyboard.x().onPressDo({ 
			game.clear()
			obstaculo.restart()
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

