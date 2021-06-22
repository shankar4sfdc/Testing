/**
 * Author : Mohsin Hassan
 * Created Date : 06 May 2021
 */
 import { LightningElement, api, wire, track } from 'lwc';
 import getBriefList from '@salesforce/apex/BriefListController.getBriefList';
 import getfilterData from '@salesforce/apex/BriefListController.filterData';
 import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 import { refreshApex } from '@salesforce/apex';
 import getUrgencyPickLists from '@salesforce/apex/BriefListController.getUrgencyPickLists';
 import getStatusPickLists from '@salesforce/apex/BriefListController.getStatusPickLists';
 
 const actions = [
     { label: 'Expire', name: 'Expire' },
     { label: 'View', name: 'View' },
 ];
 
 export default class briefList extends LightningElement {
     @track rowActions = [];
     @api filters = [];
     @api cols = [];
     clearBtn = true;
     filterList = []
     urgencyPickVal = [];
     statusPickVal = [];
     connectedCallback() {
         //This code is use to get the picklist value of Urgency field
         getUrgencyPickLists()
         .then(result => {
             console.log('result pp->'+JSON.stringify(result));
             for(let key in result) {
                 this.urgencyPickVal.push({
                     value : key,
                     label : result[key]
                 })
             }
 
             console.log('urgencyPickVal-->'+JSON.stringify(this.urgencyPickVal));
         })
         .catch(error=> {
             console.log('error pp->'+error);
         })
         //This code is use to get the picklist value of Status field
         getStatusPickLists()
         .then(result => {
             console.log('result pp->'+JSON.stringify(result));
             for(let key in result) {
                 this.statusPickVal.push({
                     value : key,
                     label : result[key]
                 })
             }
 
             console.log('statusPickVal-->'+JSON.stringify(this.statusPickVal));
         })
         .catch(error=> {
             console.log('error pp->'+error);
         })
     }    
 
     
     @track columns = [{
             label: 'Title',
             fieldName: 'Title__c',
             type: 'text',
             sortable: true,
             actions: [
                 { iconName: 'utility:filterList', label: 'Set Filter', name: 'Title', apiName: 'Title__c', fieldType: "text" },
                 { label: 'Clear Filter', disabled: this.clearBtn, name: 'clear_1', iconName: 'utility:clear' }
             ]
         },
         {
             label: 'Score',
             fieldName: 'Score_Count__c',
             type: 'Number',
             sortable: true,
             actions: [
                 { iconName: 'utility:filterList', label: 'Set Filter', name: 'Score', apiName: 'Score_Count__c', fieldType: "number" },
                 { label: 'Clear Filter', disabled: this.clearBtn, name: 'clear_2', iconName: 'utility:clear' }
             ]
         },
         {
             label: 'Importance',
             fieldName: 'Importance__c',
             type: 'text',
             sortable: true,
             actions: [
                 { iconName: 'utility:filterList', label: 'Set Filter', name: 'Importance', apiName: 'Importance__c', fieldType: "text" },
                 { label: 'Clear Filter', disabled: this.clearBtn, name: 'clear_3', iconName: 'utility:clear' }
             ]
         },
         {
             label: 'Urgency',
             fieldName: 'Urgency__c',
             type: 'Picklist',
             sortable: true,
             actions: [
                 { iconName: 'utility:filterList', label: 'Set Filter', name: 'Urgency', apiName: 'Urgency__c', fieldType: "picklist" },
                 { label: 'Clear Filter', disabled: this.clearBtn, name: 'clear_4', iconName: 'utility:clear' }
             ]
         },
         {
             label: 'Due By',
             fieldName: 'Due_Date__c',
             type: 'Date',
             sortable: true,
             actions: [
                 { iconName: 'utility:filterList', label: 'Set Filter', name: 'Due By', apiName: 'Due_Date__c', fieldType: "date" },
                 { label: 'Clear Filter', disabled: this.clearBtn, name: 'clear_5', iconName: 'utility:clear' }
             ]
         },
         {
             label: 'Status',
             fieldName: 'Status__c',
             type: 'Picklist',
             sortable: true,
             actions: [
                 { iconName: 'utility:filterList', label: 'Set Filter', name: 'Status', apiName: 'Status__c', fieldType: "picklist" },
                 { label: 'Clear Filter', disabled: this.clearBtn, name: 'clear_5', iconName: 'utility:clear' }
             ]
         },
         {
             label: 'Action',
             type: 'action',
             typeAttributes: { rowActions: actions },
         }, 
     ];
 
 
     @track filterValueName;
     filterFieldApiName;
     filterFieldType;
     @track error;
     @track briefList;
     refreshTable;
     //Boolean tracked variable to indicate if modal is open or not default value is false as modal is closed when page is loaded 
     @track isModalOpen = false;
     @track picklistModal = false;
     @track numberModal = false;
     @track textModal = false;
     @track dateModal = false;
     @track picklistUrgencyModal = false;
     @track picklistStatusModal = false;
     @wire(getBriefList)
     wiredAccounts({
         error,
         data
     }) {
         this.refreshTable = data;
         if (data) {
             this.briefList = data;
         } else if (error) {
             this.error = error;
         }
     };
 
 
     handleHeaderAction(event) {
         console.log(JSON.stringify(event));
         const actionName = event.detail.action.name;
         const columnType = event.detail.action.fieldType;
         alert(columnType);
         if(columnType == 'text'){
             this.picklistModal = false;
             this.numberModal = false;
             this.textModal = true;
             this.dateModal = false;
             this.picklistUrgencyModal = false;
             this.picklistStatusModal = false;
         }else if(columnType == 'picklist'){
             this.picklistModal = true;
             this.numberModal = false;
             this.textModal = false;
             this.dateModal = false;
             if(actionName == 'Urgency'){
                 this.picklistUrgencyModal = true;
                 this.picklistStatusModal = false;
             }
             else{
                 this.picklistUrgencyModal = false;
                 this.picklistStatusModal = true;
             }
             
         }else if(columnType == 'number'){
             this.picklistModal = false;
             this.picklistUrgencyModal = false;
             this.picklistStatusModal = false;
             this.numberModal = true;
             this.textModal = false;
             this.dateModal = false;
         }else if(columnType == 'date'){
             this.picklistModal = false;
             this.numberModal = false;
             this.textModal = false;
             this.dateModal = true;
             this.picklistUrgencyModal = false;
             this.picklistStatusModal = false;
         }
         let filterColumns = JSON.parse(JSON.stringify([...this.columns]));
         console.log('actionName',actionName)
         if (actionName.startsWith('clear')) {
             getBriefList({'briefList':this.briefList})
                 .then(result => {
                     this.briefList = result;
                     for (var i = 0; i < filterColumns.length; i++) {
                         if (filterColumns[i].label == actionName) {
                             filterColumns[i].actions[1].disabled = true;
                             filterColumns[i].actions[0].disabled = false;
                         }
                     }
                 })
                 .catch(error => {
                     window.console.log('Error ====> ' + error);
                     this.dispatchEvent(new ShowToastEvent({
                         title: 'Error!!',
                         message: error.message,
                         variant: 'error'
                     }), );
                 });
         } else {
             for (var i = 0; i < filterColumns.length; i++) {
                 if (filterColumns[i].label == actionName) {
                     filterColumns[i].actions[1].disabled = false;
                     filterColumns[i].actions[0].disabled = true;
                 }
             }
             const cols = this.columns;
             const filter = this.filter;
             this.isModalOpen = true;
             
             let data = { "name": event.detail.action.name, "apiName": event.detail.action.apiName, "fieldType": event.detail.columnDefinition.type };
             console.log('data : ',data)
             this.handleFilter(data);
         }
         this.columns = [...filterColumns];
     }
 
     handleFilter(event) {
         this.filterValueName = event.name;
         this.filterFieldApiName = event.apiName;
         this.filterFieldType = event.fieldType;
     }
 
     openModal() {
         // to open modal set isModalOpen tarck value as true
         this.isModalOpen = true;
     }
     closeModal() {
         // to close modal set isModalOpen tarck value as false
         this.isModalOpen = false;
         this.picklistModal = false;
         this.numberModal = false;
         this.textModal = false;
         this.dateModal = false;
     }
     submitDetails(event) {
         event.preventDefault();
         const filterInp = this.template.querySelector('.filter_input');
         alert('filterFieldType-->' + this.filterFieldType);
        // console.log('this.accList',JSON.parse(JSON.stringify(this.accList)))
         getfilterData({ filterValue: filterInp.value, fieldAPIName: this.filterFieldApiName, fieldType: this.filterFieldType,briefList:this.briefList })
             .then(result => {
                 if (result.status === 'SUCCESS') {
                     if (result.body) {
                         const event = new ShowToastEvent({
                             title: result.status,
                             message: result.message,
                             variant: 'success',
                             mode: 'dismissable'
                         });
                         this.dispatchEvent(event);
                         this.briefList = result.body;
                     } else {
                         const event = new ShowToastEvent({
                             title: result.status,
                             message: result.message,
                             variant: 'info',
                             mode: 'dismissable'
                         });
                         this.dispatchEvent(event);
                         this.briefList = result.body;
                     }
                 } else {
                     const event = new ShowToastEvent({
                         title: result.status,
                         message: result.message,
                         variant: 'info',
                         mode: 'dismissable'
                     });
                     this.dispatchEvent(event);
                     this.briefList = result.body;
                 }
             })
             .catch(error => {
                 console.log('error-->' + JSON.stringify(error));
                 const event = new ShowToastEvent({
                     title: 'ERROR',
                     message: error.message,
                     variant: 'error',
                     mode: 'dismissable'
                 });
                 this.dispatchEvent(event);
             });
         // to close modal set isModalOpen tarck value as false
         //Add your code to call apex method or do some processing
         this.isModalOpen = false;
     }
 
     
 
     refresh() {
         return refreshApex(this.refreshTable);
     }
 }