/**
 * This is the javascript component for complaints LWC which calls the Account Complaints handler to get the complaints related to an account on the brief.
 *
 * @author      Created by 10200312 on 22/06/2021
 * @version     1.0
 */
import {LightningElement, api, wire, track} from 'lwc';
import getAccountOTIFS from '@salesforce/apex/AccountOTIFSHandler.getAccountOTIFS';
const columns = [], oTIFS = [];
export default class Otifdatatable extends LightningElement {
    @api recordId;
    @track isLoading = false;

    oTIFS = oTIFS;
    columns = columns;

    connectedCallback() {
        this.isLoading = true;
        getAccountOTIFS({ accountId: this.recordId })
            .then(result => {
                console.log('Result==>', JSON.stringify(result));
                this.oTIFS = result.materialValues;
                console.log('--result Length---' + result.length);
                console.log('--OTIF Length---' + oTIFS.length);

                console.log('Inside Result Block OTIFS==>', this.oTIFS);
                this.columns = result.headerWrappers;

                console.log('Inside Result Block column headers==>', this.columns);

                this.isLoading = false;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                console.log('this.error==>', this.error);
                console.log('Inside error block OTIFS==>', this.oTIFS);
                this.isLoading = false;
                this.oTIFS = undefined;
            });

    }
}