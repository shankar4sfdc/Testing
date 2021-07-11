/*
	Author : Mohsin Hassan
	Description : To get the price history
*/
public class PriceHistoryController {
    
    @AuraEnabled 
    public static String getObjectAPIName(String recordId){
        
        system.debug('Record Id is:'+recordId);
        
        if(recordId == null)
            return null;
        String objectAPIName = '';
        String keyPrefix = recordId.substring(0,3);
        for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
              String prefix = obj.getDescribe().getKeyPrefix();
               if(prefix == keyPrefix){
                         objectAPIName = obj.getDescribe().getName();
                          break;
                }
         }

         system.debug('objectAPIName: '+objectAPIName);
        
         return objectAPIName;

	}
        
    
    @AuraEnabled 
    public static List<PriceIntegrationRecordsWrapper> getPricingListForBrief(String briefId){
        system.debug('@@ '+briefId);
        
        Brief__c brief = [SELECT Id, Account__c, CPP__c from Brief__C WHERE Id = :briefId];
        
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = : brief.Account__c];
        
        system.debug('Account Id:'+acc.Id);
        
        Opportunity opp = [SELECT Id, Name, Lot_Size_Kgs__c, Univar_Product__c,Univar_Product__r.Name,Univar_Product__r.European_Product_Code__c FROM Opportunity WHERE Id =: brief.CPP__c];
               
        //String json = QPriceIntegration.callQForPrices(acc.AccountNumber, acc.SalesOrg__c, opp.Univar_Product__r.European_Product_Code__c, '', '');
        String json = QPriceIntegration.callQForPrices('10062158', 'GB01', '313327', '', '');
        //json = json.replace('currency_Z', 'x_currency');  
        //String json = '[ { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-12-01T00:00:00", "expiryDate": "2020-12-30T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-11-02T00:00:00", "expiryDate": "2020-11-30T23:59:59", "periodicCalcDate": "2020-11-27T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-10-01T00:00:00", "expiryDate": "2020-11-02T00:54:12.78", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-05-03T00:00:00", "expiryDate": "2021-05-31T23:59:59", "periodicCalcDate": "2021-05-28T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "L" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-04-01T00:00:00", "expiryDate": "2021-05-02T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-03-01T00:00:00", "expiryDate": "2021-03-31T23:59:59", "periodicCalcDate": "2021-03-30T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-02-01T00:00:00", "expiryDate": "2021-02-28T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" } ]';      
        System.debug('hello JSON --> '+json);
        List<PriceIntegrationWrapper> priceIntegrationWrapperList = (List<PriceIntegrationWrapper>)System.JSON.deserialize(json, List<PriceIntegrationWrapper>.class);
        //List<PriceIntegrationWrapper> priceIntegrationWrapperList = PriceIntegrationWrapper.parse(json); // priceIntegrationWrapperList = AccountPricesWrapper(); // new (AccountPricesWrapper) System.JSON.deserialize(json, AccountPricesWrapper.class);
       	System.debug('hello wrapper --> '+ priceIntegrationWrapperList);
        
        List<PriceIntegrationRecordsWrapper>	priceIntegrationRecordsWrapperList = new List<PriceIntegrationRecordsWrapper>();
        
        Map<String, PriceIntegrationRecordsWrapper>	checkDuplicateMap = new Map<String, PriceIntegrationRecordsWrapper>();
        
        for(PriceIntegrationWrapper priceIntegerationRecord :    priceIntegrationWrapperList){
            
            PriceIntegrationWrapper priceIntegrationWrapperRecord = new PriceIntegrationWrapper();
            
            priceIntegrationWrapperRecord.lskuCode = priceIntegerationRecord.lskuCode;
            priceIntegrationWrapperRecord.addressCode = priceIntegerationRecord.addressCode;
            priceIntegrationWrapperRecord.address = priceIntegerationRecord.address;
            priceIntegrationWrapperRecord.isSoldTo = priceIntegerationRecord.isSoldTo;
            priceIntegrationWrapperRecord.customerGroup = priceIntegerationRecord.customerGroup;
            priceIntegrationWrapperRecord.profile = priceIntegerationRecord.profile;
            priceIntegrationWrapperRecord.volume = priceIntegerationRecord.volume;
            priceIntegrationWrapperRecord.customerPrice = priceIntegerationRecord.customerPrice;
            priceIntegrationWrapperRecord.x_currency = priceIntegerationRecord.x_currency;
            priceIntegrationWrapperRecord.exWorks = priceIntegerationRecord.exWorks;
            priceIntegrationWrapperRecord.effectiveDate = priceIntegerationRecord.effectiveDate;
            priceIntegrationWrapperRecord.expiryDate = priceIntegerationRecord.expiryDate;
            priceIntegrationWrapperRecord.periodicCalcDate = priceIntegerationRecord.periodicCalcDate;
            priceIntegrationWrapperRecord.validTo = priceIntegerationRecord.validTo;
            priceIntegrationWrapperRecord.priceStatus = priceIntegerationRecord.priceStatus;
            priceIntegrationWrapperRecord.priceStatus = priceIntegerationRecord.priceStatus;
            
            
            PriceIntegrationRecordsWrapper priceIntegrationRecord;
            if(checkDuplicateMap.containsKey(priceIntegerationRecord.lskuName)){
                priceIntegrationRecord = checkDuplicateMap.get(priceIntegerationRecord.lskuName);
            }else{
                priceIntegrationRecord =  new PriceIntegrationRecordsWrapper();
                
                priceIntegrationRecord.lskuName = priceIntegerationRecord.lskuName ;
                priceIntegrationRecord.packWeight = priceIntegerationRecord.packWeight ;
                priceIntegrationRecord.unitOfMeasure = priceIntegerationRecord.unitOfMeasure ;
                priceIntegrationRecord.isBulk = priceIntegerationRecord.isBulk ;
                priceIntegrationRecord.esq = priceIntegerationRecord.esq;
                priceIntegrationRecord.periodicCalcDate = priceIntegerationRecord.periodicCalcDate;
            }
            priceIntegrationRecord.priceIntegrationTableList.add(priceIntegrationWrapperRecord);
            
            checkDuplicateMap.put(priceIntegerationRecord.lskuName , priceIntegrationRecord);
            
        }
        
        for(String key : checkDuplicateMap.keySet()){
            
            priceIntegrationRecordsWrapperList.add(checkDuplicateMap.get(key));
        }
        
        return priceIntegrationRecordsWrapperList;

        }
    
    /*
		This method will return the Q prices for a customer
		* @param accId to get the required param from account
	*/
    @AuraEnabled 
    public static  List<PriceIntegrationRecordsWrapper> getPricingListForAccount(String accId){
       	system.debug('@@ '+accId);
        List<PriceIntegrationWrapper> priceIntegrationWrapperFilterList = new List<PriceIntegrationWrapper>();
        Set<String> univarProductName = new Set<String>();
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = :accId];        
                     
        String json = QPriceIntegration.callQForPrices(acc.AccountNumber, acc.SalesOrg__c, acc.Customer_Code__c, '', '');
        //String json = QPriceIntegration.callQForPrices('10062158', 'GB01', '313327', '', '');
        //json = json.replace('currency_Z', 'x_currency');  
        //String json = '[ { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-12-01T00:00:00", "expiryDate": "2020-12-30T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-11-02T00:00:00", "expiryDate": "2020-11-30T23:59:59", "periodicCalcDate": "2020-11-27T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-10-01T00:00:00", "expiryDate": "2020-11-02T00:54:12.78", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-05-03T00:00:00", "expiryDate": "2021-05-31T23:59:59", "periodicCalcDate": "2021-05-28T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "L" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-04-01T00:00:00", "expiryDate": "2021-05-02T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-03-01T00:00:00", "expiryDate": "2021-03-31T23:59:59", "periodicCalcDate": "2021-03-30T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-02-01T00:00:00", "expiryDate": "2021-02-28T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" } ]';      
        System.debug('hello JSON --> '+json);
        List<PriceIntegrationWrapper> priceIntegrationWrapperList = (List<PriceIntegrationWrapper>)System.JSON.deserialize(json, List<PriceIntegrationWrapper>.class);
        //List<PriceIntegrationWrapper> priceIntegrationWrapperList = PriceIntegrationWrapper.parse(json); // priceIntegrationWrapperList = AccountPricesWrapper(); // new (AccountPricesWrapper) System.JSON.deserialize(json, AccountPricesWrapper.class);
       	System.debug('hello wrapper --> '+ priceIntegrationWrapperList);
        
        List<PriceIntegrationRecordsWrapper>	priceIntegrationRecordsWrapperList = new List<PriceIntegrationRecordsWrapper>();
        
        Map<String, PriceIntegrationRecordsWrapper>	checkDuplicateMap = new Map<String, PriceIntegrationRecordsWrapper>();
        
        for(PriceIntegrationWrapper priceIntegerationRecord :    priceIntegrationWrapperList){
            
            PriceIntegrationWrapper priceIntegrationWrapperRecord = new PriceIntegrationWrapper();
            
            priceIntegrationWrapperRecord.lskuCode = priceIntegerationRecord.lskuCode;
            priceIntegrationWrapperRecord.addressCode = priceIntegerationRecord.addressCode;
            priceIntegrationWrapperRecord.address = priceIntegerationRecord.address;
            priceIntegrationWrapperRecord.isSoldTo = priceIntegerationRecord.isSoldTo;
            priceIntegrationWrapperRecord.customerGroup = priceIntegerationRecord.customerGroup;
            priceIntegrationWrapperRecord.profile = priceIntegerationRecord.profile;
            priceIntegrationWrapperRecord.volume = priceIntegerationRecord.volume;
            priceIntegrationWrapperRecord.customerPrice = priceIntegerationRecord.customerPrice;
            priceIntegrationWrapperRecord.x_currency = priceIntegerationRecord.x_currency;
            priceIntegrationWrapperRecord.exWorks = priceIntegerationRecord.exWorks;
            priceIntegrationWrapperRecord.effectiveDate = priceIntegerationRecord.effectiveDate;
            priceIntegrationWrapperRecord.expiryDate = priceIntegerationRecord.expiryDate;
            priceIntegrationWrapperRecord.periodicCalcDate = priceIntegerationRecord.periodicCalcDate;
            priceIntegrationWrapperRecord.validTo = priceIntegerationRecord.validTo;
            priceIntegrationWrapperRecord.priceStatus = priceIntegerationRecord.priceStatus;
            priceIntegrationWrapperRecord.priceStatus = priceIntegerationRecord.priceStatus;
            
            
            PriceIntegrationRecordsWrapper priceIntegrationRecord;
            if(checkDuplicateMap.containsKey(priceIntegerationRecord.lskuName)){
                priceIntegrationRecord = checkDuplicateMap.get(priceIntegerationRecord.lskuName);
            }else{
                priceIntegrationRecord =  new PriceIntegrationRecordsWrapper();
                
                priceIntegrationRecord.lskuName = priceIntegerationRecord.lskuName ;
                priceIntegrationRecord.packWeight = priceIntegerationRecord.packWeight ;
                priceIntegrationRecord.unitOfMeasure = priceIntegerationRecord.unitOfMeasure ;
                priceIntegrationRecord.isBulk = priceIntegerationRecord.isBulk ;
                priceIntegrationRecord.esq = priceIntegerationRecord.esq;
                priceIntegrationRecord.periodicCalcDate = priceIntegerationRecord.periodicCalcDate;
            }
            priceIntegrationRecord.priceIntegrationTableList.add(priceIntegrationWrapperRecord);
            
            checkDuplicateMap.put(priceIntegerationRecord.lskuName , priceIntegrationRecord);
            
        }
        
        for(String key : checkDuplicateMap.keySet()){
            
            priceIntegrationRecordsWrapperList.add(checkDuplicateMap.get(key));
        }
        
        return priceIntegrationRecordsWrapperList;
    }
    
    
    
    public class PriceIntegrationRecordsWrapper{
        @AuraEnabled public String lskuName {get;set;} 
        @AuraEnabled public Double packWeight {get;set;} 
        @AuraEnabled public String unitOfMeasure {get;set;} 
        @AuraEnabled public Boolean isBulk {get;set;}
        @AuraEnabled public String currency_Z;	//GBP        
        @AuraEnabled public Double esq {get;set;}
        @AuraEnabled public String periodicCalcDate {get;set;} 
        
        @AuraEnabled public List<PriceIntegrationWrapper> priceIntegrationTableList{get;set;}
        PriceIntegrationRecordsWrapper(){
            priceIntegrationTableList = new List<PriceIntegrationWrapper>();
        }
        
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
        @AuraEnabled public String priceStatus;	
    }
}