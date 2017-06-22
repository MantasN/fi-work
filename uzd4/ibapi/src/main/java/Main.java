import factories.ContractsFactory;
import factories.OrdersFactory;

public class Main {
    public static void main(String[] args) throws Exception {
        ApiImpl apiImpl = new ApiImpl();

        if (apiImpl.connect()) {
            System.out.println("Connected at " + apiImpl.connectionTime());

            System.out.println("-> place market buy order");
            apiImpl.placeOrder(ContractsFactory.getMicrosoftContract(),
                    OrdersFactory.getMarketBuyOrder(10));

            sleepThreeSeconds();

            System.out.println("-> place market sell order");
            apiImpl.placeOrder(ContractsFactory.getMicrosoftContract(),
                    OrdersFactory.getMarketSellOrder(10));

            sleepThreeSeconds();

            System.out.println("-> place limit buy order");
            int limitOrderId = apiImpl.placeOrder(ContractsFactory.getEURUSDForexContract(),
                    OrdersFactory.getLimitBuyOrder(20000, 1));

            sleepThreeSeconds();

            System.out.println("-> get open orders");
            apiImpl.openOrders();

            sleepThreeSeconds();

            System.out.println("-> cancel limit buy order");
            apiImpl.cancelOrder(limitOrderId);

            sleepThreeSeconds();

            System.out.println("-> get historical data");
            apiImpl.getHistoricalData(1, ContractsFactory.getMicrosoftContract(),"10 D", "1 hour");

            sleepThreeSeconds();

            System.out.println("-> get market data");
            apiImpl.getMarketData(2,  ContractsFactory.getMicrosoftContract());

            sleepTenSeconds();

            System.out.println("-> cancel market data");
            apiImpl.cancelMarketData(2);

            sleepThreeSeconds();

            System.out.println("-> disconnect");
            apiImpl.disconnect();

            sleepTenSeconds();

            System.out.println("Disconnected.");
        } else {
            System.out.println("Connection problems...");
        }
    }

    public static void sleepThreeSeconds() throws Exception {
        Thread.sleep(3000);
    }

    public static void sleepTenSeconds() throws Exception {
        Thread.sleep(10000);
    }
}
