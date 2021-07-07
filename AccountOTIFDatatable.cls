public class AccountOTIFSHandler {
 
    @AuraEnabled
    public static oTIFDataTableWrapperMonths getOTIFS(String briefId){
        system.debug('@@ '+briefId);

        /*Set<String> univarProductName = new Set<String>();
       
        Brief__c brief = [SELECT Id, Account__r.Id from Brief__C WHERE Id = :briefId];
       
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = : brief.Account__r.Id];
       
        system.debug('Account Id:'+acc.Id);     */

        //String json = DataWareHouseIntegration.callDWForOTIFsAPI(acc.Customer_Code__c,acc.SalesOrg__c);

        String json = '[{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-03-01T00:00:00","value":95.0},' +
                        '{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-04-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-05-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-06-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-07-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-08-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-09-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-10-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-11-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-12-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-01-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-02-01T00:00:00","value":95.0}]';
       
        system.debug('JSON returned is:'+Json);
       
        List<oTIFIntegrationWrapper> oTIFIntegrationWrapperList = (List<oTIFIntegrationWrapper>)System.JSON.deserialize(json, List<oTIFIntegrationWrapper>.class);
       
        system.debug('oTIFIntegrationWrapperList returned is:'+oTIFIntegrationWrapperList);
       
        map<String,List<oTIFIntegrationWrapper>> materialwiseData = new map<String,List<oTIFIntegrationWrapper>>();
        for(oTIFIntegrationWrapper jw : oTIFIntegrationWrapperList)
        {
            System.debug('--Month-->'+jw.month+'<--next-->'+jw.month.month()+'<--year-->'+jw.month.year());
            //converting list to map based on material
            if(materialwiseData.containsKey(jw.material))
            {
                List<oTIFIntegrationWrapper> monthValues = materialwiseData.get(jw.material);
monthValues.add(jw);
materialwiseData.put(jw.material, monthValues);
            }
            else
            {
                materialwiseData.put(jw.material, new List<oTIFIntegrationWrapper> { jw });
            }
            //preparing headerValues list
           
        }
       
        List<oTIFDataTableWrapper> materialwiseList = new List<oTIFDataTableWrapper>();
        List<String> monthNames = new List<String>{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
        List<headerwrapper> headerValues = new List<headerwrapper>();
        oTIFDataTableWrapperMonths oTIFDataTableWrapperMonth = new oTIFDataTableWrapperMonths();
       
        for(string str : materialwiseData.keyset())
        {
            oTIFDataTableWrapper jwm = new oTIFDataTableWrapper();          
           
            jwm.material = str;
           
            headerwrapper hwp = new headerwrapper();
            hwp.label = 'Material(Code)';
            hwp.fieldName = 'material';
            hwp.type = 'text';
           
            if(!headerValues.contains(hwp))            
            headerValues.add(hwp);
           
            for(oTIFIntegrationWrapper jw : materialwiseData.get(str))
            {
            jwm.fiscalyear = jwm.fiscalyear!=null ? (jwm.fiscalyear<jw.month.year()?jwm.fiscalyear:jw.month.year() ) : jw.month.year();
                //system.debug('month--->'+jw.month);
                //system.debug('month--->'+jw.month.format());
                switch on jw.month.month() {
                    when 1{
                        jwm.value_Month_1 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);

headerwrapper hwp1 = new headerwrapper();
                        hwp1.label = hstr;
                        hwp1.fieldName = 'value_Month_1';
                        hwp1.type = 'text';
                       
                        if(!headerValues.contains(hwp1))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 2{
                        jwm.value_Month_2 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp2 = new headerwrapper();
hwp2.label = hstr;
                        hwp2.fieldName = 'value_Month_2';
                        hwp2.type = 'text';
                       
                        if(!headerValues.contains(hwp2))            
                        headerValues.add(hwp2);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 3{
                        jwm.value_Month_3 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp3 = new headerwrapper();
hwp3.label = hstr;
                        hwp3.fieldName = 'value_Month_3';
                        hwp3.type = 'text';
                       
                        if(!headerValues.contains(hwp3))            
                        headerValues.add(hwp3);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 4{
                        jwm.value_Month_4 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp4 = new headerwrapper();
hwp4.label = hstr;
                        hwp4.fieldName = 'value_Month_4';
                        hwp4.type = 'text';
                       
                        if(!headerValues.contains(hwp4))            
                        headerValues.add(hwp4);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);
                    }
                    when 5{
                        jwm.value_Month_5 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp5 = new headerwrapper();
hwp5.label = hstr;
                        hwp5.fieldName = 'value_Month_5';
                        hwp5.type = 'text';
                       
                        if(!headerValues.contains(hwp5))            
                        headerValues.add(hwp5);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 6{
                        jwm.value_Month_6 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp6 = new headerwrapper();
hwp6.label = hstr;
                        hwp6.fieldName = 'value_Month_6';
                        hwp6.type = 'text';
                       
                        if(!headerValues.contains(hwp6))            
                        headerValues.add(hwp6);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 7{
                        jwm.value_Month_7 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                                               
                        headerwrapper hwp7 = new headerwrapper();
hwp7.label = hstr;
                        hwp7.fieldName = 'value_Month_7';
                        hwp7.type = 'text';
                       
                        if(!headerValues.contains(hwp7))            
                        headerValues.add(hwp7);

                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 8{
                        jwm.value_Month_8 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                                               
                        headerwrapper hwp8 = new headerwrapper();
hwp8.label = hstr;
                        hwp8.fieldName = 'value_Month_8';
                        hwp8.type = 'text';
                       
                        if(!headerValues.contains(hwp8))            
                        headerValues.add(hwp8);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 9{
                        jwm.value_Month_9 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp9 = new headerwrapper();
hwp9.label = hstr;
                        hwp9.fieldName = 'value_Month_9';
                        hwp9.type = 'text';
                       
                        if(!headerValues.contains(hwp9))            
                        headerValues.add(hwp9);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 10{
                        jwm.value_Month_10 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp10 = new headerwrapper();
hwp10.label = hstr;
                        hwp10.fieldName = 'value_Month_10';
                        hwp10.type = 'text';
                       
                        if(!headerValues.contains(hwp10))            
                        headerValues.add(hwp10);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 11{
                        jwm.value_Month_11 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                         
                        headerwrapper hwp11 = new headerwrapper();
hwp11.label = hstr;
                        hwp11.fieldName = 'value_Month_11';
                        hwp11.type = 'text';
                       
                        if(!headerValues.contains(hwp11))            
                        headerValues.add(hwp11);
                    }
                    when 12{
                        jwm.value_Month_12 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        headerwrapper hwp12 = new headerwrapper();
hwp12.label = hstr;
                        hwp12.fieldName = 'value_Month_12';
                        hwp12.type = 'text';
                       
                        if(!headerValues.contains(hwp12))            
                        headerValues.add(hwp12);


                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                }
            }
           
            system.debug('headerValues is:'+headerValues);
            materialwiseList.add(jwm);
                   
            oTIFDataTableWrapperMonth.headerWrappers = headerValues;
            oTIFDataTableWrapperMonth.materialValues = materialwiseList;
           
        }
       
        for(OTIFIntegrationWrapper oiw:oTIFIntegrationWrapperList)
        {
          system.debug('oTIFIntegrationWrapper returned is:'+oiw);
        }


        return oTIFDataTableWrapperMonth;      
    }    
   
    public Class oTIFIntegrationWrapper {
        @AuraEnabled public String material;
        @AuraEnabled public String univarProduct;
        @AuraEnabled public String cPP;
        @AuraEnabled public DateTime month;
        @AuraEnabled public Decimal value;
    }

    public Class oTIFDataTableWrapper {
        @AuraEnabled public String material {get;set;}
        @AuraEnabled public Decimal value_Month_1 {get;set;}
        //@AuraEnabled public List<String> name_Of_Months;
        @AuraEnabled public Decimal value_Month_2 {get;set;}
        @AuraEnabled public Decimal value_Month_3 {get;set;}
        @AuraEnabled public Decimal value_Month_4 {get;set;}
        @AuraEnabled public Decimal value_Month_5 {get;set;}
        @AuraEnabled public Decimal value_Month_6 {get;set;}
        @AuraEnabled public Decimal value_Month_7 {get;set;}
        @AuraEnabled public Decimal value_Month_8 {get;set;}
        @AuraEnabled public Decimal value_Month_9 {get;set;}
        @AuraEnabled public Decimal value_Month_10 {get;set;}
        @AuraEnabled public Decimal value_Month_11 {get;set;}
        @AuraEnabled public Decimal value_Month_12 {get;set;}
        @AuraEnabled public Integer fiscalyear {get;set;}
    }

    public class headerwrapper
    {
            @AuraEnabled public string label {get;set;}
            @AuraEnabled public string fieldName {get;set;}
            @AuraEnabled public string type {get;set;}
     }  
   
    public Class oTIFDataTableWrapperMonths {
        @AuraEnabled public List<headerwrapper> headerWrappers {get;set;}
        @AuraEnabled public List<oTIFDataTableWrapper> materialValues {get;set;}
    }    

}

On Wed, Jul 7, 2021 at 8:32 AM Siddam Arts <shankar4sfdc@gmail.com> wrote:
----LWC HTML-----
<template>
   <div style="height: 300px;">
       <lightning-datatable
               key-field="id"
               data={oTIFS}
               columns={columns}>
       </lightning-datatable>
   </div>    
</template>
-----LWC JS -------------
/**
 * This is the javascript component for complaints LWC which calls the Account Complaints handler to get the complaints related to an account on the brief.
 *
 * @author      Created by 10200312 on 22/06/2021
 * @version     1.0
 */
import { LightningElement, api, wire } from 'lwc';
import getOTIFs from '@salesforce/apex/AccountOTIFSHandler.getOTIFS';
const columns = [], oTIFS = [];
//const complaints = [], openComplaintsRecord=[], closedComplaintsRecord=[];
//var closedSizeTxt='';
//var openSizeTxt='';

export default class Otifdatatable extends LightningElement {
    @api recordId;
    oTIFS = oTIFS;
    columns = columns;

    connectedCallback(){

        getOTIFs({briefId: this.recordId})
        .then(result => {
            console.log('Result==>',result);
            this.oTIFS = result[0].materialValues;
            console.log('--result Length---'+result.length);
            console.log('--OTIF Length---'+oTIFS.length);
            //oTIFS = Object.keys(oTIFS).map(key=> ({ key: key, ...oTIFS[key] }));
            //return fields;
            console.log('Inside Result Block OTIFS==>',this.oTIFS);
            //console.log('Inside Result Block OTIFS==>',this.oTIFS.Material);

            this.columns = result[0].headerStrings;

            console.log('Inside Result Block column headers==>',this.columns);

            /*console.log('Inside Result Block OTIFS==>',this.oTIFS.Material);
            var date = new Date();
            date.setDate(1);
            console.log('date-'+date);
            var lastMonths = [],
                monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
            for (var i = 0; i < 11; i++) {
                //console.log('Month number-'+date.getMonth());
                var str= date.getFullYear()+'';
                str= str.match(/\d{2}$/);
                lastMonths.push(monthNames[date.getMonth()]+ '-' + str);
                date.setMonth(date.getMonth() - 1);
            }
            lastMonths = lastMonths.reverse();
            console.log(lastMonths);*/
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            console.log('this.error==>',this.error);
            console.log('Inside error block OTIFS==>',this.oTIFS);
            this.oTIFS = undefined;
        });

        }
}

----Apex Code----
public class AccountOTIFSHandler {
 
    @AuraEnabled
    public static oTIFDataTableWrapperMonths getOTIFS(String briefId){
        system.debug('@@ '+briefId);

        /*Set<String> univarProductName = new Set<String>();
       
        Brief__c brief = [SELECT Id, Account__r.Id from Brief__C WHERE Id = :briefId];
       
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = : brief.Account__r.Id];
       
        system.debug('Account Id:'+acc.Id);     */

        //String json = DataWareHouseIntegration.callDWForOTIFsAPI(acc.Customer_Code__c,acc.SalesOrg__c);

        String json = '[{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-03-01T00:00:00","value":95.0},' +
                        '{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-04-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-05-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-06-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-07-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-08-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-09-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-10-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-11-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-12-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-01-01T00:00:00",' +
                        '"value":95.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-02-01T00:00:00","value":95.0}]';
       
        system.debug('JSON returned is:'+Json);
       
        List<oTIFIntegrationWrapper> oTIFIntegrationWrapperList = (List<oTIFIntegrationWrapper>)System.JSON.deserialize(json, List<oTIFIntegrationWrapper>.class);
       
        system.debug('oTIFIntegrationWrapperList returned is:'+oTIFIntegrationWrapperList);
       
        map<String,List<oTIFIntegrationWrapper>> materialwiseData = new map<String,List<oTIFIntegrationWrapper>>();
        for(oTIFIntegrationWrapper jw : oTIFIntegrationWrapperList)
        {
            System.debug('--Month-->'+jw.month+'<--next-->'+jw.month.month()+'<--year-->'+jw.month.year());
            //converting list to map based on material
            if(materialwiseData.containsKey(jw.material))
            {
                List<oTIFIntegrationWrapper> monthValues = materialwiseData.get(jw.material);
monthValues.add(jw);
materialwiseData.put(jw.material, monthValues);
            }
            else
            {
                materialwiseData.put(jw.material, new List<oTIFIntegrationWrapper> { jw });
            }
            //preparing headerValues list
           
        }
       
        List<oTIFDataTableWrapper> materialwiseList = new List<oTIFDataTableWrapper>();
        List<String> monthNames = new List<String>{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
        List<headerwrapper> headerValues = new List<headerwrapper>();
        oTIFDataTableWrapperMonths oTIFDataTableWrapperMonth = new oTIFDataTableWrapperMonths();
       
        for(string str : materialwiseData.keyset())
        {
            oTIFDataTableWrapper jwm = new oTIFDataTableWrapper();          
           
            jwm.material = str;
           
            headerwrapper hwp = new headerwrapper();
            hwp.label = 'Material(Code)';
            hwp.fieldName = 'material';
            hwp.type = 'text';
           
            if(!headerValues.contains(hwp))            
            headerValues.add(hwp);
           
            for(oTIFIntegrationWrapper jw : materialwiseData.get(str))
            {
            jwm.fiscalyear = jwm.fiscalyear!=null ? (jwm.fiscalyear<jw.month.year()?jwm.fiscalyear:jw.month.year() ) : jw.month.year();
                //system.debug('month--->'+jw.month);
                //system.debug('month--->'+jw.month.format());
                switch on jw.month.month() {
                    when 1{
                        jwm.value_Month_1 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_1';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 2{
                        jwm.value_Month_2 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_2';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 3{
                        jwm.value_Month_3 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_3';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 4{
                        jwm.value_Month_4 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_4';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);
                    }
                    when 5{
                        jwm.value_Month_5 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_5';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 6{
                        jwm.value_Month_6 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_6';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 7{
                        jwm.value_Month_7 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                                               
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_7';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);

                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 8{
                        jwm.value_Month_8 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                                               
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_8';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 9{
                        jwm.value_Month_9 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_9';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 10{
                        jwm.value_Month_10 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_10';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                    when 11{
                        jwm.value_Month_11 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                         
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_11';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                    }
                    when 12{
                        jwm.value_Month_12 = jw.value;
                        String hstr = monthNames[jw.month.month()-1]+'-'+String.valueOf(jw.month.year()).substring(2, 4);
                       
                        hwp.label = hstr;
                        hwp.fieldName = 'value_Month_12';
                        hwp.type = 'text';
                       
                        if(!headerValues.contains(hwp))            
                        headerValues.add(hwp);
                       
                        system.debug('hwp is:'+hwp);
                        system.debug('headerValues is:'+headerValues);                        
                    }
                }
            }
           
            system.debug('headerValues is:'+headerValues);
            materialwiseList.add(jwm);
                   
            oTIFDataTableWrapperMonth.headerWrappers = headerValues;
            oTIFDataTableWrapperMonth.materialValues = materialwiseList;
           
        }
       
        for(OTIFIntegrationWrapper oiw:oTIFIntegrationWrapperList)
        {
          system.debug('oTIFIntegrationWrapper returned is:'+oiw);
        }


        return oTIFDataTableWrapperMonth;      
    }    
   
    public Class oTIFIntegrationWrapper {
        @AuraEnabled public String material;
        @AuraEnabled public String univarProduct;
        @AuraEnabled public String cPP;
        @AuraEnabled public DateTime month;
        @AuraEnabled public Decimal value;
    }

    public Class oTIFDataTableWrapper {
        @AuraEnabled public String material {get;set;}
        @AuraEnabled public Decimal value_Month_1 {get;set;}
        //@AuraEnabled public List<String> name_Of_Months;
        @AuraEnabled public Decimal value_Month_2 {get;set;}
        @AuraEnabled public Decimal value_Month_3 {get;set;}
        @AuraEnabled public Decimal value_Month_4 {get;set;}
        @AuraEnabled public Decimal value_Month_5 {get;set;}
        @AuraEnabled public Decimal value_Month_6 {get;set;}
        @AuraEnabled public Decimal value_Month_7 {get;set;}
        @AuraEnabled public Decimal value_Month_8 {get;set;}
        @AuraEnabled public Decimal value_Month_9 {get;set;}
        @AuraEnabled public Decimal value_Month_10 {get;set;}
        @AuraEnabled public Decimal value_Month_11 {get;set;}
        @AuraEnabled public Decimal value_Month_12 {get;set;}
        @AuraEnabled public Integer fiscalyear {get;set;}
    }

    public class headerwrapper
    {
            @AuraEnabled public string label {get;set;}
            @AuraEnabled public string fieldName {get;set;}
            @AuraEnabled public string type {get;set;}
     }  
   
    public Class oTIFDataTableWrapperMonths {
        @AuraEnabled public List<headerwrapper> headerWrappers {get;set;}
        @AuraEnabled public List<oTIFDataTableWrapper> materialValues {get;set;}
    }    

}