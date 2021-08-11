import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 
import fetchTransactions from '@salesforce/apex/TransactionsController.getTransactions';
const columnsOpenOrders = [
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Volume Kg', fieldName: 'openOrderVol', type: 'text'},
    {label: 'Sales', fieldName: 'openOrderSales', type: 'text'},
    {label: 'GP', fieldName: 'openOrderGP', type: 'text'},
    {label: 'GP/T', fieldName: 'openOrderGPPerTonne', type: 'text'},
    {label: 'GP %', fieldName: 'openOrderGPPerc', type: 'text'},
];

const columnsCurrentMonth = [
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Volume Kg', fieldName: 'currentMonthVol', type: 'text'},
    {label: 'Sales', fieldName: 'currentMonthSales', type: 'text'},
    {label: 'GP', fieldName: 'currentMonthGP', type: 'text'},
    {label: 'GP/T', fieldName: 'currentMonthGPPerTonne', type: 'text'},
    {label: 'GP %', fieldName: 'currentMonthGPPerc', type: 'text'},
];

const columnsLast12Months = [
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Volume Kg', fieldName: 'last12MonthVol', type: 'text'},
    {label: 'Sales', fieldName: 'last12MonthSales', type: 'text'},
    {label: 'GP', fieldName: 'last12MonthGP', type: 'text'},
    {label: 'GP/T', fieldName: 'last12MonthGPPerTonne', type: 'text'},
    {label: 'GP %', fieldName: 'last12MonthGPPerc', type: 'text'},
];

const columnsOlder = [
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Volume Kg', fieldName: 'x12To24MonthVol', type: 'text'},
    {label: 'Sales', fieldName: 'x12To24MonthSales', type: 'text'},
    {label: 'GP', fieldName: 'x12To24MonthGP', type: 'text'},
    {label: 'GP/T', fieldName: 'x12To24MonthGPPerTonne', type: 'text'},
    {label: 'GP %', fieldName: 'x12To24MonthGPPerc', type: 'text'},
];
export default class Transactions extends LightningElement {

    @api recordId;
    columns = columnsOpenOrders;
    data;
    @track transactionsRecords;
    @track isLoading = false;

    constructor()
    {
        super();
        this.recordId = null;
    }

    connectedCallback() {

        console.log('record Id connectedCallback --> '+ this.recordId);
        this.isLoading = true;

         fetchTransactions({accId: this.recordId, relevantUserRecords: this.relevantRecords})
        .then(result => {
            this.data = result;
            this.transactionsRecords = result;
             console.log('renderedCallback result ======>',  result);
             console.log('renderedCallback result sales ======>',  result[0].sales);
             console.log('renderedCallback result val ======>',  result[0].val);
             this.isLoading = false;
        })
        .catch(error => {
             console.log('renderedCallback account prices error ==>', error);
            this.isLoading = false;
        });
        
    }

    handleChange(event) {
        console.log('new state: ' + event.target.value);
        if(event.target.value === 'Open Orders') {
            this.columns = columnsOpenOrders;
        }if(event.target.value === 'Current Month') {
            this.columns = columnsCurrentMonth;
        }if(event.target.value === 'Last 12 Months') {
            this.columns = columnsLast12Months;
        }if(event.target.value === 'Last 13 to 24 Months') {
            this.columns = columnsOlder;
        }
    }

    handleCheckBoxChange(event){
        console.log('sales state relevant value ' + event.target.checked);
        this.relevantRecords = event.target.checked;
   }

   handleClick(event){
    this.isLoading = true;
         fetchTransactions({accId: this.recordId, relevantUserRecords: this.relevantRecords})
        .then(result => {

            console.log('renderedCallback result ======>',  result);
            console.log('renderedCallback result sales ======>',  result[0].sales);
            console.log('renderedCallback result val ======>',  result[0].vol);
            let salesStateRecord = result;
            this.data = result;

            let salesRecord = new Array();
            let volumeRecord  = new Array();
            let gpRecord  = new Array();
            let gpTonneRecord  = new Array();
            let gpPercentageRecord  = new Array();
            for(let index = 0 ; index < salesStateRecord.length; index++ ){
                console.log('sales state  ======>',  salesStateRecord[index]);
                salesRecord.push(salesStateRecord[index].sales);
                volumeRecord.push(salesStateRecord[index].vol);
                gpRecord.push(salesStateRecord[index].gP);
                gpTonneRecord.push(salesStateRecord[index].gPPerTonne);
                gpPercentageRecord.push(salesStateRecord[index].gPPerc);
            }

            
            this.recordValues = volumeRecord;

            this.salesHistoryRecordsMap.set('Volume', salesRecord);
            this.salesHistoryRecordsMap.set('Sales', volumeRecord);
            this.salesHistoryRecordsMap.set('GP', gpRecord);
            this.salesHistoryRecordsMap.set('GpTonner', gpTonneRecord);
            this.salesHistoryRecordsMap.set('GpPercentage', gpPercentageRecord);

            console.log('hello this.salesHistoryRecordsMap ', this.salesHistoryRecordsMap);
            this.isLoading = false;
            
        })
        .catch(error => {
             console.log('renderedCallback account prices error ==>', error);
             this.isLoading = false;
             this.data = undefined;
             this.dispatchEvent(new ShowToastEvent({
                title: 'Error',
                message: error.body.message,
                variant: 'information'
            }));
        });
}    

}
