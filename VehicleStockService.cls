public class VehicleStockService {

    public static Boolean isVehicleAvailable(Id vehicleId) {

        Vehicle__c vehicle = [
            SELECT Id, Stock__c
            FROM Vehicle__c
            WHERE Id = :vehicleId
            LIMIT 1
        ];

        return vehicle.Stock__c > 0;
    }

    public static void reduceStock(Id vehicleId) {

        Vehicle__c vehicle = [
            SELECT Id, Stock__c
            FROM Vehicle__c
            WHERE Id = :vehicleId
            LIMIT 1
        ];

        vehicle.Stock__c -= 1;
        update vehicle;
    }
}
