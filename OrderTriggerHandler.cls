public class OrderTriggerHandler {

    public static void beforeInsert(List<Order__c> orders) {

        for (Order__c ord : orders) {

            // 🚫 Prevent order if out of stock
            if (!VehicleStockService.isVehicleAvailable(ord.Vehicle__c)) {
                ord.addError('Vehicle is out of stock!');
            }

            // 📍 Assign nearest dealer
            if (ord.Customer_City__c != null) {
                ord.Dealer__c = DealerAssignmentService.assignNearestDealer(ord.Customer_City__c);
            }
        }
    }

    public static void afterInsert(List<Order__c> orders) {

        for (Order__c ord : orders) {

            if (VehicleStockService.isVehicleAvailable(ord.Vehicle__c)) {
                VehicleStockService.reduceStock(ord.Vehicle__c);
            }
        }
    }
}
