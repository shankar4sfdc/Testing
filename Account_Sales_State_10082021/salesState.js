import { LightningElement, api, track } from 'lwc';
import fetchTransactions from '@salesforce/apex/TransactionsController.getTransactions';
const volColumns =[
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Current Month', fieldName: 'currentMonthVol', type: 'text'},
    {label: 'last 12 Months', fieldName: 'last12MonthVol', type: 'text'},
    {label: 'Last 13-24 Months', fieldName: 'x12To24MonthVol', type: 'text'},
]

const salesColumns =[
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Current Month', fieldName: 'currentMonthSales', type: 'text'},
    {label: 'last 12 Months', fieldName: 'last12MonthSales', type: 'text'},
    {label: 'Last 13-24 Months', fieldName: 'x12To24MonthSales', type: 'text'},
]

const GPColumns =[
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Current Month', fieldName: 'currentMonthGP', type: 'text'},
    {label: 'last 12 Months', fieldName: 'last12MonthGP', type: 'text'},
    {label: 'Last 13-24 Months', fieldName: 'x12To24MonthGP', type: 'text'},
]

const GpPercentageColumns =[
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Current Month', fieldName: 'currentMonthGPPerc', type: 'text'},
    {label: 'last 12 Months', fieldName: 'last12MonthGPPerc', type: 'text'},
    {label: 'Last 13-24 Months', fieldName: 'x12To24MonthGPPerc', type: 'text'},
]

const GpTonnerColumns =[
    {label: 'Product', fieldName: 'product', type: 'text'},
    {label: 'Material', fieldName: 'material', type: 'text'},
    {label: 'CPP', fieldName: 'cpp', type: 'text'},
    {label: 'Current Month', fieldName: 'currentMonthGPPerTonne', type: 'text'},
    {label: 'last 12 Months', fieldName: 'last12MonthGPPerTonne', type: 'text'},
    {label: 'Last 13-24 Months', fieldName: 'x12To24MonthGPPerTonne', type: 'text'},
]

export default class SalesState extends LightningElement {

    @api recordId;
    @track salesHistoryRecordsMap;
    @track headerValue;

    @track recordValues;
    columns = volColumns;
    data;
    @track headerMap;
    @track isLoading = false;

    constructor(){
        super();
        this.headerValue = 'Volume';
        this.salesHistoryRecordsMap = new Map();
        this.recordValues = null;
        this.headerMap = new Map();
        this.headerMap.set('GpTonner', 'GP/P');
        this.headerMap.set('GpPercentage', 'GP%');
        this.headerMap.set('GP', 'GP');
        this.headerMap.set('Sales', 'Sales');
        this.headerMap.set('Volume', 'Volume');

    }

   connectedCallback() {

        console.log('record Id sales state connectedCallback --> '+ this.recordId);
        this.isLoading = true;
         fetchTransactions({accId: this.recordId})
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

            
            console.log('hello salesRecord ', salesRecord);
            console.log('hello volumeRecord ', volumeRecord);
            console.log('hello gpRecord ', gpRecord);
            console.log('hello gpTonneRecord ', gpTonneRecord);
            console.log('hello gpPercentageRecord ', gpPercentageRecord);
            
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
        });
        
    }

    handleChange(event){

         console.log('sales state handle value ' + event.target.value);
         console.log('target values ' + this.salesHistoryRecordsMap.get(event.target.value));

        if(event.target.value === 'Sales') {
            this.columns = salesColumns;
        }
        if(event.target.value === 'Volume') {
            this.columns = volColumns;
        }
        if(event.target.value === 'GP') {
            this.columns = GPColumns;
        }
        if(event.target.value === 'GpTonner') {
            this.columns = GpTonnerColumns;
        }
        if(event.target.value === 'GpPercentage') {
            this.columns = GpPercentageColumns;
        }
    }
}