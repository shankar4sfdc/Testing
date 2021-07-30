/*
* Created by 10200312 on 06/07/2021.
* Created this class to get the current price history
*/
public class AccountCurrentPricesHandler {
    
    /*
*This method will return the current Q prices for a customer
* @param brief ID to get the required current Q prices from account from brief
*/    
    @AuraEnabled
    public static List<PriceIntegrationRecordsWrapper> getCurrentPricingList(String briefId){
        
        system.debug('@@ '+briefId);
        Account acc;
        Opportunity opp;
        
        try{  
            Brief__c brief = [SELECT Id, Account__c, CPP__c from Brief__C WHERE Id = :briefId];
            
            acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = : brief.Account__c];
            
            opp = [SELECT Id, Name, Lot_Size_Kgs__c, Pkg__c, Univar_Product__c,Univar_Product__r.Name,Univar_Product__r.European_Product_Code__c FROM Opportunity WHERE Id =: brief.cpp__c];
            
            system.debug('Account Id:'+acc.Id);
        }
        
        catch (QueryException e) {
            throw new currentPricesException('No Data Found for the Brief');  
        }        
        
        List<PriceIntegrationRecordsWrapper> priceIntegrationRecordsWrapperList = new List<PriceIntegrationRecordsWrapper>();
        Set<String> univarProductName = new Set<String>();
        
        String json = QPriceIntegration.callQForLivePrices(acc.Customer_Code__c, acc.SalesOrg__c,opp.Univar_Product__r.European_Product_Code__c, 'A', opp.Lot_Size_Kgs__c);
        
        //String json = '{ "Containers":[{ "code": "2025476", "description": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "depositPrice": "120.00", "refundPrice": "150.00", "cleaningAmount": "180.00", "rentalAmount": "200.00"}, { "code": "2025476", "description": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "depositPrice": "120.00", "refundPrice": "150.00", "cleaningAmount": "180.00", "rentalAmount": "200.00"}, { "code": "2025476", "description": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "depositPrice": "120.00", "refundPrice": "150.00", "cleaningAmount": "180.00", "rentalAmount": "200.00"}], "Prices": [ { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN ", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-12-01T00:00:00", "expiryDate": "2020-12-30T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-11-02T00:00:00", "expiryDate": "2020-11-30T23:59:59", "periodicCalcDate": "2020-11-27T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": false, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2020-10-01T00:00:00", "expiryDate": "2020-11-02T00:54:12.78", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-05-03T00:00:00", "expiryDate": "2021-05-31T23:59:59", "periodicCalcDate": "2021-05-28T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "L" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-04-01T00:00:00", "expiryDate": "2021-05-02T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-03-01T00:00:00", "expiryDate": "2021-03-31T23:59:59", "periodicCalcDate": "2021-03-30T00:00:00", "validTo": null, "cancelled": false, "priceStatus": "H" }, { "lskuCode": "2025476", "lskuName": "CAFLON APG C6 220K DNN", "esq": 220, "isBulk": false, "packWeight": 220, "addressCode": "10062158", "address": "Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom", "isSoldTo": true, "customerGroup": "", "profile": "Periodic", "volume": 0.88, "unitOfMeasure": "to", "customerPrice": 3725, "currency": "GBP", "exWorks": false, "effectiveDate": "2021-02-01T00:00:00", "expiryDate": "2021-02-28T23:59:59", "periodicCalcDate": null, "validTo": null, "cancelled": false, "priceStatus": "H" } ]}';
        //String json = QPriceIntegration.callQForLivePrices('12298913', 'F001', '311407', 'A', '10.25');
        
