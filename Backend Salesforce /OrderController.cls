public with sharing class OrderController {

    @AuraEnabled
    public static void createOrder(Id vehicleId) {

        Vehicle__c vehicle = [SELECT Id, Stock__c FROM Vehicle__c WHERE Id = :vehicleId LIMIT 1];

        if(vehicle.Stock__c <= 0) {
            throw new AuraHandledException('Vehicle out of stock');
        }

        Order__c orderRec = new Order__c();
        orderRec.Vehicle__c = vehicleId;
        orderRec.Status__c = 'Confirmed';

        insert orderRec;

        // Reduce stock
        vehicle.Stock__c = vehicle.Stock__c - 1;
        update vehicle;
    }
}
