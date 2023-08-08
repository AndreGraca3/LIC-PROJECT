object KeyReceiver { // Recebe trama do Keyboard Reader.
    private val TxD_MASK = 1 shl 5      //entrada usbport
    private val TxCLK_MASK = 1 shl 6    //saida usbport

    // Inicia a classe
    fun init() {
        HAL.init()
    }
    // Recebe uma trama e retorna o código de uma tecla caso exista
    fun rcv(): Int {
        var result = -1
        var frame = 0
        if (!HAL.isBit(TxD_MASK)) {
            for (i in 0 .. 5) {
                HAL.setBits(TxCLK_MASK)
                Thread.sleep(1)
                frame = frame or HAL.readBits(TxD_MASK).shl(i)
                HAL.clrBits(TxCLK_MASK)
                Thread.sleep(1)
            }
            frame = frame.shr(5)
        if ((frame and 1) == 0) return -1
            if ((frame and (1 shl 5)) != 0) return -1
            result = frame.shr(1)
        }
        return result
    }
}

fun main() {
    KeyReceiver.init()
       while(true) {
           println(KeyReceiver.rcv())
           Thread.sleep(1000)
       }
}