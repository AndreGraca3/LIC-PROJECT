import isel.leic.UsbPort

fun main(){
    HAL.init()
    Thread.sleep(2000) //tempo para abrir janela TEST ONLY
    HAL.setBits(4)
    Thread.sleep(2000)
    HAL.clrBits(4)
    Thread.sleep(2000)
    HAL.writeBits(0x0f, 2)
    print(HAL.isBit(2))
}
/*
* @since 08-04-2022
*
* This class has the purpose of virtualizing the access to the system UsbPort.
*
*/
object HAL {
    var lastOutput = 0
    fun init() {
        UsbPort.write(0)
    }

    fun isBit(mask: Int): Boolean {
    val value = UsbPort.read()
    val final = value and mask
    if (final != 0) return true else return false
    }

    fun readBits(mask: Int): Int {
        val value = UsbPort.read()
        val final = value and mask
        return final
    }

    fun writeBits(mask: Int, value: Int) {
        var finalOutput = 0
        finalOutput = (mask.inv() and lastOutput) or (value and mask)
        lastOutput = finalOutput
        UsbPort.write(finalOutput)
    }

    fun setBits(mask: Int) {
        var finalOutput = 0
        finalOutput = lastOutput or mask
        lastOutput = finalOutput
        UsbPort.write(finalOutput)
    }

    fun clrBits(mask: Int) {
        var finalOutput = 0
        finalOutput = mask.inv() and lastOutput
        lastOutput = finalOutput
        UsbPort.write(finalOutput)
    }
}


