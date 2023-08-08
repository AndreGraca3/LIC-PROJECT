object CoinAcceptor { // Implementa a interface com o moedeiro.
        //Entradas do UsbPort
    private val Coin_MASK = 1 shl 1
    private val Cid0_MASK = 1 shl 2
    private val Cid1_MASK = 1 shl 3
    private val Cid2_MASK = 1 shl 4
        //saidas do UsbPort
    private val accept_MASK = 1 shl 3
    private val collect_MASK = 1 shl 4
    private val return_MASK = 1 shl 5
    // Inicia a classe
    fun init() {
    HAL.init()
    }

    // Retorna true se foi introduzida uma nova moeda.
    fun hasCoin(): Boolean {
   return HAL.isBit(Coin_MASK)
    }

    // Retorna o valor facial da moeda introduzida.
    fun getCoinValue(): Int {
        var finalMask = 0
        var amount = 0
    finalMask = HAL.readBits(Cid0_MASK) or HAL.readBits(Cid1_MASK) or HAL.readBits(Cid2_MASK)
        finalMask = finalMask.shr(2)

        when(finalMask) {
            0 -> amount = 5
            1 -> amount = 10
            2 -> amount = 20
            3 -> amount = 50
            4 -> amount = 100
            5 -> amount = 200
        }
        return amount
    }

    fun acceptCoin(){// informa o moedeiro que a moeda foi contabilizada
        if(hasCoin()){
            HAL.setBits(accept_MASK)
            while(hasCoin()){//aguardar que hasCoin mude
            }
            HAL.clrBits(accept_MASK)
        }
    }

    // Devolve as moedas que estão no moedeiro.
    fun ejectCoins() {
    HAL.setBits(return_MASK)
    }
    // Recolhe as moedas que estão no moedeiro.
    fun collectCoins() {
    HAL.setBits(collect_MASK)
    }
}