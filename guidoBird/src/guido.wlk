import wollok.game.*
import obstaculos.*

object guido {
	var property velCaida = 200
	var image = 'guido3.png'
	var position = game.at(12,10)
	
	method image() = image
	method position() { return position }
	method position(newPosition) { position = newPosition }
	method velCaida() = velCaida
	
	method aumentarVelCaida(aumento) {
	  velCaida = velCaida + aumento
	}

	method posicionInicial() { position = game.at(12,10) }
	
	method caida() {
		self.position(game.at(position.x(), position.y() - 1))
		image = 'guido3.png'
	}
	
	method volar() {
		self.position(game.at(position.x(), position.y() + 3))
		image = 'guido3.png'

	}

		
}