        if(String.isNotBlank(json)){  
            json = json.replace('currency', 'x_currency');  
            System.debug('hello JSON --> '+json);
            
            CurrentProductPriceIntWrapper currentProductPrices = (CurrentProductPriceIntWrapper)System.JSON.deserialize(json, CurrentProductPriceIntWrapper.class);
            
            System.debug('currentProductPrices wrapper --> '+ currentProductPrices);
            
            List<PriceIntegrationWrapper> priceIntegrationWrapperList = currentProductPrices.calculatedPrices;
            System.debug('priceIntegrationWrapperList is --> '+ priceIntegrationWrapperList);       
            
            Map<String, PriceIntegrationRecordsWrapper> checkDuplicateMap = new Map<String, PriceIntegrationRecordsWrapper>();
            
            for(PriceIntegrationWrapper priceIntegerationRecord :priceIntegrationWrapperList){
                
                PriceIntegrationWrapper priceIntegrationWrapperRecord = new PriceIntegrationWrapper();
                priceIntegrationWrapperRecord.lskuCode = priceIntegerationRecord.lskuCode;
                priceIntegrationWrapperRecord.addressCode = priceIntegerationRecord.addressCode;
                priceIntegrationWrapperRecord.address = priceIntegerationRecord.address;
                priceIntegrationWrapperRecord.isSoldTo = priceIntegerationRecord.isSoldTo;
                priceIntegrationWrapperRecord.volume = priceIntegerationRecord.volume;
                priceIntegrationWrapperRecord.x_currency = priceIntegerationRecord.x_currency;
                priceIntegrationWrapperRecord.exWorks = priceIntegerationRecord.exWorks;
                priceIntegrationWrapperRecord.regionalUpliftPrice = priceIntegerationRecord.regionalUpliftPrice;
                priceIntegrationWrapperRecord.minimumPrice = priceIntegerationRecord.minimumPrice;
                priceIntegrationWrapperRecord.targetPrice = priceIntegerationRecord.targetPrice;
                priceIntegrationWrapperRecord.opportunityPrice = priceIntegerationRecord.opportunityPrice;
                
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
                }
                
                system.debug('Price Integration Record Added is:'+priceIntegrationWrapperRecord);
                priceIntegrationRecord.priceIntegrationTableList.add(priceIntegrationWrapperRecord);
                checkDuplicateMap.put(priceIntegerationRecord.lskuName , priceIntegrationRecord);
            }
            
            for(String key : checkDuplicateMap.keySet()){
                priceIntegrationRecordsWrapperList.add(checkDuplicateMap.get(key));
            }
        }
        
        return priceIntegrationRecordsWrapperList;
    }
    
    public Class ContainerWrapper {
        @AuraEnabled public String code; //2025476
        @AuraEnabled public String description; //CAFLON APG C6 220K DNN
        @AuraEnabled public String x_currency; //GBP
        @AuraEnabled public Decimal depositPrice;
        @AuraEnabled public Decimal refundPrice;
        @AuraEnabled public Decimal cleaningAmount;
        @AuraEnabled public Decimal rentalAmount;
    }
    
    public Class PriceIntegrationWrapper {
        @AuraEnabled public String lskuCode; //2025476
        @AuraEnabled public String lskuName; //CAFLON APG C6 220K DNN
        @AuraEnabled public Decimal esq; //220
        @AuraEnabled public boolean isBulk;
        @AuraEnabled public Decimal packWeight; //220
        @AuraEnabled public String addressCode; //10062158
        @AuraEnabled public String address; //Rawdon Road, Moira, Swadlincote - Derbyshire, DE12 6DA, United Kingdom
        @AuraEnabled public boolean isSoldTo;
        @AuraEnabled public boolean exWorks;
        @AuraEnabled public Double volume; //0.88
        @AuraEnabled public String unitOfMeasure; //to
        @AuraEnabled public Integer noOfPacks; //3725
        @AuraEnabled public boolean isPriceOnApplication;
        @AuraEnabled public Integer priceOnApplicationReason; //3725
        @AuraEnabled public Decimal regionalUpliftPrice;
        @AuraEnabled public Decimal minimumPrice;
        @AuraEnabled public Decimal targetPrice;
        @AuraEnabled public Decimal opportunityPrice;
        @AuraEnabled public String x_currency; //GBP
        @AuraEnabled public String regionalCode;
        @AuraEnabled public String containerCode;
    }    
    
    public class PriceIntegrationRecordsWrapper{
        @AuraEnabled public String lskuName {get;set;}
        @AuraEnabled public Double packWeight {get;set;}
        @AuraEnabled public String unitOfMeasure {get;set;}
        @AuraEnabled public Boolean isBulk {get;set;}
        @AuraEnabled public String x_currency; //GBP        
        @AuraEnabled public Double esq {get;set;}
        @AuraEnabled public String periodicCalcDate {get;set;}
        
        @AuraEnabled public List<PriceIntegrationWrapper> priceIntegrationTableList{get;set;}
        PriceIntegrationRecordsWrapper(){
            priceIntegrationTableList = new List<PriceIntegrationWrapper>();
        }
        
    }
    
    public class CurrentProductPriceIntWrapper {
        @AuraEnabled public List<ContainerWrapper> containers{get;set;}
        @AuraEnabled public List<PriceIntegrationWrapper> calculatedPrices{get;set;}
    }
    
    public class currentPricesException extends Exception{
        
    }       
}