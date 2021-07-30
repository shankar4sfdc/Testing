import { LightningElement, track, api } from 'lwc';
import getCurrentPricingList from '@salesforce/apex/AccountCurrentPricesHandler.getCurrentPricingList';
const columns = [
    { label: 'lskuCode', fieldName: 'lskuCode', type: 'text' },
    { label: 'addressCode', fieldName: 'addressCode', type: 'text' },
    { label: 'Address', fieldName: 'address', type: 'text' },
    { label: 'IsSoldTo', fieldName: 'isSoldTo', type: 'text' },
    { label: 'Volume (kg)', fieldName: 'volume', type: 'text' },
    { label: 'Currency', fieldName: 'x_currency', type: 'text' },
    { label: 'IsExW', fieldName: 'exWorks', type: 'checkbox' },
    { label: 'RegionalUpliftPrice', fieldName: 'regionalUpliftPrice', type: 'decimal' },
    { label: 'MinimumPrice', fieldName: 'minimumPrice', type: 'decimal' },
    { label: 'TargetPrice', fieldName: 'targetPrice', type: 'decimal' },
    { label: 'OpportunityPrice', fieldName: 'opportunityPrice', type: 'decimal' },
];

export default class CurrentPricingDataTable extends LightningElement {


    @track cppPriceRecord;
    @api recordId;
    columns = columns;
    

    constructor(){
        super();

        console.log('hello constructor account prices');
    }

    @api connectedCallback(){
         console.log('renderedCallback account prices enter point ==>');
         getCurrentPricingList({briefId: this.recordId})
        .then(result => {
             console.log('renderedCallback result ======>',  result);
            this.cppPriceRecord = result;
            console.log('renderedCallback this.cppPriceRecord ==>', this.cppPriceRecord);
            this.error = undefined;
        })
        .catch(error => {
             console.log('renderedCallback account prices error ==>', error);
            this.error = error;
            this.cppPriceRecord = undefined;
        });
    }
}