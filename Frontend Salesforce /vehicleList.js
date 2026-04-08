import { LightningElement, wire } from 'lwc';
import getVehicles from '@salesforce/apex/VehicleController.getVehicles';
import createOrder from '@salesforce/apex/OrderController.createOrder';

export default class VehicleList extends LightningElement {
    vehicles;

    @wire(getVehicles)
    wiredVehicles({ error, data }) {
        if (data) {
            this.vehicles = data.map(vehicle => {
                return {
                    ...vehicle,
                    stockClass: vehicle.Stock__c > 0 ? 'inStock' : 'outStock'
                };
            });
        } else if (error) {
            console.error(error);
        }
    }

    handleOrder(event) {
        const vehicleId = event.target.dataset.id;

        createOrder({ vehicleId: vehicleId })
            .then(() => {
                alert('Order placed successfully!');
            })
            .catch(error => {
                alert('Vehicle out of stock!');
                console.error(error);
            });
    }
}
