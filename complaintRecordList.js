/**
 * This is the javascript component for complaints LWC which calls the Account Complaints handler to get the complaints related to an account on the brief.
 *
 * @author      Created by 10200312 on 16/06/2021
 * @version     1.0
 */

import { LightningElement, track, api, wire } from 'lwc';
import getComplaints from '@salesforce/apex/AccountComplaintsHandler.getComplaints';
const complaints = [], openComplaintsRecord=[], closedComplaintsRecord=[];
var closedSizeTxt='';
var openSizeTxt='';


export default class complaintRecordList extends LightningElement {
    @track complaintRecord;
    @api recordId;
    //data = data;
    complaints = complaints;
    openComplaintsRecord = openComplaintsRecord;
    closedComplaintsRecord = closedComplaintsRecord;
    closedSizeTxt = closedSizeTxt;
    openSizeTxt = openSizeTxt;

    activeSections='';

    handleToggleSection(event) {
        this.activeSections = event.detail.openSections;
    }

    renderedCallback(){
         
        getComplaints({briefId: this.recordId})
        .then(result => {
            console.log('Result==>',result);
            this.complaints = result;
            console.log('Inside Result Block complaints==>',this.complaints);
            this.error = undefined;            
            this.openComplaintsRecord = this.complaints.filter(complaints => complaints.status === 'Open');
            this.openSizeTxt = 'Open(' + this.openComplaintsRecord.length +')';
            this.closedComplaintsRecord = this.complaints.filter(complaints => complaints.status === 'Closed');
            this.closedSizeTxt = 'Closed(' + this.closedComplaintsRecord.length +')';            
            console.log('openComplaintsRecord Status ==>'+this.openComplaintsRecord);
            console.log('openComplaintsRecord Length ==>'+this.openSizeTxt);
            console.log('closedComplaintsRecord Status ==>'+this.closedComplaintsRecord);
            console.log('closedComplaintsRecord Length ==>'+this.closedSizeTxt);
        })
        .catch(error => {
            this.error = error;
            console.log('this.error==>',this.error);
            console.log('Inside error block complaints==>',this.complaints);
            this.complaints = undefined;
        });

    }
     
}