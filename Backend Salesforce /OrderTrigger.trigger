trigger OrderTrigger on Order__c (before insert) {

    for(Order__c ord : Trigger.new) {

        Vehicle__c veh = [SELECT Stock__c FROM Vehicle__c WHERE Id = :ord.Vehicle__c LIMIT 1];

        // Prevent order if no stock
        if(veh.Stock__c <= 0) {
            ord.addError('Vehicle is out of stock');
        }

        // Auto assign dealer (simple logic)
        Dealer__c dealer = [SELECT Id FROM Dealer__c LIMIT 1];
        ord.Dealer__c = dealer.Id;
    }
}
