import camion.*
object knightRider {
	method peso() = 500 
	method peligrosidad() = 10 
	method bultosUsados() = 1
	method efectoPorAccidente() {}
}

object arenaGranel {
	var property peso = 0
	const property peligrosidad = 1
	
	method bultosUsados() = 1
	
	method efectoPorAccidente(){
		peso = peso + 20
	}
}

object bumblebee {
	const property peso = 800
	var property estadoTransformado = ""
	method bultosUsados() = 2
	
	method peligrosidad() {
		return if(estadoTransformado == "auto"){
						15
				}else{
					30
				}
	}

	method efectoPorAccidente(){
		if(estadoTransformado == "auto"){
			self.estadoTransformado("robot")
		}else{
			self.estadoTransformado("auto")
		}
	}

}

object paqueteLadrillos {
	var property cantLadrillos = 0
	const property peligrosidad = 2 

	method peso() = self.cantLadrillos() * 2

	method bultosUsados(){
		return 	if(cantLadrillos <= 100){ 1}
				else if(cantLadrillos <= 300){2}
				else{3}
	}

	method efectoPorAccidente(){
		if(cantLadrillos > 12){
			cantLadrillos = cantLadrillos - 12
		}else{
			cantLadrillos = 0
		}
	}

}

object bateriaAntiaerea {
	var property estaCargada = true 
	

	method peligrosidad() {
		return if(self.peso() == 300){
			100
		}else{
			0
		}
	}

	method peso() {
		return if(estaCargada){ 300 }else{ 200}
	}

	method bultosUsados(){
		return if(estaCargada){
			2
		}else{
			1
		}
	}

	method efectoPorAccidente(){
		estaCargada = false
	}


}

object residuosRadiactivos{
	var property peso = 0
	const property peligrosidad = 200
	method bultosUsados() = 1

	method efectoPorAccidente(){
		peso = peso + 15
	}
}


object contenedorPortuario {
	const property cosas = #{}
	
	method cargar(cosa) {
		cosas.add(cosa)
	}

	method peso() = cosas.sum{ cosa => cosa.peso()} + 100

	method peligrosidad() = cosas.map{
		cosa => cosa.peligrosidad()
	}.maxIfEmpty({0})

	method bultosUsados() = cosas.sum{cosa => cosa.bultosUsados()} + 1

	method efectoPorAccidente(){
		cosas.forEach{
			elemento => elemento.efectoPorAccidente()
		}
	}

}

object embalajeDeSeguridad {
	var property cosaEmbalada = ""
	method bultosUsados() = 2
	method peso() = cosaEmbalada.peso()
	method peligrosidad() = cosaEmbalada.peligrosidad() / 2

	method efectoPorAccidente(){ }

}


object ruta9 {
	const property peligrosidad = 20

	method puedeCircular() = not camion.estaExcedido() && not camion.cosas().any{
		cosa => cosa.peligrosidad() > self.peligrosidad() }
}

object caminosVecinales {
	var property pesoPermitido = 0 

	method puedeCircular() = 	pesoPermitido > camion.cosas().sum{
								cosas => cosas.peso()
								}
}