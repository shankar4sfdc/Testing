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
