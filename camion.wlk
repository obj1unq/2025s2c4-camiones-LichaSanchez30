import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000
	
	method cargar(unaCosa) {
		self.validadSiSePuedeCargar(unaCosa)
		cosas.add(unaCosa)
	}

	method sePuedeCargar(unaCosa) = not cosas.contains(unaCosa) 

	method validadSiSePuedeCargar(unaCosa) {
		if(not self.sePuedeCargar(unaCosa)){
			self.error("Maquina, ya cargastes a " + unaCosa)
		}
	}


	method descargar(unaCosa) {
		self.validarQueSePuedaDescargar(unaCosa)
		cosas.remove(unaCosa)
	}


	method sePuedeDescargar(unaCosa) = cosas.contains(unaCosa)

	method validarQueSePuedaDescargar(unaCosa) {
		if(not self.sePuedeDescargar(unaCosa)){
			self.error("Maquina, ya descargaste a " + unaCosa)
		}
	}

	method cargaTodoPesoPar() = cosas.all{carga => carga.peso().even()}

	method hayCargaQuePese_(kg) = cosas.any{ elemento => elemento.peso() == kg}

	method estaExcedido() = cosas.sum{carga => carga.peso()} + tara > 2500

	method cargaConNivelDePeligrosidadIgualA_(nivel) = cosas.find{
		carga => carga.peligrosidad() == nivel
	}
	
	method cosasQueSuperanPeligrosidad(nivelDePeligrosidad) =
		cosas.filter{elemento => elemento.peligrosidad() > nivelDePeligrosidad}

	method cosaMasPeligrosaQue(cosa) = self.cosasQueSuperanPeligrosidad(cosa.peligrosidad())

	method hayCosaQuePeseEntre_Y_(min, max) = cosas.any{
		cosa => cosa.peso().between(min, max)
	}
	
	method cosaMasPesadaCargada() = cosas.maxIfEmpty({
		cosa => cosa.peso()}, {self.validarSiElCamionEstaCargado()})
	
	method validarSiElCamionEstaCargado() {
		if(cosas.size() < 1){
			self.error("Maquina el camion esta vacio")
		}
	}

	method puedeCircular() = not self.estaExcedido() && not cosas.any{
		cosa => cosa.peligrosidad() > ruta.peligrosidad()
	}
	
	method pesoDeLasCosas() = cosas.map{
		cosa => cosa.peso()
	}

	method totalDeBultos() = cosas.sum{
		cosa => cosa.bultosUsados()
	}

	method cantidadDeBultos() = cosas.map{
		cosa => cosa.bultosUsados()
	}

	method sufreAccidente() {
		cosas.forEach{
			cosa => cosa.efectoPorAccidente()
		}
	}

}
