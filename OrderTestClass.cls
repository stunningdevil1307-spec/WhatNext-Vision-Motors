@isTest
public class OrderTestClass {

    @isTest
    static void testOrderCreation() {

        // Create Vehicle
        Vehicle__c vehicle = new Vehicle__c(Name='Car A', Stock__c=5);
        insert vehicle;

        // Create Dealer
        Dealer__c dealer = new Dealer__c(Name='Dealer A', City__c='Chennai');
        insert dealer;

        // Create Order
        Order__c ord = new Order__c(
            Vehicle__c = vehicle.Id,
            Customer_City__c = 'Chennai'
        );

        insert ord;

        // Verify
        Order__c insertedOrder = [SELECT Id, Dealer__c FROM Order__c WHERE Id = :ord.Id];

        System.assertNotEquals(null, insertedOrder.Dealer__c);
    }
}
