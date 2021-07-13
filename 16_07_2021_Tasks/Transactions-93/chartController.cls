public class chartController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getobjData(){
        return [SELECT Amount,Name,StageName,Account.Name,Amount_1__c,amount_10__c,amount_11__c,amount_2__c,amount_3__c,amount_4__c,amount_5__c,amount_6__c,amount_7__c,amount_8__c,amount_9__c FROM Opportunity];// WHERE CloseDate >= LAST_N_DAYS:30 AND StageName = 'Closed Won'];
    }
}