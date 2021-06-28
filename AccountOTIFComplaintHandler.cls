public class AccountOTIFSHandler {
    
    @AuraEnabled public List<String> months;

    
    @AuraEnabled 
    public static List<oTIFIntegrationWrapper> getOTIFS(){
       //system.debug('@@ '+briefId);

        /*Set<String> univarProductName = new Set<String>();
        
        Brief__c brief = [SELECT Id, Account__r.Id from Brief__C WHERE Id = :briefId];
        
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = : brief.Account__r.Id];
        
        system.debug('Account Id:'+acc.Id);
        
        for(Opportunity opp : [SELECT Univar_Product__c,Univar_Product__r.Name, AccountId, Id FROM Opportunity WHERE AccountId =: brief.Account__r.Id]){
            if(opp.Univar_Product__c != null && String.isNotBlank(opp.Univar_Product__r.Name)){
                univarProductName.add(opp.Univar_Product__r.Name);
            }
        } 
        
        String json = DataWareHouseIntegration.callDWForOTIFsAPI('10062158','GB01');*/      

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
        
        return oTIFIntegrationWrapperList;
      
    }
    
    
    public Class oTIFIntegrationWrapper {
        @AuraEnabled public String material;
        @AuraEnabled public String univarProduct;
        @AuraEnabled public String cPP;
        @AuraEnabled public DateTime month;
        @AuraEnabled public Decimal value;
    }     

}