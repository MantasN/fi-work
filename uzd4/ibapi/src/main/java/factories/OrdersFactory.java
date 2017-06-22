package factories;

import com.ib.client.Order;

public class OrdersFactory {
    public static Order getMarketBuyOrder(int quantity){
        Order marketOrder = new Order();
        marketOrder.action("BUY");
        marketOrder.orderType("MKT");
        marketOrder.totalQuantity(quantity);
        return marketOrder;
    }

    public static Order getMarketSellOrder(int quantity){
        Order marketOrder = new Order();
        marketOrder.action("SELL");
        marketOrder.orderType("MKT");
        marketOrder.totalQuantity(quantity);
        return marketOrder;
    }

    public static Order getLimitBuyOrder(int quantity, double price) {
        Order limitOrder = new Order();
        limitOrder.action("BUY");
        limitOrder.orderType("LMT");
        limitOrder.totalQuantity(quantity);
        limitOrder.lmtPrice(price);
        return limitOrder;
    }

    public static Order getLimitSellOrder(int quantity, double price) {
        Order limitOrder = new Order();
        limitOrder.action("SELL");
        limitOrder.orderType("LMT");
        limitOrder.totalQuantity(quantity);
        limitOrder.lmtPrice(price);
        return limitOrder;
    }
}
