import com.ib.client.*;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Set;

public class ApiImpl implements EWrapper {

    private EReaderSignal eReaderSignal;
    private EClientSocket eClientSocket;
    private int currentOrderId = -1;

    public ApiImpl() {
        eReaderSignal = new EJavaSignal();
        eClientSocket = new EClientSocket(this, eReaderSignal);
    }

    public boolean connect(){
        eClientSocket.eConnect("localhost", 7497, 1);
        if (eClientSocket.isConnected()) handleMessages();
        return eClientSocket.isConnected();
    }

    public void disconnect() {
        eClientSocket.eDisconnect();
    }

    public String connectionTime(){
        return eClientSocket.TwsConnectionTime();
    }

    public int placeOrder(Contract contract, Order order) throws Exception {
        eClientSocket.reqIds(-1);
        Thread.sleep(2000);
        eClientSocket.placeOrder(currentOrderId, contract, order);
        return currentOrderId;
    }

    public void cancelOrder(int orderId){
        eClientSocket.cancelOrder(orderId);
    }

    public void openOrders(){
        eClientSocket.reqOpenOrders();
    }

    public void getHistoricalData(int reqId, Contract contract, String duration, String barSize){
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd HH:mm:ss");
        String formattedDate = format.format(Calendar.getInstance().getTime());
        eClientSocket.reqHistoricalData(reqId, contract, formattedDate, duration, barSize, "TRADES", 0, 1, null);
    }

    public void getMarketData(int reqId, Contract contract){
        eClientSocket.reqMktData(reqId, contract, "", false, null);
    }

    public void cancelMarketData(int reqId){
        eClientSocket.cancelMktData(reqId);
    }

    public void getRealTimeBars(int reqId, Contract contract){
        eClientSocket.reqRealTimeBars(reqId, contract, 5, "TRADES", false, null);
    }

    public void cancelRealTimeBars(int reqId){
        eClientSocket.cancelRealTimeBars(reqId);
    }

    public void tickPrice(int reqId, int tickType, double price, int canAutoExecute) {
        System.out.println("Tick Price: Request ID: " + reqId + ", Type: " + TickType.getField(tickType) + ", Price: " + price);
    }

    public void tickSize(int reqId, int tickType, int size) {
        System.out.println("Tick Size: Request ID: " + reqId + ", Type: " + TickType.getField(tickType) + ", Size: " + size);
    }

    public void tickString(int reqId, int tickType, String value) {
        System.out.println("Tick Info: Request ID: " + reqId + ", Type: " + TickType.getField(tickType) + ", Value: " + value);
    }

    public void tickOptionComputation(int i, int i1, double v, double v1, double v2, double v3, double v4, double v5, double v6, double v7) {

    }

    public void tickGeneric(int i, int i1, double v) {

    }

    public void tickEFP(int i, int i1, double v, String s, double v1, int i2, String s1, double v2, double v3) {

    }

    public void orderStatus(int orderId, String status, double filled, double remaining, double avgFillPrice, int permId, int parentId, double lastFillPrice, int clientId, String whyHeld) {
        System.out.println("Order Status: Order ID: " + orderId + ", Status: " + status +
                ", Filled: " + filled + ", Remaining: " + remaining + ", AvgFillPrice: " + avgFillPrice +
                ", LastFillPrice: " + lastFillPrice + ", ClientId: " + clientId);
    }

    public void openOrder(int orderId, Contract contract, Order order, OrderState orderState) {
        System.out.println("Order State: Order ID: " + orderId + ", Contract Symbol: " + contract.symbol() +
                ", Type: " + contract.secType() + ", Exchange: " + contract.exchange() +
                ", Action: " + order.action() + ", Type: " + order.orderType() +
                ", Quantity: " + order.totalQuantity() + ", Status: " + orderState.status());
    }

    public void openOrderEnd() {
    }

    public void updateAccountValue(String s, String s1, String s2, String s3) {

    }

    public void updatePortfolio(Contract contract, double position, double marketPrice, double marketValue, double averageCost, double unrealizedPNL, double realizedPNL, String accountName) {

    }

