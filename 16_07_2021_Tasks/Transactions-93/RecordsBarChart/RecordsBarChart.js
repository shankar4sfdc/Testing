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
   data.forEach(opp => {
    chartAmtData.push(opp.Amount);
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
    chartAmt2Data.push(opp.amount_2__c);

   });
    chartLabels.push('Mar-20');
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
    chartLabels.push('Feb-21');
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
