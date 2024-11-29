import wollok.game.*
import guido.*
import centralGuido.*

class Obstaculo {
	var property pos // Posicion
	var property hb // hitBox
	const image = 'microObstaculo.png'
	
	method image() = image
	method position() = pos
	method position(newPosition) { pos = newPosition }
	method hb() = hb
}

object obstaculoManager {
	
	const paredesIniciales = [[]]
	var coleccion = paredesIniciales
	var property posicionMovimiento = 1

	// POSICION OBSTACULO ARRIBA Y ABAJO
	const obstaclesPositions = [ 
	//  ARRIBA  ABAJO 
		[19,  -25],
		[70,  10],
		[8,    75],
	    [15,  -23],
		[10,    70],
		[12,  -26],
		[20,    -20],
		[19,    -20]
	]
	
	method getColeccion() = coleccion
	method inicioColeccion() = { coleccion = paredesIniciales }
		
	method render() {
		const ejeY = obstaclesPositions.anyOne()
		const paredSup = ejeY.first()
		const paredInf = ejeY.last()
		
		const obstaculoNuevo = [
			// Parte de arriba
			new Obstaculo(pos = game.at(25, paredSup), hb = (paredSup..30) ),
 			// Parte de abajo
			new Obstaculo(pos = game.at(25, paredInf), hb = (paredInf..paredInf+33) )
		]
		
		coleccion.add(obstaculoNuevo)
		obstaculoNuevo.forEach({ pared => game.addVisual(pared) })
	}
	
	method manejoParedes(pared) {
		const posX = pared.position().x()
		const posY = pared.position().y()
		
		// realiza el movimiento de las paredes
		pared.position(game.at(posX - posicionMovimiento, posY))
		
		// se remueven los microfonos cuando no se ven mas del lado de la izq
		if(posX == -3) {
			game.removeVisual(pared)
		}
		
		// muerte de guido cuando choca con los microfonos o con los bordes
		if(guido.position().x() == posX && pared.hb().contains(guido.position().y()) // paredes
			|| (-1 == guido.position().y()) || (guido.position().y() > 25)) {  //FUERA DEL MAPA
				game.sound("sonidoMuerte.mp3").play()
				game.clear()
				guidoBird.showMenu()
		}	
	}
	
	method restart() {
		paredesIniciales.clear()
		paredesIniciales.add(
			[
				new Obstaculo(pos = game.at(25, 16), hb = (16..25)), 
				new Obstaculo(pos = game.at(25, -25), hb = (-25..8))
			]
		)
	}
}