package factories;

import com.ib.client.Contract;

public class ContractsFactory {
    public static Contract getMicrosoftContract(){
        Contract microsoftContract = new Contract();
        microsoftContract.symbol("MSFT");
        microsoftContract.secType("STK");
        microsoftContract.currency("USD");
        microsoftContract.exchange("ISLAND");
        return microsoftContract;
    }

    public static Contract getEURUSDForexContract() {
        Contract eurUsdForex = new Contract();
        eurUsdForex.symbol("EUR");
        eurUsdForex.secType("CASH");
        eurUsdForex.currency("USD");
        eurUsdForex.exchange("IDEALPRO");
        return eurUsdForex;
    }
}
