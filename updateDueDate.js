import { LightningElement, api, track } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';  
import getBriefDetails from '@salesforce/apex/UpdateDueDateController.getBriefDetails';
import updateDueDates from '@salesforce/apex/UpdateDueDateController.updateDueDates';

export default class UpdateDueDate extends NavigationMixin(LightningElement) {

    @api selectedRecords;
    @track selectedBriefList = {};
    @track brief = [];
    @track showSpinner = true;
    
    connectedCallback() {
        console.log('selectedRecords==>LWC==>',this.selectedRecords)
        getBriefDetails({
            selAccLst : this.selectedRecords
        })
        .then(result => {
            this.showSpinner = false;
            console.table(result);
            this.selectedBriefList = result;
            this.brief = this.selectedBriefList;
            console.log('this.selectedBriefList-->'+this.selectedBriefList[0].Id);
            console.log('brief-->'+JSON.stringify(this.brief));
        })
        .catch(error => {
            console.log(error);
        })
    }
    updateBrief(){
        this.showSpinner = true;
        console.log('brief-->'+JSON.stringify(this.brief));
        updateDueDates({
            briefList : JSON.parse(JSON.stringify(this.brief))
        })
        .then(result => {
            if(result=='Success'){
                this.navigateToBriefRelatedList();
            }else{
                
            }
            console.table(result);
        })
        .catch(error => {
            console.log(error);
        })
    }
    updateValues(event){
        //let foundelement = this.brief.find(ele => ele.Id == event.target.dataset.id);
        for(var i=0;i<this.brief.length;i++){
            this.brief[i].Due_Date__c = event.target.value;
        }
        //foundelement.Due_Date__c = event.target.value;
        //this.brief = [...this.brief];
        console.table(JSON.stringify(this.brief));
    }
    // Navigation to Contact related list of account
    navigateToBriefRelatedList() {
       window.location.pathname = '/lightning/r/Brief__c/'+this.brief[0].Account__c+'/related/Briefs__r/view';
    }
}