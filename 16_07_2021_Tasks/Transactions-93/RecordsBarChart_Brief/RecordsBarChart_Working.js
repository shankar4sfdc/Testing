import {LightningElement, wire, track} from 'lwc';
import getobjData from '@salesforce/apex/chartController.getobjData';
export default class RecordsBarChart extends LightningElement {
 @track chartConfiguration;

 @wire(getobjData, {})
 getobjData({error, data}) {
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
    /*chartAmtData.push(opp.Amount);
    chartAmt1Data.push(opp.Amount_1__c);
    chartAmt10Data.push(opp.amount_10__c);
    chartAmt11Data.push(opp.amount_11__c);
    chartAmt9Data.push(opp.amount_9__c);
    chartAmt8Data.push(opp.amount_8__c);
    chartAmt7Data.push(opp.amount_7__c);
    chartAmt6Data.push(opp.amount_6__c);
    chartAmt5Data.push(opp.amount_5__c);
    chartAmt4Data.push(opp.amount_4__c);
    chartAmt3Data.push(opp.amount_3__c);
    chartAmt2Data.push(opp.amount_2__c);*/

    /*chartAmt1Data.push(prodHist.Quantity01__c);
    chartLabels.push(prodHist.Period01__c);
    chartAmt10Data.push(prodHist.Quantity10__c);
    chartLabels.push(prodHist.Period10__c);
    chartAmt9Data.push(prodHist.Quantity09__c);
    chartLabels.push(prodHist.Period09__c);
    chartAmt8Data.push(prodHist.Quantity08__c);
    chartLabels.push(prodHist.Period08__c);
    chartAmt7Data.push(prodHist.Quantity07__c);
    chartLabels.push(prodHist.Period07__c);
    chartAmt6Data.push(prodHist.Quantity06__c);
    chartLabels.push(prodHist.Period06__c);
    chartAmt5Data.push(prodHist.Quantity05__c);
    chartLabels.push(prodHist.Period05__c);
    chartAmt4Data.push(prodHist.Quantity04__c);
    chartLabels.push(prodHist.Period04__c);
    chartAmt3Data.push(prodHist.Quantity03__c);
    chartLabels.push(prodHist.Period03__c);
    chartAmt2Data.push(prodHist.Quantity02__c);
    chartLabels.push(prodHist.Period02__c);

    chartAmt1Data.push(prodHist.Quantity01__c);
    chartAmt10Data.push(prodHist.Quantity10__c);
    chartAmt9Data.push(prodHist.Quantity09__c);
    chartAmt8Data.push(prodHist.Quantity08__c);
    chartAmt7Data.push(prodHist.Quantity07__c);
    chartAmt6Data.push(prodHist.Quantity06__c);
    chartAmt5Data.push(prodHist.Quantity05__c);
    chartAmt4Data.push(prodHist.Quantity04__c);
    chartAmt3Data.push(prodHist.Quantity03__c);
    chartAmt2Data.push(prodHist.Quantity02__c);*/
    chartAmt3Data.push(prodHist.Quantity01__c);
    chartAmt3Data.push(prodHist.Quantity10__c);
    chartAmt3Data.push(prodHist.Quantity09__c);
    chartAmt3Data.push(prodHist.Quantity08__c);
    chartAmt3Data.push(prodHist.Quantity07__c);
    chartAmt3Data.push(prodHist.Quantity06__c);
    chartAmt3Data.push(prodHist.Quantity05__c);
    chartAmt3Data.push(prodHist.Quantity04__c);
    chartAmt3Data.push(prodHist.Quantity03__c);
    chartAmt3Data.push(prodHist.Quantity02__c);
    
    if(chartLabels.indexOf(prodHist.Period01__c)===-1)
        chartLabels.push(prodHist.Period01__c);   
    if(chartLabels.indexOf(prodHist.Period10__c)===-1)
        chartLabels.push(prodHist.Period10__c);
    if(chartLabels.indexOf(prodHist.Period09__c)===-1)
        chartLabels.push(prodHist.Period09__c);
    if(chartLabels.indexOf(prodHist.Period08__c)===-1)
        chartLabels.push(prodHist.Period08__c);
    if(chartLabels.indexOf(prodHist.Period07__c)===-1)
        chartLabels.push(prodHist.Period07__c);
    if(chartLabels.indexOf(prodHist.Period06__c)===-1)
        chartLabels.push(prodHist.Period06__c);
    if(chartLabels.indexOf(prodHist.Period05__c)===-1)
        chartLabels.push(prodHist.Period05__c);
    if(chartLabels.indexOf(prodHist.Period04__c)===-1)
        chartLabels.push(prodHist.Period04__c);
    if(chartLabels.indexOf(prodHist.Period03__c)===-1)
        chartLabels.push(prodHist.Period03__c);
    if(chartLabels.indexOf(prodHist.Period02__c)===-1)
        chartLabels.push(prodHist.Period02__c);

   });
    /*chartLabels.push('Mar-20');
    chartLabels.push('Apr-20');
    chartLabels.push('May-20');
    chartLabels.push('Jun-20');
    chartLabels.push('Jul-20');
    chartLabels.push('Aug-20');
    chartLabels.push('Sep-20');
    chartLabels.push('Oct-20');
    chartLabels.push('Nov-20');
    chartLabels.push('Dec-20');
    chartLabels.push('Jan-21');
    chartLabels.push('Feb-21');*/    
    
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
        /*{
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
        },*/

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
