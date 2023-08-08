fun main(){
    TicketDispenser.init()
    TicketDispenser.print(6,8,true) // (1) 1000 0110 1 1   861 nos displays
}

object TicketDispenser {
    // Inicia a classe, estabelecendo os valores iniciais.
    fun init() {
    SerialEmitter.init()
    }
    // Envia comando para imprimir e dispensar um bilhete
    fun print(destinyId: Int, originId: Int, roundTrip: Boolean) {
       val RT:Int
        if (roundTrip) RT = 1 else RT = 0
        var data = RT or destinyId.shl(1) or originId.shl(5) //meter bits na posição final para enviar
        SerialEmitter.send(SerialEmitter.Destination.TICKET_DISPENSER, data)
    }
}