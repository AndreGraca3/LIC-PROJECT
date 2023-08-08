object Station{
    data class Ticket(val Price : String , var quantity : Int , val city : String)

    fun getInfo(FileName : String) : Array<Ticket?>{
        val reader = FileAcess.createReader(FileName)
        var line = reader.readLine()
        var array = arrayOfNulls<Ticket>(16) // devemos deixar 16 ou deveriamos colocar outro valor?
        var i = 0
        while(line != null){
            val list = line.split(";")
            val ticket = Ticket(list[0],list[1].toInt(),list[2])
            array[i] = ticket
            line = reader.readLine()
            i++
        }
        return array
    }

    fun writeInfo(FileName: String, array : Array<Ticket?>){
        val writer = FileAcess.createWriter(FileName)
        for(i in array.indices){
            writer.println("${array[i]?.Price};${array[i]?.quantity};${array[i]?.city}")
        }
        writer.close()
    }
}