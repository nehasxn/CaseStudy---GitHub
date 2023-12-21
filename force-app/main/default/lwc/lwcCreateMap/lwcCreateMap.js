import { LightningElement, api, wire, track } from 'lwc';
import searchSuppliers from '@salesforce/apex/GetSupplierController.searchSuppliers';

export default class lwcCreateMap extends LightningElement {
    
    @api error;
    @api mapMarkers = [];
    @api markersTitle = 'Suppliers';
    @api zoomLevel = 15;
    
    @api 
    callFromParent(mapCity){
        this.callMap(mapCity);
    }
    
    callMap(mapCity){            
        searchSuppliers({ strCityName: mapCity })
        .then(data => {
            data.forEach(dataItem => {
                this.mapMarkers = [...this.mapMarkers,
                {
                    location: {
                        Street: dataItem.Address__Street__s,
                        City: dataItem.City__c,
                        State: dataItem.Address__PostalCode__s + ', '+dataItem.Address__CountryCode__s,
                        Country: dataItem.Address__CountryCode__s,
                    },
                    //icon: 'custom:custom26',
                    title: dataItem.Name,
                    description: dataItem.Address__Street__s +' ' +dataItem.City__c +' ' +dataItem.Address__PostalCode__s +' Netherlands',
                }
                ];
            });
        }).catch(error => {
            this.data = undefined;
            if(error) {
                if (Array.isArray(error.body)) {
                    this.errorMsg = error.body.map(e => e.message).join(', ');
                } else if (typeof error.body.message === 'string') {
                    this.errorMsg = error.body.message;
                }
            }
            this.error = error;
        });
    }
}