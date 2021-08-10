public class TransactionsController {

    
    @AuraEnabled
    public static List<SalesHistoryWrapper> getTransactions(String accId){
        
        Account acc = [SELECT Id, AccountNumber, SalesOrg__c, Customer_Code__c FROM Account WHERE Id = :accId];
        List<Opportunity> CPPs = [SELECT Id, Univar_Product__c, Univar_Product__r.European_Product_Code__c, Local_Product_Code__c, Univar_Product__r.Local_Product_Code__c, Name, Univar_Product__r.Name FROM Opportunity WHERE AccountId =: accId AND RecordType.Name = 'CPP'];
        List<DataWareHouseIntegration.DWSalesHistory> salesHistoryList = new List<DataWareHouseIntegration.DWSalesHistory>();
        String oAuth = DataWareHouseIntegration.getOAuth();

        List<SalesHistoryWrapper> salesHistoryWrapperRecordsList = new List<SalesHistoryWrapper>();

        for(Opportunity CPP : CPPs) {
            if(CPP.Univar_Product__r.European_Product_Code__c != null) {
                System.debug(acc.AccountNumber);
                System.debug(CPP.Univar_Product__r.Local_Product_Code__c);
                System.debug(acc.SalesOrg__c);
                List<DataWareHouseIntegration.DWSalesHistory> checker = DataWareHouseIntegration.callDWForSalesHistoryAPI(acc.AccountNumber , CPP.Univar_Product__r.Local_Product_Code__c, acc.SalesOrg__c, oAuth);

                if(!checker.isEmpty()) {
                    SalesHistoryWrapper salesHistoryWrapperRecord = new SalesHistoryWrapper();

                    for(DataWareHouseIntegration.DWSalesHistory item : checker) {
                        if(salesHistoryWrapperRecord.product == null) {
                            salesHistoryWrapperRecord.product = CPP.Univar_Product__r.Name;
                        }
                        if(salesHistoryWrapperRecord.cpp == null) {
                            salesHistoryWrapperRecord.cpp = CPP.Name;
                        }
                        if(salesHistoryWrapperRecord.material == null) {
                            salesHistoryWrapperRecord.material = 'TODO';
                        }

                        if(item.type.containsIgnoreCase('Open Order')) {
                            salesHistoryWrapperRecord.openOrderVol = item.vol != null ?  item.vol : 0 ;
                            salesHistoryWrapperRecord.openOrderSales = item.sales != null ?  item.sales : 0 ;
                            salesHistoryWrapperRecord.openOrderGP = item.gP != null ?  item.gP : 0 ;
                            salesHistoryWrapperRecord.openOrderGPPerTonne = item.gPPerTonne != null ?  item.gPPerTonne : 0 ;
                            salesHistoryWrapperRecord.openOrderGPPerc = item.gPPerc != null ?  item.gPPerc : 0 ;
                        }

                        if(item.type.containsIgnoreCase('Current Month Sold')) {
                            salesHistoryWrapperRecord.currentMonthVol = item.vol != null ?  item.vol : 0 ;
                            salesHistoryWrapperRecord.currentMonthSales = item.sales != null ?  item.sales : 0 ;
                            salesHistoryWrapperRecord.currentMonthGP = item.gP != null ?  item.gP : 0 ;
                            salesHistoryWrapperRecord.currentMonthGPPerTonne = item.gPPerTonne != null ?  item.gPPerTonne : 0 ;
                            salesHistoryWrapperRecord.currentMonthGPPerc = item.gPPerc != null ?  item.gPPerc : 0 ;
                        }
                        if(item.type.containsIgnoreCase('Last 12 Months Sold')) {
                            salesHistoryWrapperRecord.last12MonthVol = item.vol != null ?  item.vol : 0 ;
                            salesHistoryWrapperRecord.last12MonthSales = item.sales != null ?  item.sales : 0 ;
                            salesHistoryWrapperRecord.last12MonthGP = item.gP != null ?  item.gP : 0 ;
                            salesHistoryWrapperRecord.last12MonthGPPerTonne = item.gPPerTonne != null ?  item.gPPerTonne : 0 ;
                            salesHistoryWrapperRecord.last12MonthGPPerc = item.gPPerc != null ?  item.gPPerc : 0 ;
                        }
                        if(item.type.containsIgnoreCase('Last 13 to 24m Sold')) {
                            salesHistoryWrapperRecord.x12To24MonthVol = item.vol != null ?  item.vol : 0 ;
                            salesHistoryWrapperRecord.x12To24MonthSales =  item.sales != null ?  item.sales : 0 ;
                            salesHistoryWrapperRecord.x12To24MonthGP =  item.gP != null ?  item.gP : 0 ;
                            salesHistoryWrapperRecord.x12To24MonthGPPerTonne =  item.gPPerTonne != null ?  item.gPPerTonne : 0 ;
                            salesHistoryWrapperRecord.x12To24MonthGPPerc =  item.gPPerc != null ?  item.gPPerc : 0 ;
                        }
                    }
                    salesHistoryWrapperRecordsList.add(salesHistoryWrapperRecord);
                }
            }
        }

        System.debug('hello salesHistoryWrapperRecordsList --> '+ salesHistoryWrapperRecordsList);
        if(salesHistoryWrapperRecordsList.isEmpty()) {
            throw new transactionException('No data returned');
        }
        return salesHistoryWrapperRecordsList;
    }
    
    
    
    public class SalesHistoryWrapper {
      @AuraEnabled  public String type;
      @AuraEnabled  public Decimal openOrderVol = 0;
      @AuraEnabled  public Decimal currentMonthVol = 0;
      @AuraEnabled  public Decimal last12MonthVol = 0;
      @AuraEnabled  public Decimal x12To24MonthVol = 0;
      @AuraEnabled  public Decimal openOrderSales = 0;
      @AuraEnabled  public Decimal currentMonthSales = 0;
      @AuraEnabled  public Decimal last12MonthSales = 0;
      @AuraEnabled  public Decimal x12To24MonthSales = 0;
      @AuraEnabled  public Decimal openOrderGP = 0;
      @AuraEnabled  public Decimal currentMonthGP = 0;
      @AuraEnabled  public Decimal last12MonthGP = 0;
      @AuraEnabled  public Decimal x12To24MonthGP = 0;
      @AuraEnabled  public Decimal openOrderGPPerTonne = 0;
      @AuraEnabled  public Decimal currentMonthGPPerTonne = 0;
      @AuraEnabled  public Decimal last12MonthGPPerTonne = 0;
      @AuraEnabled  public Decimal x12To24MonthGPPerTonne = 0;
      @AuraEnabled  public Decimal openOrderGPPerc = 0;
      @AuraEnabled  public Decimal currentMonthGPPerc = 0;
      @AuraEnabled  public Decimal last12MonthGPPerc = 0;
      @AuraEnabled  public Decimal x12To24MonthGPPerc = 0;
      @AuraEnabled  public String product;
      @AuraEnabled  public String material;
      @AuraEnabled  public String cpp;
      @AuraEnabled  public String colorCode;  
    }

    public class transactionException extends Exception{}
}