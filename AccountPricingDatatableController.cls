/**
 * This class is the account pricing handler.
 *
 * @version     1.0
 */
public class AccountPricingDatatableController {
    @AuraEnabled 
    public static List<PriceIntegrationWrapper> getPricingList(String accId){
       system.debug('@@ '+accId);
        List<PriceIntegrationWrapper> priceIntegrationWrapperFilterList = new List<PriceIntegrationWrapper>();
        Set<String> univarProductName = new Set<String>();
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = :accId];
        for(Opportunity opp : [SELECT Univar_Product__c,Univar_Product__r.Name, AccountId, Id FROM Opportunity WHERE AccountId =: accId]){
            if(opp.Univar_Product__c != null && String.isNotBlank(opp.Univar_Product__r.Name)){
                univarProductName.add(opp.Univar_Product__r.Name);
            }
        }
        
        
        String json = QPriceIntegration.callQForPrices(acc.AccountNumber, acc.SalesOrg__c, acc.Customer_Code__c, '', '');
        //String json = '[ { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-12-01T00:00:00", "expiryDate": "2020-12-30T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-11-02T00:00:00", "expiryDate": "2020-11-30T23:59:59", "periodicCalcDate": "2020-11-27T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-10-01T00:00:00", "expiryDate": "2020-11-02T00:54:12.78", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-05-03T00:00:00", "expiryDate": "2021-05-31T23:59:59", "periodicCalcDate": "2021-05-28T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "L" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-04-01T00:00:00", "expiryDate": "2021-05-02T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-03-01T00:00:00", "expiryDate": "2021-03-31T23:59:59", "periodicCalcDate": "2021-03-30T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-02-01T00:00:00", "expiryDate": "2021-02-28T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" } ]';
        json = json.replace('currency', 'x_currency');
        List<PriceIntegrationWrapper> priceIntegrationWrapperList = (List<PriceIntegrationWrapper>)System.JSON.deserialize(json, List<PriceIntegrationWrapper>.class);
        if(priceIntegrationWrapperList.size() > 0){
            for(PriceIntegrationWrapper piw : priceIntegrationWrapperList){
                if(String.isNotBlank(piw.lskuName) && univarProductName.contains(piw.lskuName))
                priceIntegrationWrapperFilterList.add(piw);
            }
        }
        return priceIntegrationWrapperFilterList;
    }
    
    
    public Class PriceIntegrationWrapper {
        @AuraEnabled public String lskuCode;	//2025476
        @AuraEnabled public String lskuName;	//CAFLON APG C6 220K DNN
        @AuraEnabled public Integer esq;	//220
        @AuraEnabled public boolean isBulk;
        @AuraEnabled public Integer packWeight;	//220
        @AuraEnabled public String addressCode;	//10062158
        @AuraEnabled public String address;	//Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom
        @AuraEnabled public boolean isSoldTo;
        @AuraEnabled public String customerGroup;	//
        @AuraEnabled public String profile;	//Periodic
        @AuraEnabled public Double volume;	//0.88
        @AuraEnabled public String unitOfMeasure;	//to
        @AuraEnabled public Integer customerPrice;	//3725
        @AuraEnabled public String x_currency;	//GBP
        @AuraEnabled public boolean exWorks;
        @AuraEnabled public String effectiveDate;	//2020-12-01T00:00:00
        @AuraEnabled public String expiryDate;	//2020-12-30T23:59:59
        @AuraEnabled public String periodicCalcDate;
        @AuraEnabled public String validTo;
        @AuraEnabled public boolean cancelled;
        @AuraEnabled public String priceStatus;	//H
    }
}