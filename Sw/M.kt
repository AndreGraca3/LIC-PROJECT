object M {
    private const val M_mask = 1 shl 6

    fun init(){
        HAL.init()
    }
 fun verify() :Boolean{
     return HAL.isBit(M_mask)
 }

}

fun main(){
    M.init()
    Thread.sleep(5000)
    if(M.verify()) println(true) else println(false)
}