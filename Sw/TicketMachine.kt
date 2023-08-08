object TicketMachine{

    private const val NONE = -1
    var arrayStations = arrayOfNulls<Station.Ticket>(16)
    var arrayCoins = arrayOfNulls<CoinDeposit.Coin>(6)
    var indice = 0
    var key = '0'

    fun init(){
        arrayStations = Station.getInfo("stations.txt")
        arrayCoins = CoinDeposit.getInfo("CoinDeposit.txt")
        //Vai haver problema em ter o mesmo protocolo de inicialização que o M? sim
        //criar uma variável que deteta se a inicialização já foi feita , ou então, colocar por ordem
        TUI.init()
        //displayMainMenu()
    }

    private fun teste(destinyId : Int, originId : Int, roundTrip : Boolean){//modo de manutenção
        TicketDispenser.print(destinyId,originId,roundTrip)
    }

    private fun resetCount(){//modo de manutenção
        for(i in arrayStations.indices){
            arrayStations[i]?.quantity = 0
        }
        for(i in arrayCoins.indices){
            arrayCoins[i]?.CoinQT = 0
        }
    }

    private fun shutDown(){//modo de manutenção
        Station.writeInfo("stations.txt", arrayStations)
        CoinDeposit.writeInfo("CoinDeposit.txt", arrayCoins)
    }

    private fun maintenance(){
        key = TUI.waitForKey()
        while(true){
            when(key){
                '1'->{ // print ticket
                    teste(4,6,true) // valores de teste
                }
                '2'->{ // stations count
                    TODO("Not yet implemented")
                }
                '3'->{ // Coin Count
                    TODO("Not yet implemented")
                }
                '4'->{ // Reset Count
                    resetCount()
                }
                '5' ->{ // shutDown
                    while(true){
                        TUI.clearDisplay()
                        TUI.writeYesOrNo()
                        key = TUI.waitForKey()
                        if(key == '5') shutDown()// yes
                        else break
                    }
                }
            }
        }
    }

    private fun stationsAndSell() {// mostras as estações e inicia a venda
        displayStation(indice)
        while (true) {
            key = TUI.waitForKey()
            if(key == '#') {
                sell(indice)
                key = indice.toChar()
                TUI.clearDisplay()
                ticketMachine()
            }
            while (true){
                if(key != '#' && key !='*' && key != NONE.toChar()){
                    indice = key.toString().toInt()
                    break
                }
                else break
            }
            if (key == '1') {
                while (true) {
                    key = TUI.waitForKey()
                    when (key) {
                        '0' -> indice = 10
                        '1' -> indice = 11
                        '2' -> indice = 12
                        '3' -> indice = 13
                        '4' -> indice = 14
                        '5' -> indice = 15
                    }
                    break
                }
            }
            var prev = true
            if (key == '*' && prev) { // arrow mode
                while (true) {
                    key = TUI.waitForKey()
                    if (key == '2') {
                        indice--
                        if(indice <= -1 ) indice = 15
                        TUI.clearDisplay()
                        displayStation(indice)
                        key = NONE.toChar()
                    }
                    if (key == '8') {
                        indice++
                        if(indice >= 16) indice = 0
                        TUI.clearDisplay()
                        displayStation(indice)
                        key = NONE.toChar()
                    }
                    if(key == '*'){
                        prev = false
                        break
                    }
                    if (key != '2' || key != '8') continue
                }
            }
            if (key != NONE.toChar() && key != '*' && key != '#'){
                TUI.clearDisplay()
                displayStation(indice)
                key = NONE.toChar()
                continue
            }else continue
        }
    }

    private fun sell( Index : Int ){ // modo de consulta e venda
        TUI.clearDisplay()
        val city = arrayStations[Index]!!.city
        var priceDoubleOrNot = arrayStations[Index]!!.Price
        val priceOriginal = arrayStations[Index]!!.Price
        TUI.sellWriteLCDStation(city , priceOriginal)
        var prev = true
        while(true){
            var key = TUI.waitForKey()
            if(key == '*') {
                priceDoubleOrNot = (priceDoubleOrNot.toInt() * 2).toString()
                if((priceOriginal.toInt() * 2) >= priceDoubleOrNot.toInt() ){
                    TUI.sellWriteLCDStation(city, priceDoubleOrNot)
                    payment(priceDoubleOrNot.toInt())
                    continue
                }else payment(priceDoubleOrNot.toInt())
            }else payment(priceDoubleOrNot.toInt())
            if(key == '#' && prev){
                prev = false
                LCD.clear()
                TUI.vendingAborted()
                while (true){
                    key = TUI.waitForKey()
                    if(key=='#') return
                    else break
                }
            } else continue
        }
    }

    private fun displayStation(Index : Int){//mostra as estações
        val city = arrayStations[Index]!!.city
        val price = arrayStations[Index]!!.Price
        TUI.writeLCDStation(city, price,Index)
    }

    private fun displayMainMenu(){//mostra o menu principal
        TUI.clearDisplay()
        TUI.writeLCDMainMenu()
    }

    private fun displayMaintenanceMenu(){
        TUI.clearDisplay()
        TUI.writeMaintenanceMenu()
    }

    private fun payment(value : Int) { // value == valor a pagar, mudar para não estar sempre a escrever
        var currentValue = value
        while (true) {
            if(CoinAcceptor.hasCoin()){
                currentValue -= CoinAcceptor.getCoinValue()
                CoinAcceptor.acceptCoin()
                TUI.sellWriteLCDStation(arrayStations[indice]!!.city,currentValue.toString())
            }
            continue
        }
    }

    fun ticketMachine(){
        displayMainMenu()
        while (true) {
            if (M.verify()) { // modo de manutenção
                displayMaintenanceMenu()
                maintenance()
            }
            var key = TUI.waitForKey()
            if (key == '#') { // modo de venda
                TUI.clearDisplay()
                stationsAndSell()
            }
        }
    }

}

fun main() {
    TicketMachine.init()

    while(true){
        TicketMachine.ticketMachine()
    }
}