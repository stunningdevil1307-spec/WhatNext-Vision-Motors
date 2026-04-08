public with sharing class VehicleController {

    @AuraEnabled(cacheable=true)
    public static List<Vehicle__c> getVehicles() {
        return [SELECT Id, Name, Model__c, Price__c, Stock__c 
                FROM Vehicle__c];
    }
}
