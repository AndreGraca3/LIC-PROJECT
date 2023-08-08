import isel.leic.utils.Time

object KBD { // Ler teclas. Métodos retornam ‘0’..’9’,’#’,’*’ ou NONE.
    const val NONE = -1;
    // Inicia a classe
    fun init() {
    KeyReceiver.init()
    }

    // Implementa a interação série com o Key Transmitter, utilizado na 2ªfase do projeto
    private fun getKeySerial(): Char {
        val key = KeyReceiver.rcv()
        return when(key) {
            0 -> '1'
            1 -> '4'
            2 -> '7'
            3 -> '*'
            4 -> '2'
            5 -> '5'
            6 -> '8'
            7 -> '0'
            8 -> '3'
            9 -> '6'
            10 -> '9'
            11 -> '#'
            else -> NONE.toChar()
        }
    }
    // Retorna de imediato a tecla premida ou NONE se não há tecla premida.
    fun getKey(): Char {
      return getKeySerial()
    }
    // Retorna quando a tecla for premida ou NONE após decorrido ‘timeout’ milisegundos.
    fun waitKey(timeout: Long): Char {
    val timeinit = Time.getTimeInMillis()
        while (Time.getTimeInMillis() - timeinit < timeout) {
            val key = getKeySerial()
            if (key != NONE.toChar()){
                return key
            }
        }
        return NONE.toChar()
    }

}

fun main() {
    KBD.init()
    println(KBD.waitKey(5000))
}