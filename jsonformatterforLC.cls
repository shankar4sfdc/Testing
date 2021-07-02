public class jsonformatterforLC {
    
    @AuraEnabled 
    public static List<jsonWrapperMonthwise> getOTIFS(){
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
                        '"cpp":"CPP","month":"2020-03-01T00:00:00","value":3.0},' +
                        '{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-04-01T00:00:00",' + 
                        '"value":4.0},{"material":"SALT PDV IND 1K BLK",' + 
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-05-01T00:00:00",' +
                        '"value":5.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' + 
                        '"cpp":"CPP","month":"2020-06-01T00:00:00",' + 
                        '"value":6.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-07-01T00:00:00",' +
                        '"value":7.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-08-01T00:00:00",' +
                        '"value":8.0},{"material":"SALT PDV IND 1K BLK",' + 
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-09-01T00:00:00",' +
                        '"value":9.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-10-01T00:00:00",' +
                        '"value":10.0},{"material":"SALT PDV IND 1K BLK",' + 
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-11-01T00:00:00",' + 
                        '"value":11.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-12-01T00:00:00",' +
                        '"value":12.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-01-01T00:00:00",' +
                        '"value":1.0},{"material":"SALT PDV IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-02-01T00:00:00","value":2.0},'+
            			'{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-03-01T00:00:00","value":3.0},' +
                        '{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-04-01T00:00:00",' + 
                        '"value":4.0},{"material":"SALT IND 1K BLK",' + 
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-05-01T00:00:00",' +
                        '"value":5.0},{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' + 
                        '"cpp":"CPP","month":"2020-06-01T00:00:00",' + 
                        '"value":6.0},{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-07-01T00:00:00",' +
                        '"value":7.0},{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-08-01T00:00:00",' +
                        '"value":8.0},{"material":"SALT IND 1K BLK",' + 
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-09-01T00:00:00",' +
                        '"value":9.0},{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-10-01T00:00:00",' +
                        '"value":10.0},{"material":"SALT IND 1K BLK",' + 
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-11-01T00:00:00",' + 
                        '"value":11.0},{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2020-12-01T00:00:00",' +
                        '"value":12.0},{"material":"SALT IND 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-01-01T00:00:00",' +
                        '"value":1.0},{"material":"SALT PDV 1K BLK",' +
                        '"univarProduct":"SALT PDV IND 1KG BULK - SAP",' +
                        '"cpp":"CPP","month":"2021-02-01T00:00:00","value":2.0}]';
        
        //system.debug('JSON returned is:'+Json);
        List<jsonWrapper> oTIFIntegrationWrapperList = (List<jsonWrapper>)System.JSON.deserialize(json, List<jsonWrapper>.class);
        
        //system.debug('oTIFIntegrationWrapperList returned is:'+oTIFIntegrationWrapperList);
        map<String,List<jsonWrapper>> materialwiseData = new map<String,List<jsonWrapper>>();
        for(jsonWrapper jw : oTIFIntegrationWrapperList)
        {
            System.debug('--Month-->'+jw.month+'<--next-->'+jw.month.month()+'<--year-->'+jw.month.year());
            //converting list to map based on material 
            if(materialwiseData.containsKey(jw.material))
            {
                List<jsonWrapper> monthValues = materialwiseData.get(jw.material);
				monthValues.add(jw);
				materialwiseData.put(jw.material, monthValues);
            }
            else
            {
                materialwiseData.put(jw.material, new List<jsonWrapper> { jw });
            }
            //preparing headerValues list
            
        }
        List<jsonWrapperMonthwise> materialwiseList = new List<jsonWrapperMonthwise>();
        List<String> monthNames = new List<String>{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
        List<String> headerValues = new List<String>();
        
        for(string str : materialwiseData.keyset())
        {
            jsonWrapperMonthwise jwm = new jsonWrapperMonthwise();
            jwm.material = str;
            headerValues.add('Material Name');
            for(jsonWrapper jw : materialwiseData.get(str))
            {
            	jwm.fiscalyear = jwm.fiscalyear!=null ? (jwm.fiscalyear<jw.month.year()?jwm.fiscalyear:jw.month.year() ) : jw.month.year();
                //system.debug('month--->'+jw.month);
                //system.debug('month--->'+jw.month.format());
                switch on jw.month.month() {
                    when 1{
                        jwm.month1 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 2{
                        jwm.month2 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 3{
                        jwm.month3 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 4{
                        jwm.month4 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 5{
                        jwm.month5 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 6{
                        jwm.month6 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 7{
                        jwm.month7 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 8{
                        jwm.month8 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 9{
                        jwm.month9 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 10{
                        jwm.month10 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 11{
                        jwm.month11 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                    when 12{
                        jwm.month12 = jw.value;
                        headerValues.add(monthNames[jw.month.month()-1]+' - '+String.valueOf(jw.month.year()).substring(2, 3));
                    }
                }
            }
            system.debug('headerValues is:'+headerValues);
            materialwiseList.add(jwm);
        }
        //system.debug('materialwiseList is:'+materialwiseList);
        return materialwiseList;
    }
    
    
    public Class jsonWrapper {
        @AuraEnabled public String material;
        @AuraEnabled public String univarProduct;
        @AuraEnabled public String cPP;
        @AuraEnabled public DateTime month;
        @AuraEnabled public Decimal value;
    }
    
    public Class jsonWrapperMonthwise {
        @AuraEnabled public String material {get;set;}
        @AuraEnabled public Decimal month1 {get;set;}
        @AuraEnabled public Decimal month2 {get;set;}
        @AuraEnabled public Decimal month3 {get;set;}
        @AuraEnabled public Decimal month4 {get;set;}
        @AuraEnabled public Decimal month5 {get;set;}
        @AuraEnabled public Decimal month6 {get;set;}
        @AuraEnabled public Decimal month7 {get;set;}
        @AuraEnabled public Decimal month8 {get;set;}
        @AuraEnabled public Decimal month9 {get;set;}
        @AuraEnabled public Decimal month10 {get;set;}
        @AuraEnabled public Decimal month11 {get;set;}
        @AuraEnabled public Decimal month12 {get;set;}
        @AuraEnabled public Integer fiscalyear {get;set;}
    }

}