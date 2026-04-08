global class StockScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {
        StockBatch batch = new StockBatch();
        Database.executeBatch(batch, 50);
    }
}
