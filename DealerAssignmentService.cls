public class DealerAssignmentService {

    public static Id assignNearestDealer(String customerCity) {

        List<Dealer__c> dealers = [
            SELECT Id, Name, City__c
            FROM Dealer__c
            WHERE City__c = :customerCity
            LIMIT 1
        ];

        if (!dealers.isEmpty()) {
            return dealers[0].Id;
        }

        return null;
    }
}
