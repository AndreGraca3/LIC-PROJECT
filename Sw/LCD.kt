import isel.leic.UsbPort

fun main(){
    LCD.init()
    LCD.write("ola")
}

object LCD { // Escreve no LCD usando a interface a 8 bits.
    private const val LINES = 2
    private const val COLS = 16; // Dimensão do display.
    private val twoline8bits = 56
    private val sleepCMD = 48

        // Escreve um byte de comando/dados no LCD em série
    private fun writeByteSerial(rs: Boolean, data: Int) {
    val rs = if(rs) 1 else 0
        val finaldata = rs or data.shl(1)
        SerialEmitter.send(SerialEmitter.Destination.LCD,finaldata)
    }
    // Escreve um byte de comando/dados no LCD
    private fun writeByte(rs: Boolean, data: Int) {
    writeByteSerial(rs, data)
    }
    // Escreve um comando no LCD
    private fun writeCMD(data: Int) {
    writeByte(false, data)
    }
    // Escreve um dado no LCD
    private fun writeDATA(data: Int) {
    writeByte(true, data)
    }
    // Envia a sequência de iniciação para comunicação a 8 bits.
    fun init() {
        Thread.sleep(50)
        writeCMD(sleepCMD)
        Thread.sleep(5)
        writeCMD(sleepCMD)
        Thread.sleep(1)
        writeCMD(sleepCMD)
        writeCMD(twoline8bits)
        writeCMD(8)
        writeCMD(1)
        writeCMD(6)
        writeCMD(15)
    }
    // Escreve um caráter na posição corrente.
    fun write(c: Char) {
    writeDATA(c.code)
    }
    // Escreve uma string na posição corrente.
    fun write(text: String) {
        for (i in text.indices) {
            write(text[i])
        }
    }
    // Envia comando para posicionar cursor (‘line’:0..LINES-1 , ‘column’:0..COLS-1)
    fun cursor(line: Int, column: Int) {
    var jump = 128 or line.shl(6) or column
        writeCMD(jump)
    }
    // Envia comando para limpar o ecrã e posicionar o cursor em (0,0)
    fun clear() {
    writeCMD(1)
    }
}