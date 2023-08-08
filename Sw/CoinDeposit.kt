object CoinDeposit{

    data class Coin(val CoinId : Int , var CoinQT : Int)

    fun getInfo(FileName : String) : Array<Coin?>{
        val reader = FileAcess.createReader(FileName)
        var line = reader.readLine()
        var array = arrayOfNulls<Coin>(6) // devemos deixar 6 ou deveriamos colocar outro valor?
        var i = 0
        while(line != null){
            val list = line.split(";")
            val coin = Coin(list[0].toInt(),list[1].toInt())
            array[i] = coin
            line = reader.readLine()
            i++
        }
        return array
    }

    fun writeInfo(FileName: String, array : Array<Coin?> ){
        val array = array
        val writer = FileAcess.createWriter(FileName)
        for(i in array.indices){
            writer.println("${array[i]?.CoinId};${array[i]?.CoinQT}")
        }
        writer.close()
    }

}