    public void updateAccountTime(String s) {

    }

    public void accountDownloadEnd(String s) {

    }

    public void nextValidId(int i) {
        currentOrderId = i;
    }

    public void contractDetails(int i, ContractDetails contractDetails) {

    }

    public void bondContractDetails(int i, ContractDetails contractDetails) {

    }

    public void contractDetailsEnd(int i) {

    }

    public void execDetails(int i, Contract contract, Execution execution) {}

    public void execDetailsEnd(int i) {}

    public void updateMktDepth(int i, int i1, int i2, int i3, double v, int i4) {

    }

    public void updateMktDepthL2(int i, int i1, String s, int i2, int i3, double v, int i4) {

    }

    public void updateNewsBulletin(int i, int i1, String s, String s1) {

    }

    public void managedAccounts(String s) {

    }

    public void receiveFA(int i, String s) {

    }

    public void historicalData(int reqId, String date, double open,
                               double high, double low, double close, int volume, int count,
                               double WAP, boolean hasGaps) {
        if (count != -1) {
            System.out.println("Historical Data Response: Request ID: " + reqId + ", Date: " + date +
                    ", Open: " + open + ", High: " + high + ", Low: " + low +
                    ", Close: " + close + ", Volume: " + volume + ", Count: " + count);
        }
    }
    public void scannerParameters(String s) {

    }

    public void scannerData(int i, int i1, ContractDetails contractDetails, String s, String s1, String s2, String s3) {

    }

    public void scannerDataEnd(int i) {

    }

    public void realtimeBar(int reqId, long time, double open, double high, double low, double close, long volume, double wap, int count) {}

    public void currentTime(long l) {

    }

    public void fundamentalData(int i, String s) {

    }

    public void deltaNeutralValidation(int i, DeltaNeutralContract deltaNeutralContract) {

    }

    public void tickSnapshotEnd(int i) {

    }

    public void marketDataType(int i, int i1) {

    }

    public void commissionReport(CommissionReport commissionReport) {}

    public void position(String account, Contract contract, double pos, double avgCost) {

    }

    public void positionEnd() {

    }

    public void accountSummary(int i, String s, String s1, String s2, String s3) {

    }

    public void accountSummaryEnd(int i) {

    }

    public void verifyMessageAPI(String s) {

    }

    public void verifyCompleted(boolean b, String s) {

    }

    public void verifyAndAuthMessageAPI(String s, String s1) {

    }

    public void verifyAndAuthCompleted(boolean b, String s) {

    }

    public void displayGroupList(int i, String s) {

    }

    public void displayGroupUpdated(int i, String s) {

    }

    public void error(Exception e) {}

    public void error(String str) {}

    public void error(int id, int errorCode, String errorMsg) {}

    public void connectionClosed() {
        System.out.println("Connection closed.");
    }

    public void connectAck() {

    }

    public void positionMulti(int reqId, String account, String modelCode, Contract contract, double pos, double avgCost) {

    }

    public void positionMultiEnd(int reqId) {

    }

    public void accountUpdateMulti(int reqId, String account, String modelCode, String key, String value, String currency) {

    }

    public void accountUpdateMultiEnd(int reqId) {

    }

    public void securityDefinitionOptionalParameter(int reqId, String exchange, int underlyingConId, String tradingClass, String multiplier, Set<String> expirations, Set<Double> strikes) {

    }

    public void securityDefinitionOptionalParameterEnd(int reqId) {

    }

    public void softDollarTiers(int reqId, SoftDollarTier[] tiers) {

    }

    private void handleMessages() {
        final EReader reader = new EReader(eClientSocket, eReaderSignal);
        reader.start();
        new Thread(() -> {
            while (eClientSocket.isConnected()) {
                eReaderSignal.waitForSignal();
                try {
                    reader.processMsgs();
                } catch (Exception e) {
                    System.out.println("Exception: " + e.getMessage());
                }
            }
        }).start();
    }
}
