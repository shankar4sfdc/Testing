@isTest 
public class AccountComplaintsHandlerTest {

    // Declare commonly used variables for test data setup
    private static Account testAcc = new Account();

    // Set up commonly required test data for all testmethods
    static testMethod void getComplaintsTest() {

        Account acc1 = new Account();

        Id origUserId = UserInfo.getUserId();
        User user = RecordFactoryUtiliyTest.getEnglishUser('Test', '1stUser');
        User updateUser = RecordFactoryUtiliyTest.getEnglishUser('Test', '2ndUser');
        insert user;
        insert updateUser;
        
        system.runAs(user) {

            acc1 = RecordFactoryUtiliyTest.createSampleAccount();
            
            acc1.SalesOrg__c='GB01';
            
            update acc1;

            List<Account> accountList = new List<Account>();
            accountList.add(acc1);

            Integer i = 1;
            for(Account acct : accountList) {
                acct.Name += ' ' + i;
                acct.OwnerId = updateUser.Id;
                i++;	
            }
            
        Brief__c newBrief = new Brief__c();
        newBrief.OwnerId = updateUser.Id;
        newBrief.Account__c = acc1.Id;

        system.debug('Account Id:'+acc1.Id);
        insert newBrief;

        Test.startTest();
            
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new DWIntegrationHTTPMockCallOut());            
            
        List<AccountComplaintsHandler.ComplaintIntegrationWrapper> complaintIntegrationWrapper = AccountComplaintsHandler.getComplaints(newBrief.Id);
            
        system.assertEquals(2, complaintIntegrationWrapper.size());
            
        Test.stopTest();        
        }
            
    }        
   
}