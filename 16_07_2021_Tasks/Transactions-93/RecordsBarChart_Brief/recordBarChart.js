import {LightningElement, api, wire, track} from 'lwc';
import getBriefTransactions from '@salesforce/apex/transactions.getBriefTransactions';
export default class RecordsBarChart extends LightningElement {
 @track chartConfiguration;
 @api recordId;
 @wire(getBriefTransactions, {})
 getBriefTransactions({error, data}) {
  if (error) {
   this.error = error;
   console.log('error => ' + JSON.stringify(error));
   this.chartConfiguration = undefined;
  } else if (data) {
   let chartAmtData = [];
   let chartAmt1Data = [];
   let chartAmt10Data = [];
   let chartAmt11Data = [];
   let chartAmt2Data = [];
   let chartAmt3Data = [];
   let chartAmt4Data = [];
   let chartAmt5Data = [];
   let chartAmt6Data = [];
   let chartAmt7Data = [];
   let chartAmt8Data = [];
   let chartAmt9Data = [];
   let chartLabels = [];
   data.forEach(prodHist => {
    chartAmt1Data.push(prodHist.Quantity01__c);
    chartAmt10Data.push(prodHist.Quantity10__c);
    chartAmt9Data.push(prodHist.Quantity09__c);
    chartAmt8Data.push(prodHist.Quantity08__c);
    chartAmt7Data.push(prodHist.Quantity07__c);
    chartAmt6Data.push(prodHist.Quantity06__c);
    chartAmt5Data.push(prodHist.Quantity05__c);
    chartAmt4Data.push(prodHist.Quantity04__c);
    chartAmt3Data.push(prodHist.Quantity03__c);
    chartAmt2Data.push(prodHist.Quantity02__c);

    chartLabels.push(prodHist.Period01__c);   
    chartLabels.push(prodHist.Period10__c);
    chartLabels.push(prodHist.Period09__c);
    chartLabels.push(prodHist.Period08__c);
    chartLabels.push(prodHist.Period07__c);
    chartLabels.push(prodHist.Period06__c);
    chartLabels.push(prodHist.Period05__c);
    chartLabels.push(prodHist.Period04__c);
    chartLabels.push(prodHist.Period03__c);
    chartLabels.push(prodHist.Period02__c);
   });
    /*chartLabels.push(prodHist.Period01__c);   
    chartLabels.push(prodHist.Period10__c);
    chartLabels.push(prodHist.Period09__c);
    chartLabels.push(prodHist.Period08__c);
    chartLabels.push(prodHist.Period07__c);
    chartLabels.push(prodHist.Period06__c);
    chartLabels.push(prodHist.Period05__c);
    chartLabels.push(prodHist.Period04__c);
    chartLabels.push(prodHist.Period03__c);
    chartLabels.push(prodHist.Period02__c);*/
   this.chartConfiguration = {
    type: 'bar',
    data: {
        labels: chartLabels,
        datasets: [
        {
        label: 'March',
        //barPercentage: 0.5,
        //barThickness: 6,
        //maxBarThickness: 8,
        //minBarLength: 2,
        backgroundColor: "#7cc8e6",
        data: chartAmt3Data,
        },
        {
            label: 'April',
            backgroundColor: "green",
            data: chartAmt4Data,
        },
        {
            label: 'May',
            backgroundColor: "green",
            data: chartAmt5Data,
        },
        {
            label: 'June',
            backgroundColor: "green",
            data: chartAmt6Data,
        },
        {
            label: 'July',
            backgroundColor: "green",
            data: chartAmt7Data,
        },
        {
            label: 'August',
            backgroundColor: "green",
            data: chartAmt8Data,
        },
        {
            label: 'September',
            backgroundColor: "green",
            data: chartAmt9Data,
        },
        {
            label: 'Oct',
            backgroundColor: "green",
            data: chartAmt10Data,
        },
        {
            label: 'Nov',
            backgroundColor: "green",
            data: chartAmt11Data,
        },
        {
            label: 'Dec',
            backgroundColor: "green",
            data: chartAmtData,
        },
        {
            label: 'Jan',
            backgroundColor: "green",
            data: chartAmt1Data,
        },
        {
            label: 'Feb',
            backgroundColor: "green",
            data: chartAmt2Data,
        },
     ],
    },
    options: {
    },
   };
   console.log('data => ', data);
   this.error = undefined;
  }
 }
}