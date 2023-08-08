import java.io.BufferedReader
import java.io.FileReader
import java.io.PrintWriter

object FileAcess{

    fun createReader(fileName : String) : BufferedReader {
        return BufferedReader(FileReader(fileName))
    }

    fun createWriter(fileName: String): PrintWriter {
        return PrintWriter(fileName)
    }

}