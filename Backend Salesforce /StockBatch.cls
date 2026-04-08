global class StockBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Stock__c FROM Vehicle__c'
        );
    }

    global void execute(Database.BatchableContext bc, List<Vehicle__c> scope) {

        List<Order__c> ordersToUpdate = new List<Order__c>();

        for(Vehicle__c v : scope) {

            List<Order__c> orders = [SELECT Id, Status__c 
                                     FROM Order__c 
                                     WHERE Vehicle__c = :v.Id];

            for(Order__c ord : orders) {

                if(v.Stock__c > 0) {
                    ord.Status__c = 'Confirmed';
                } else {
                    ord.Status__c = 'Pending';
                }

                ordersToUpdate.add(ord);
            }
        }

        update ordersToUpdate;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed');
    }
}
