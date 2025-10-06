import camion.*
import cosas.*



object almacen{
    const property cosasAlmacen = []
    
    method almacenar() {
        camion.cosas().forEach{
            cosa => cosasAlmacen.add(cosa)
                    camion.descargar(cosa)
        }
    }
}