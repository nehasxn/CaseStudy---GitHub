import { LightningElement, api, track, wire } from 'lwc';

export default class getSupplierData extends LightningElement {

    @api searchData;
    errorMsg = '';
    strSearchCity = '';

    @track error;
    
    handleCityName(event) {
        this.errorMsg = '';
        this.strSearchCity = event.currentTarget.value;
    }

    handleSearch() {
        if(!this.strSearchCity) {
            this.errorMsg = 'Please enter city to search.';
            this.searchData = undefined;
            return;
        } else{
            this.callSearchSuppliers(this.strSearchCity);
            this.callMaps(this.strSearchCity);
        }
    }
    
    callMaps(strSearchCity){                
        this.template.querySelector('c-lwc-create-map').callFromParent(strSearchCity);
    }

    callSearchSuppliers(strSearchCity){
        this.template.querySelector('c-search-suppliers').callFromParent(strSearchCity);
    }
}