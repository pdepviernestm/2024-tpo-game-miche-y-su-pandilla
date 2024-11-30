import wollok.game.*
import obstaculos.*

object guido {
	var property velCaida = 200
	var image = 'guido3.png'
	var position = game.at(12,10)
	var property posicionCaida = 1

	method image() = image
	method position() { return position }
	method position(newPosition) { position = newPosition }

	method posicionInicial() { position = game.at(12,10) }
	
	method caida() {
		self.position(game.at(position.x(), position.y() - posicionCaida))
		image = 'guido3.png'
	}
	
	method volar() {
		self.position(game.at(position.x(), position.y() + 3))
		image = 'guido3.png'
	}

}
