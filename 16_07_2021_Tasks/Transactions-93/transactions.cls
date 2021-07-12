public class transactions {
    
    private final Account acct;
    public Product_History__c lastupdate {
    set;
    
    get
    {
    if (lastupdate == null)
    {
     try {
          lastupdate =  [
          SELECT Period__c,Period01__c,Period02__c,Period03__c,Period04__c,Period05__c,Period06__c,Period07__c,Period08__c,Period09__c,Period10__c,Period11__c
          FROM Product_History__c
          WHERE SAP_Account__c = :acct.AccountNumber and SalesOrg__c = :acct.SalesOrg__c 
          ORDER by Last_Update__c  LIMIT 1
          ]; 
        } catch (QueryException e) {
         ApexPages.addMessages(e);   
         return null;
        }
     }
      return lastupdate;
    }
    } 
    

    
    public transactions(ApexPages.StandardController stdController) {
    this.acct = (Account)stdController.getRecord();

    }

      public String getperiod(){
      if (lastupdate != null){
          return lastupdate.Period__c ;
      } 
      else
      {
          return '';
      }
            
      }
      
      public String getuom(){
      if (lastupdate != null){
          return 'UOM' ;
      } 
      else
      {
          return '';
      }
            
      }
      
      
      public String getperiod01(){
       if (lastupdate != null){
        return lastupdate.Period01__c ;
         } 
      else
      {
          return '';
      }
      }
    
      public String getperiod02(){
         if (lastupdate != null){
        return lastupdate.Period02__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod03(){
         if (lastupdate != null){
        return lastupdate.Period03__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod04(){
         if (lastupdate != null){
        return lastupdate.Period04__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod05(){
         if (lastupdate != null){
        return lastupdate.Period05__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod06(){
         if (lastupdate != null){
        return lastupdate.Period06__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod07(){
         if (lastupdate != null){
        return lastupdate.Period07__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod08(){
         if (lastupdate != null){
        return lastupdate.Period08__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod09(){
         if (lastupdate != null){
        return lastupdate.Period09__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod10(){
         if (lastupdate != null){
        return lastupdate.Period10__c;
          } 
      else
      {
          return '';
      }
      }
    
      public String getperiod11(){
         if (lastupdate != null){
        return lastupdate.Period11__c;
          } 
      else
      {
          return '';
      }
      }
    


    public Product_History__c[] getTransactions() {
        try {
  
            Product_History__c[] transactions =  [
            SELECT Name,Product_Code__c,Nett_Weight__c,Unit_Of_Measure__c,Last_Update__c,Product_BU__c,Period__c,Period01__c,Period02__c,Period03__c,Period04__c,Period05__c,Period06__c,Period07__c,Period08__c,Period09__c,Period10__c,Period11__c,Quantity__c,Quantity01__c,Quantity02__c,Quantity03__c,Quantity04__c,Quantity05__c,Quantity06__c,Quantity07__c,Quantity08__c,Quantity09__c,Quantity10__c,Quantity11__c
            FROM Product_History__c
            WHERE SAP_Account__c = :acct.AccountNumber and SalesOrg__c = :acct.SalesOrg__c
            ORDER by Name asc
            ];
        
            return transactions;
        } catch (QueryException e) {
            ApexPages.addMessages(e);   
            return null;
        }
    }
    
}