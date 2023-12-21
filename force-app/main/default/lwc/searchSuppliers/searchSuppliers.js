import { LightningElement, api, wire, track } from 'lwc';
import searchSuppliers from '@salesforce/apex/GetSupplierController.searchSuppliers';


const columns = [
    {
        label: 'Name',
        fieldName: 'Supplier_Url__c',
        type: 'url',
        typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }
        /*fieldName: 'supplierUrl',
        type: 'url',
        typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }*/
    }, {
        label: 'Street',
        fieldName: 'Address__Street__s',
    }, {
        label: 'City',
        fieldName: 'City__c',
    }, {
        label: 'Postal Code',
        fieldName: 'Address__PostalCode__s',
    },
];

export default class SearchSuppliers extends LightningElement {

    @api searchData = [];
    @api columns = columns;
    
    @track error;
    @track city;
    errorMsg = '';
    
    @api page = 1; //initialize 1st page
    @api items = []; //contains all the records.
    @api startingRecord = 1; //start record position per page
    @api endingRecord = 0; //end record position per page
    @api pageSize = 10; //default value we are assigning
    @api totalRecountCount = 0; //total record count received from all retrieved records
    @api totalPage = 0; //total number of page is needed to display all records
 

    @api
    callFromParent(supplierCity){           
        this.city = supplierCity;
        this.getSupplierDetails(this.city);
    }
        
    getSupplierDetails(city){
        searchSuppliers({ strCityName: this.city })
        .then(data => { 
            
            /*let tempConList = []; 
            data.forEach(record => {
                let tempConRec = Object.assign({}, record);  
                tempConRec.supplierUrl = '/' + tempConRec.Id;
                console.log('tempConRec.supplierUrl==', tempConRec.supplierUrl);
                tempConList.push(tempConRec);           
            });

            console.log('tempConList==',tempConList);
            this.searchData = tempConList;
            */
            /*
            data.forEach(item => {
                this.items = [...this.items,
                {...item,
                    supplierUrl: `https://d5i00000dtutqeat-dev-ed.develop.lightning.force.com/lightning/r/Supplier__c/${item['Id']}/view`,
                    placeholder: ''
                }];            
            });*/
            this.items = data;
            this.items = JSON.parse(JSON.stringify(this.items));
            this.totalRecountCount = data.length;
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize);
            //here we slice the data according page size
            this.searchData = this.items.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns;
            this.error = undefined;
        }).catch(error => {
            console.log(JSON.parse(JSON.stringify(error)))
            this.error = error;
        });
    }

    //press on previous button this method will be called
    previousHandler() {
        if (this.page > 1) {
            this.page = this.page - 1;
            this.displayRecordPerPage(this.page);
        }
    }
 
    //press on next button this method will be called
    nextHandler() {
        if((this.page < this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1;
            this.displayRecordPerPage(this.page);            
        }             
    }
 
    //this method displays records page by page
    displayRecordPerPage(page){
         
        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);
 
        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 
 
        this.searchData = this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }
}