/**
 * This class is the Account Complaints handler for calls from Lightning Components.
 *
 * @author      Created by 10200312 on 15/06/2021
 * @version     1.0
 */
public with sharing class AccountComplaintsHandler {
    @AuraEnabled 
    public static List<ComplaintIntegrationWrapper> getComplaints(String briefId){
       system.debug('@@ '+briefId);
        List<ComplaintIntegrationWrapper> complaintIntegrationWrapperFilterList = new List<ComplaintIntegrationWrapper>();
        Set<String> univarProductName = new Set<String>();
        
        Brief__c brief = [SELECT Id, Account__r.Id from Brief__C WHERE Id = :briefId];
        
        Account acc = [SELECT Id,AccountNumber,SalesOrg__c,Customer_Code__c from Account WHERE Id = : brief.Account__r.Id];
        
        system.debug('Account Id:'+acc.Id);
        
        for(Opportunity opp : [SELECT Univar_Product__c,Univar_Product__r.Name, AccountId, Id FROM Opportunity WHERE AccountId =: brief.Account__r.Id]){
            if(opp.Univar_Product__c != null && String.isNotBlank(opp.Univar_Product__r.Name)){
                univarProductName.add(opp.Univar_Product__r.Name);
            }
        }
        
        
        String json = DataWareHouseIntegration.callDWForComplaintsAPI(acc.AccountNumber, acc.SalesOrg__c);

        /*String json = '[{"ComplaintID": "cmp01",' +
        '"ClosedDate": "2021-05-28T01:05:43.611Z",' +
        '"ComplaintStart": "2021-05-28T01:05:43.611Z",' +
        '"CustomerID": "123456","CustomerName": "test",' +
        '"MaterialID": "12345677","MaterialName": "Caustic Soda 35% IBC",' +
        '"PlantID": "testp","Responsible": "n",' +
        '"SalesOfficeID": "1234","ShortText": "Notre service logistique m’alerte sur un problème que nous rencontrons depuis peu avec les bidons d’enzymes.Visiblementil y aurait un changement de contenant.Vous trouverez ci-joint",' +
        '"Status": "Open","QMSDText": "Documentation",' +
        '"UsePlantName": "testt","UseMatVertical":' +
        '"testt","UseSalesOffice": "testt",' +
        '"UseRespGID": "testt","KeyAccount": "testt"},' +
        '{"ComplaintID": "cmp02",' +
        '"ClosedDate": "2021-05-28T01:05:43.611Z",' +
        '"ComplaintStart": "2021-05-28T01:05:43.611Z",' +
        '"CustomerID": "123456","CustomerName": "test",' +
        '"MaterialID": "12345677","MaterialName": "TALC OXO DECONT/SAC ORG/25 K",' +
        '"PlantID": "testp","Responsible": "n",' +
        '"SalesOfficeID": "1234","ShortText": "Notre service logistique m’alerte sur un problème que nous rencontrons depuis peu avec les bidons d’enzymes.Visiblementil y aurait un changement de contenant.Vous trouverez ci-joint",' +
        '"Status": "Closed","QMSDText": "Defective Pack/Label",' +
        '"UsePlantName": "testt","UseMatVertical":' +
        '"testt","UseSalesOffice": "testt",' +
        '"UseRespGID": "testt","KeyAccount": "testt"}' +
        ']';*/

        List<ComplaintIntegrationWrapper> complaintIntegrationWrapperList = (List<ComplaintIntegrationWrapper>)System.JSON.deserialize(json, List<ComplaintIntegrationWrapper>.class);
        if(complaintIntegrationWrapperList.size() > 0){
            for(ComplaintIntegrationWrapper ciw : complaintIntegrationWrapperList){
                    complaintIntegrationWrapperFilterList.add(ciw);
            }
        }
        return complaintIntegrationWrapperFilterList;
    }
    
    
    public Class ComplaintIntegrationWrapper {
        @AuraEnabled public String complaintID;
        @AuraEnabled public DateTime closedDate;
        @AuraEnabled public DateTime complaintStart;
        @AuraEnabled public String customerID;
        @AuraEnabled public String customerName;
        @AuraEnabled public String materialID;
        @AuraEnabled public String materialName;
        @AuraEnabled public String plantID;
        @AuraEnabled public String responsible;
        @AuraEnabled public String salesOfficeID;
        @AuraEnabled public String shortText;
        @AuraEnabled public String status;
        @AuraEnabled public String qMSDText;
        @AuraEnabled public String usePlantName;
        @AuraEnabled public String useMatVertical;
        @AuraEnabled public String useSalesOffice;
        @AuraEnabled public String useRespGID;
        @AuraEnabled public String keyAccount;
    }
}