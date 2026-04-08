public class OrderTriggerHandler {

    public static void beforeInsert(List<Order__c> orders) {

        for(Order__c ord : orders) {

            Vehicle__c veh = [SELECT Stock__c FROM Vehicle__c WHERE Id = :ord.Vehicle__c LIMIT 1];

            if(veh.Stock__c <= 0) {
                ord.addError('Out of stock');
            }
        }
    }
}
