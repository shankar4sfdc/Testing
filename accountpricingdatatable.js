import { LightningElement, track, api, wire } from 'lwc';
import getPricingList from '@salesforce/apex/AccountPricingDatatableController.getPricingList';
const columns = [
    { label: 'CPP', fieldName: 'lskuCode', type: 'text' },
    { label: 'Product', fieldName: 'lskuName', type: 'text' },
    { label: 'LKSU name (code)', fieldName: 'lskuName', type: 'text' },
    { label: 'Address', fieldName: 'address', type: 'text' },
    { label: 'IsSoldTo', fieldName: 'isSoldTo', type: 'text' },
    { label: 'Pack Weight (kg)', fieldName: 'packWeight', type: 'text' },
    { label: 'Status', fieldName: 'priceStatus', type: 'text' },
    { label: 'Currency', fieldName: 'x_currency', type: 'currency' },
    { label: 'Price', fieldName: 'customerPrice', type: 'currency' },
    { label: 'UOM', fieldName: 'unitOfMeasure', type: 'text' },
    { label: 'Volume (kg)', fieldName: 'volume', type: 'text' },
    { label: 'IsExW', fieldName: 'isBulk', type: 'checkbox' },
    { label: 'Effective date', fieldName: 'effectiveDate', type: 'date' },
    { label: 'Expiry date', fieldName: 'expiryDate', type: 'date' },
    { label: 'Valid To date', fieldName: 'periodicCalcDate', type: 'date' },
    { label: 'IsESQ', fieldName: 'exWorks', type: 'checkbox' },
];

export default class Accountpricingdatatable extends LightningElement {
    @track priceRecord;
    @api recordId;
    //data = data;
    columns = columns;
 

    renderedCallback(){
         
        getPricingList({accId: this.recordId})
        .then(result => {
            this.priceRecord = result;
            console.log('this.priceRecord==>',this.priceRecord);
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.priceRecord = undefined;
        });
    }
     
}