object TUI {

    const val NONE = -1

    fun init() {
        KBD.init()
        LCD.init()
    }

    fun clearDisplay(){
        LCD.clear()
    }

    fun getKey(): Char {
        return KBD.getKey()
    }

    fun waitForKey() : Char{
        return KBD.waitKey(5000)
    }

    fun writeLCDStation(station : String , price : String , number : Int){//expor a estações
        val firstPos = 8 - (station.length)/2
        LCD.cursor(0,firstPos)
        LCD.write(station)

        val priceString = ("${price[0]}.${price[1]}${price[2]}E")
        val pricePos = 16 - priceString.length
        LCD.cursor(1, pricePos)
        LCD.write(priceString)

        LCD.cursor(1,0)
        LCD.write(number.toString())
    }

    fun sellWriteLCDStation(station: String,price: String){//no pagamento
        val firstPos = 8 - (station.length)/2
        LCD.cursor(0,firstPos)
        LCD.write(station)

        var priceString = "000"
        if(price.length == 3 ){
            priceString = ("${price[0]}.${price[1]}${price[2]}E")
        }
        if(price.length <= 2){
            priceString = ("0.${price[0]}${price[1]}E")
        }

        LCD.cursor(1,firstPos)
        LCD.write(priceString)
    }

    fun writeMaintenanceMenu(){
        LCD.cursor(0,0)
        LCD.write("Maintenance Mode")
        LCD.cursor(1,0)
        LCD.write("Type:1,2,3,4or 5")
    }

    fun writeLCDMainMenu(){
        LCD.cursor(0,1)
        LCD.write("Ticket to Ride")
        LCD.cursor(1,0)
        LCD.write("Press # to Start")
    }

    fun writeYesOrNo(){ // shutdown has 8 letters
        val pos = 4 // posição da primeira letra de shutdown
        LCD.cursor(0,pos)
        LCD.write("Shutdown")

        LCD.cursor(1,0)
        LCD.write("5-Yes  other-No")
    }


    fun writeOnLCD() : Char {//fazer verificação da tecla obtida pela função getKey() e na main manter a correr indefenidamente
        val key = KBD.waitKey(5000)// timeout = 5 seconds
        if (key != NONE.toChar()) {
            println(key)
            LCD.write(key)
            return key
        }
        return key
    }

    fun vendingAborted(){
        LCD.cursor(0,0)
        LCD.write("Vending Aborted")
    }

}

fun main(){
    TUI.init()
    while (true) {
        TUI.writeOnLCD()
    }
}