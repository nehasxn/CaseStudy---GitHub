import { LightningElement, api, wire, track } from 'lwc';
import getAccountCity from '@salesforce/apex/GetSupplierController.getAccountCity';

export default class getSupplierMap extends LightningElement {
    
    @api recordId;
    @track error;
    @track billingCity;

    connectedCallback() {
    getAccountCity({ recordId:  this.recordId })
        .then(data => {
            this.billingCity = data.BillingCity;
            this.callMaps(this.billingCity);
            this.callSearchSuppliers(this.billingCity);
        }).catch(error => {
            this.error = error;
        });
    }
    
    callMaps(city){
        this.template.querySelector('c-lwc-create-map').callFromParent(city);
    }

    callSearchSuppliers(city){
        this.template.querySelector('c-search-suppliers').callFromParent(city);
    }

}