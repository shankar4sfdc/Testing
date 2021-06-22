@isTest 
public class DataWareHouseIntegrationTest {
 
    static testMethod void callDWForComplaintsAPIPassCheck() {

        Account acc1 = new Account();

        Id origUserId = UserInfo.getUserId();
        User user = RecordFactoryUtiliyTest.getEnglishUser('Test', '1stUser');
        User updateUser = RecordFactoryUtiliyTest.getEnglishUser('Test', '2ndUser');
        insert user;
        insert updateUser;
        
        system.runAs(user) {

            acc1 = RecordFactoryUtiliyTest.createSampleAccount();

            List<Account> accountList = new List<Account>();
            accountList.add(acc1);

            Integer i = 1;
            for(Account acct : accountList) {
                acct.Name += ' ' + i;
                acct.OwnerId = updateUser.Id;
                i++;	
            }

            Test.startTest();
            
            // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new DWIntegrationHTTPMockCallOut());            
            
            List<DataWareHouseIntegration.DWCustomerCompliants> dWCustomerCompliants = DataWareHouseIntegration.callDWForComplaintsAPI(acc1.Id,'GB01');
        
            system.assertEquals(1, dWCustomerCompliants.size());
            
            Test.stopTest();
            
        }

    }

    static testMethod void callDWForOTIFsAPIPassCheck() {

        Account acc1 = new Account();

        Id origUserId = UserInfo.getUserId();
        User user = RecordFactoryUtiliyTest.getEnglishUser('Test', '1stUser');
        User updateUser = RecordFactoryUtiliyTest.getEnglishUser('Test', '2ndUser');
        insert user;
        insert updateUser;
        
        system.runAs(user) {

            acc1 = RecordFactoryUtiliyTest.createSampleAccount();

            List<Account> accountList = new List<Account>();
            accountList.add(acc1);

            Integer i = 1;
            for(Account acct : accountList) {
                acct.Name += ' ' + i;
                acct.OwnerId = updateUser.Id;
                i++;	
            }

            Test.startTest();
            
            // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new DWIntegrationHTTPMockCallOut());            
            
            List<DataWareHouseIntegration.DWCustomerOTIFs> dWCustomerOTIFs = DataWareHouseIntegration.callDWForOTIFsAPI(acc1.Id,'GB01');
            
            system.assertEquals(1, dWCustomerOTIFs.size());
            
            Test.stopTest();
            
        }        
        
    }
    
        static testMethod void callDWForrWADAPIPassCheck() {

        Account acc1 = new Account();

        Id origUserId = UserInfo.getUserId();
        User user = RecordFactoryUtiliyTest.getEnglishUser('Test', '1stUser');
        User updateUser = RecordFactoryUtiliyTest.getEnglishUser('Test', '2ndUser');
        insert user;
        insert updateUser;
        
        system.runAs(user) {

            acc1 = RecordFactoryUtiliyTest.createSampleAccount();

            List<Account> accountList = new List<Account>();
            accountList.add(acc1);

            Integer i = 1;
            for(Account acct : accountList) {
                acct.Name += ' ' + i;
                acct.OwnerId = updateUser.Id;
                i++;	
            }

            Test.startTest();
            
            // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new DWIntegrationHTTPMockCallOut());            
            
            List<DataWareHouseIntegration.DWWaitedAverageDays> dWWaitedAverageDays = DataWareHouseIntegration.callDWForWaitedAverageDaysAPI(acc1.Id,'1','GB01');
            
            system.assertEquals(1, dWWaitedAverageDays.size());
            
            Test.stopTest();
            
        }        
        
    }
    
        static testMethod void callDWForSalesHistoryAPIPassCheck() {

        Account acc1 = new Account();

        Id origUserId = UserInfo.getUserId();
        User user = RecordFactoryUtiliyTest.getEnglishUser('Test', '1stUser');
        User updateUser = RecordFactoryUtiliyTest.getEnglishUser('Test', '2ndUser');
        insert user;
        insert updateUser;
        
        system.runAs(user) {

            acc1 = RecordFactoryUtiliyTest.createSampleAccount();

            List<Account> accountList = new List<Account>();
            accountList.add(acc1);

            Integer i = 1;
            for(Account acct : accountList) {
                acct.Name += ' ' + i;
                acct.OwnerId = updateUser.Id;
                i++;	
            }

            Test.startTest();
            
            // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new DWIntegrationHTTPMockCallOut());            
            
            List<DataWareHouseIntegration.DWSalesHistory> dWSalesHistory = DataWareHouseIntegration.callDWForSalesHistoryAPI(acc1.Id,'1','GB01');
            
            system.assertEquals(1, dWSalesHistory.size());
            
            Test.stopTest();
            
        }        
        
    }
    
}