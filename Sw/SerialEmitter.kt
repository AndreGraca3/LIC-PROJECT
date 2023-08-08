fun main(args: Array<String>) {
    SerialEmitter.init()
    SerialEmitter.send(SerialEmitter.Destination.TICKET_DISPENSER,335) //1 101001111 parity bit = 1 TEST ONLY
}
object SerialEmitter {

    enum class Destination {
        LCD, TICKET_DISPENSER
    }

    private val nSS_MASK = 1 shl 2

    private val SDX_MASK = 1 shl 1

    private val SCLK_MASK = 1

    private val BUSY_MASK = 1

    private var FRAME_LENGTH = 10

    fun init () {   //inicia classe e mete respetivos bits a estado inicial
        HAL.init()
        HAL.setBits(nSS_MASK)
    }

    fun send(addr: Destination, data: Int) {
    var send_MASK = 0

        while (isBusy()) {
        }

        var mMask = 0

        if (addr == Destination.LCD) {
            mMask = 0
        }   else if (addr == Destination.TICKET_DISPENSER) {
            mMask = 1
        }

        send_MASK = mMask or data.shl(1)  //juntar data e destino
        val parityMask = if (!parityCheck(send_MASK)) 1 shl FRAME_LENGTH else 0
       // send_MASK = send_MASK shl 1
        //se sendMask for impar o meu parity bit ira ser 1 para os 11 bits ficarem par
        send_MASK = send_MASK or parityMask

        HAL.clrBits(nSS_MASK)   //inicia o serial receiver para receber bits

        for (i in 0 .. FRAME_LENGTH) {    //mandar SDX respetivo para placa
            if (send_MASK and (1 shl i) != 0){
              //  print(1)
                HAL.setBits(SDX_MASK)
            } else {
              //  print(0)
                HAL.clrBits(SDX_MASK)
            }
            HAL.clrBits(SCLK_MASK)
            Thread.sleep(1)
            HAL.setBits(SCLK_MASK)
            Thread.sleep(1)
        }
        HAL.setBits(nSS_MASK)   //acabo transmissao para serial receiver
    }

    private fun parityCheck(data: Int): Boolean {
        var numOnes = 0
        var tempMASK = 1
        for (i in 0 until FRAME_LENGTH) {
            if (data and tempMASK != 0) numOnes ++
            tempMASK = tempMASK shl 1
        }
        return numOnes % 2 == 0
    }

    /** Retorna true se o canal série estiver ocupado  */
    fun isBusy(): Boolean {
        return HAL.isBit(BUSY_MASK)
    }
}