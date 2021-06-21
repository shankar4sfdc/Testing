/*=====================================================================================
Visualforce Page:CppOpportunitySelection
Apex Class:CppOpportunitySelectionController
Created By:Saritha Karuturi
Last Modified By:Saritha Karuturi
Scope:This class is related to vf page name called "CppOpportunitySelection" which holds the logic 
1.To Display the New CPP creation page that will render based on the status selection on the page.By using this page user will create the Cpp and related oportunity based on status value.
============================================================*/

public with sharing class CppOpportunitySelectionController {
    public Opportunity oppstring{get; set;} 
    public id OwnerId{get;set;}
    public Date setCloseDate{get;set;}
    public Decimal getprobabilityfinal {get;set;}
    public Date setquickwinChaseDate{get;set;}
    public Date setquickwinCloseDate{get;set;}
    public String selectedcurrency{get;set;}
    public String pageMode{get;set;}
    public String previousstage{get;set;}
    public String prevStgParam{get; set;}
    public String freq{get;set;}
    public Boolean checkoppSecShow{get;set;}
    
    public Opportunity opp{get;set;}
    public String returnString { get; set; }
    public String returnString1 { get; set; }
    public String isspotedit{ get; set; }
    public String isNewSpot{ get; set; }
    public String isSwitchToSpot{ get; set; }
    String getOppStage;
    public string currentlang{get;set;}
    public string currentCurrency{get;set;}
    public String UndefinedSupplierId = CommonUtility.SupplierIdMap.get(CommonUtility.undefinedSupplier);
    public String UndefinedProducerId = CommonUtility.UndefinedProducerId;
    public Integer childCount {get {List<AggregateResult> results = [SELECT count(Id) FROM Opportunity WHERE Parent_Opportunity__c = : oppstring.Id AND IsClosed = false]; return Integer.valueOf(results[0].get('expr0'));} set;}
    public String previousSupplier;
    public String previousProducer; 
     
    //TranslateOpportunityAndCPPChangeHistory translation;
    public CppOpportunitySelectionController(ApexPages.StandardController controller) {
        currentlang = Userinfo.getLanguage();
        currentCurrency = Userinfo.getDefaultCurrency();
        if(currentlang == 'en_US'){
          currentlang = UserInfo.getLocale();
        }
        this.oppstring=(Opportunity) controller.getRecord();
        checkoppSecShow=false;
   
        if(oppstring.id!=null){
            opp = [select id ,name,AccountId,Campaign__c,Current_Producer__c,Probability,Opportunity_Probability__c,
                    CloseDate,Competitor__c,Contract_Expiry_Action_Date__c,Price_UOM__c, Opportunity_Currency__c,
                    Current_Price_per_UOM__c,Univar_Product__c,Opportunity_Closedate__c,Chase_Date__c,
                    Lot_Size_Kgs__c,Annual_Volume_in_Kgs__c ,Application__c,Pkg__c,Is_Univar_Approved_For_This_Product__c,Opportunity_Stage__c,Comments__c,GP__c,
                    Delivery_Terms__c,Product_Description__c,Volume_Unknown__c,
                    Competitor_Trade_Name__c,OwnerId,CPP_Status_Stage_Reason__c,Opportunity_Next_Step__c,StageName,CurrencyIsoCode,Frequency__c,ChaseDate_Duration__c,Status_Check__c from opportunity where id =: oppstring.Id];
            previousSupplier = opp.Competitor__c;
            previousProducer = opp.Current_Producer__c;
        }
        else{
            opp=new Opportunity();
            opp.OwnerId = UserInfo.getUserId();
            opp.AccountId = ApexPages.currentPage().getParameters().get('accountId');  
        }
        system.debug('*************** opp.StageName == '+opp.StageName);
        pageMode = ApexPages.currentPage().getParameters().get('pageMode');
        if(opp.Id != null && pageMode != null && (pageMode == 'edit' || pageMode == 'clone')){
            getCppFields();
            if(opp.StageName == 'SPOT') {
                calSpotCloseDate();
            }
            getProjectProbablity();
        }
        //get the opportunity StageName on load of the page to check previous stage and newly updated stage in saveOpp() method
        getOppStage = opp.StageName;
        ApexPages.StandardController sc = new ApexPages.StandardController(oppstring);
        //translation = new TranslateOpportunityAndCPPChangeHistory(sc);
        
    }
    
    // Method to fetch the Undefined Supplier & Producer
//    public void getUndefinedValues(){
//        UndefinedSupplierId = [Select Id from Competitor__c where Name = 'Undefined' LIMIT 1].Id;
//        UndefinedProducerId = [Select Id from Producer__c where Name = 'Undefined' LIMIT 1].Id;
//    }
  
    public Pagereference saveOpp() {

        try {
            Date dtvalue;
            String day;
            String closeDay;
            String chaseDay;
            String prodName;
            //get AccountName and Product Name
            String[] errorList = new String[0];
            String accName = [select id, name from Account where Id =: opp.AccountId].Name;

            if(opp.Univar_Product__c != null) {
                List < UserRecordAccess > Unaccess = [SELECT RecordID, HasReadAccess, HasEditAccess, HasDeleteAccess FROM UserRecordAccess WHERE UserId =: UserInfo.getUserId() AND RecordId =: opp.Univar_Product__c];
                System.debug(Unaccess);
                if(Unaccess[0].HasReadAccess == true) {
//                    getUndefinedValues();
                    System.debug( 'Opp from product' + opp.Univar_Product__c );
                    prodName = [select id, name, UserRecordAccess.HasReadAccess from Univar_Product__c where Id =: opp.Univar_Product__c].Name;
                    System.debug('Product Name' + prodName);
                    opp.Probability = 100;
                    //Changed by AP on 18-07-2018
                    if(opp.Stagename == 'Business Under Threat' || opp.Stagename == 'Existing Business' || opp.Stagename == 'Other Potential' || opp.Stagename == 'Business Out Of Reach') {
                    	if((opp.Competitor__c == UndefinedSupplierId && opp.Competitor__c <> null && String.valueOf(opp.Competitor__c) <> previousSupplier) || 
                                (opp.Current_Producer__c == UndefinedProducerId && opp.Current_Producer__c <>null  && String.valueOf(opp.Current_Producer__c) <> previousProducer)) {
                        	opp.addError(System.label.Undefined_cannot_be_selected);
                            return null;
                        } else {
                        	opp.Is_Background_Update__c = true;
                        }
                    }
                    
                    System.debug(opp.Chase_Date__c);
                    System.debug(opp.Opportunity_Closedate__c);
                    if(Date.valueOf(opp.Chase_Date__c) > Date.valueOf(opp.Opportunity_Closedate__c)) {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, System.Label.Chase_date_should_be_before_than_close_date));
                        return null;
                    }
                    
                    if((opp.Stagename == 'SPOT' || (opp.Stagename.contains('Target Business') && (opp.Stagename.contains('Quick Win') || opp.Stagename.contains('Project')))) && 
                                Date.valueOf(opp.Chase_Date__c) < system.today()) {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, System.Label.Chase_date_passed));
                        return null;
                    }

                    if(opp.Opportunity_Closedate__c != null) {
                    //If the close date falls on a Saturday or Sunday move it back to the Next Monday.    
                        Datetime dt = DateTime.newInstance(opp.Opportunity_Closedate__c, Time.newInstance(0, 0, 0, 0));
                        System.debug('dt>>>>>' +dt);
                        closeDay = dt.format('EEEE');
                        System.debug('colseDay>>>>>>' +closeDay);
                        system.debug('>>Opportunity name>>'+opp.Name+'>>Opportunity stage>>'+opp.StageName);
                        if (closeDay == 'Sunday') {
                            opp.Opportunity_Closedate__c = opp.Opportunity_Closedate__c + 1;
                        } else if (closeDay == 'Saturday') {
                            opp.Opportunity_Closedate__c = opp.Opportunity_Closedate__c + 2;
                        }
                        if(opp.CloseDate == null || opp.Id == null) {
                            opp.CloseDate = opp.Opportunity_Closedate__c;
                        }
                    } else if(opp.CloseDate == null) {
                        opp.CloseDate = system.today();
                    }
                    //calculating the chase date from close date ,if the chase date will be fall on saturday or sunday moving the chase date value to previous current week Friday.                          
                    
                    //If the chase date falls on a Saturday or Sunday move it back to the Previous Friday, except if that is in the past then move to the following Monday.    
                    if(opp.Chase_Date__c != null) {
                        Datetime chasedt = DateTime.newInstance(opp.Chase_Date__c, Time.newInstance(0, 0, 0, 0));
                        chaseday = chasedt.format('EEEE');
                        System.debug('chaseDay>>>>>>' +chaseDay);
                        if(chaseDay == 'Sunday') {
                            opp.Chase_Date__c = opp.Chase_Date__c - 2;
                            if(opp.Chase_Date__c < system.today()) {
                                opp.Chase_Date__c = opp.Chase_Date__c + 3;	
                            }
                        } else if (chaseDay == 'Saturday') {
                            opp.Chase_Date__c = opp.Chase_Date__c - 1;
                            if(opp.Chase_Date__c < system.today()) {
                                opp.Chase_Date__c = opp.Chase_Date__c + 3;	
                            }
                        }
                    }
                    
                    opp.RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('CPP').getRecordTypeId();
                    //Added by saritha for clear field issues -jan 23,2018
                    previousStage = ApexPages.currentPage().getParameters().get('previousstage');
                    if (prevStgParam != null && (prevStgParam == 'sp') && opp.StageName == 'SPOT' && opp.ChaseDate_Duration__c != null && opp.ChaseDate_Duration__c > 0) {
                        opp.Opportunity_Closedate__c = null;
                        opp.chase_date__c = null;
                    }
                    //End
                    if (opp.Chase_Date__c != null && opp.Opportunity_Closedate__c != null && opp.StageName == 'SPOT') {
                        opp.ChaseDate_Duration__c = opp.Chase_Date__c.daysBetween(opp.Opportunity_Closedate__c);
                        opp.ChaseDate_Duration__c = checkChaseDateDuration(opp);
                    }
                    
                    if(opp.StageName == 'SPOT') {
                        if(checkChaseDateDuration(opp) < opp.ChaseDate_Duration__c) {
                            opp.addError(System.label.NewSpotOpportunityCreationChaseDateExceedsFrequency);
                            return null;
                        } else if (opp.ChaseDate_Duration__c == null) {
                            opp.addError(System.label.Chase_Date_Duration_Empty);
                            return null;
                        }                   	
                    }

                    system.debug('recordtypevalue' + opp.RecordTypeId);
                    System.debug('::::' + opp.Comments__c);
                    if (pageMode != null && pageMode == 'edit') {
                        System.debug('::::');
                    
                    /*  if((opp.StageName=='SPOT' || opp.StageName=='Target Business – Quick Win'|| opp.StageName=='Target Business – Project')
                    && (getOppStage!='SPOT' || getOppStage!='Target Business – Quick Win'|| getOppStage!='Target Business – Project')){
                    opp.addError('Please use the edit button to create a parent CPP');
                    system.debug('getanerrormessage');
                    
                    }else{*/
                        Database.SaveResult sr = Database.update(opp,false);
                        Boolean reportError = false;
                        if (!sr.isSuccess()) {
                            for(Database.Error err : sr.getErrors()){
                            	if(!err.getMessage().contains(system.label.closerelatedopportunity) && !err.getMessage().contains(system.label.Closed_Opportunity_Not_Allowed_On_Creation) 
                            	            && !err.getMessage().contains(system.label.Close_Date_Cannot_Be_In_The_Past)) {
                                    errorList.add(escapedString(err.getMessage()));
                                    reportError = true;
                            	}
                            }
                            if(reportError) {    
                                for(String errString : errorList) {
                                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errString);
                                    ApexPages.addMessage(myMsg);
                                }
                            }
                            return null;
                        }
                    //}
                    } else if (pageMode != null && pageMode == 'clone') {
                        System.debug('Cloned Insert Records being processed');
                        opp.Name = accName + '-' + prodName;
                        Opportunity opp1 = opp.clone(false, true);
        	            if(opp1.CloseDate < system.today()) {
        	                opp1.Closedate = system.today();	
        	            }
                        Database.SaveResult sr = Database.insert(opp1,false);
                        Boolean reportCloneError = false;
                        if (!sr.isSuccess()) {
                            for(Database.Error err : sr.getErrors()) {
                                if(!err.getMessage().contains(system.label.Closed_Opportunity_Not_Allowed_On_Creation)) {
                                    errorList.add(escapedString(err.getMessage()));
                                    reportCloneError = true;
                                }
                            }    
                            if(reportCloneError) {    
                                for(String errString : errorList) {
                                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errString);
                                    ApexPages.addMessage(myMsg);
                                }
                            }
                            return null;
                        } else {
                            opp = opp1;
                        }
                    } else if (opp.Id == null) {
                        System.debug('Insert Records being processed');
                        opp.Name = accName + '-' + prodName;
                        Database.SaveResult sr = Database.insert(opp,false);
                        Boolean reportInsertError = false;
                        boolean alreadyExists = false;
                        if(!sr.isSuccess()) {
                            for(Database.Error err : sr.getErrors()) {
                                if(!err.getMessage().contains(system.label.Closed_Opportunity_Not_Allowed_On_Creation) && !err.getMessage().contains(system.label.Close_Date_Cannot_Be_In_The_Past)) {
                                    errorList.add(escapedString(err.getMessage()));
                                    reportInsertError = true;
                                }
                            }
                            if(reportInsertError) {
                            	List<Apexpages.Message> msgs = ApexPages.getMessages();
                                for(String errString : errorList) {
                                	alreadyExists = false;
                                    for(Apexpages.Message msg:msgs) {
                                        if(msg.getDetail().contains(errString)) {
                                            alreadyExists = true;
                                        }                                            	
                                    }
                                    if(!alreadyExists) {
                                        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errString);
                                        ApexPages.addMessage(myMsg);
                                    }    
                                }
                            }
                            return null;
                        }
                    }
                    
                    if (returnString == 'Success' || returnString1 == 'Success') {
                        System.debug('Here we are 2');
                        PageReference pgref;
                        //Navigate to New Cpp creation page with AccountId            
                        if (ApexPages.currentPage().getParameters().get('accountId') != null) {
                            pgref = new PageReference('/apex/CppOpportunitySelection');
                            pgref.getParameters().put('accountId', ApexPages.currentPage().getParameters().get('accountId'));
                            pgref.setRedirect(true);
                        } else {
                            System.debug('Here we are 3');
                            pgref = new PageReference('/apex/CppOpportunitySelection');
                        }
                        return pgref;
                    } else {
                        System.debug('Here we are 4');
                        pagereference pgref = new pagereference('/' + opp.id);
                        return pgref;
                    }
                } else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, System.Label.UnivarProductAccessMissing));
                }
            }
        } catch (System.DMLException ex) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, ex.getMessage()));
        }
        return null;
    }
    
    public static String escapedString(String errorMessage){
        return errorMessage.replaceAll('[|.||"||:|~|!|@|#|$|%|^|&|*|_|+|=|<|>|?|\\(|\\)|\\{|\\}|\\;|\\\'"]', '');
    }
    
    public void getCppFields(){
      	
        System.debug(':::::: opp == '+opp);
        String closeDay;
        String chaseDay;
        isspotedit='checkspot';
        isNewSpot='checkchaseduration';
        isSwitchToSpot='false';
        //ApexPages.StandardController sc = new ApexPages.StandardController(oppstring);
        //translation = new TranslateOpportunityAndCPPChangeHistory(sc);
        system.debug('************* opp.StageName == '+opp.StageName); 
        system.debug('************* pageMode == ' + pageMode);

        if(opp.StageName == 'Target Business – Quick Win'){
            //system.debug('************* translation.TargetBusinessQuickWin_String == '+translation.TargetBusinessQuickWin_String);
            String quckwinclosedate=OpportunitiesCloseandChaseDateValues__c.QuickWin_Close_Date__c.getDescribe().getDefaultValueFormula() ;
            String quckwinchasedate=OpportunitiesCloseandChaseDateValues__c.Quickwin_Chase_Date__c.getDescribe().getDefaultValueFormula() ;
            opp.Opportunity_Closedate__c=system.today()+Integer.valueof(quckwinclosedate);
            opp.Chase_Date__c=system.today()+Integer.valueof(quckwinchasedate);

           //If the close date falls on a Saturday or Sunday move it back to the Next Monday.    
           Datetime dt = DateTime.newInstance(opp.Opportunity_Closedate__c, Time.newInstance(0, 0, 0, 0));
           closeDay=dt.format('EEEE');           
           if(closeDay=='Sunday'){
               //opp.CloseDate=opp.Opportunity_Closedate__c+1;   Changed by AM
               opp.Opportunity_Closedate__c=opp.Opportunity_Closedate__c+1;
           }else if(closeDay=='Saturday'){
               //opp.CloseDate=opp.Opportunity_Closedate__c+2;   Changed By AM
               opp.Opportunity_Closedate__c=opp.Opportunity_Closedate__c+2;
           }
             
           //calculating the chase date from close date ,if the chase date will be fall on saturday or sunday moving the chase date value to previous current week Friday.                          
   
           //If the chase date falls on a Saturday or Sunday move it back to the Previous Friday, except if that is in the past then move to the following Monday.    

           Datetime chasedt = DateTime.newInstance( opp.Chase_Date__c, Time.newInstance(0, 0, 0, 0));
           chaseday=chasedt.format('EEEE'); 
                                 
           if(chaseDay=='Sunday'){
               opp.Chase_Date__c=opp.Chase_Date__c-2;
               if(opp.Chase_Date__c < system.today()) {
                   opp.Chase_Date__c = opp.Chase_Date__c + 3;	
               }
           }else if(chaseDay=='Saturday'){
               opp.Chase_Date__c=opp.Chase_Date__c-1;
               if(opp.Chase_Date__c < system.today()) {
                   opp.Chase_Date__c = opp.Chase_Date__c + 3;	
               }
           }
                          
        }else if(opp.StageName == 'SPOT' && pageMode=='clone'){
            //added code to fix UNV_CH-119 from change request sheet
            opp.Chase_Date__c = null;
            opp.ChaseDate_Duration__c = null;
        }
        
        previousStage= ApexPages.currentPage().getParameters().get('previousstage');
        if(pageMode!=null && pageMode=='edit'&& previousStage=='cpp'&&opp.Id!=null){  
            isspotedit='oldspot';
            isNewSpot='hidechaseduration';
        }
        
        if(opp.id==null){
            isspotedit='newspot';
            isNewSpot='showchaseduration';
        }
        
        prevStgParam = ApexPages.currentPage().getParameters().get('prevstg');
        if(prevStgParam!= null && ( prevStgParam =='qw' || prevStgParam == 'project') && opp.StageName == 'SPOT')
            isSwitchToSpot = 'true'; 
            
        //Added by Swati for clear field issue - defect 934
        if(opp.StageName == 'SPOT' && previousStage == 'cpp'){
            opp.Frequency__c = NULL;
            opp.ChaseDate_Duration__c = NULL;
        }
        
        //Added by saritha for clear field issues -jan 23,2018
        previousStage= ApexPages.currentPage().getParameters().get('previousstage');

        if(opp.StageName == 'Target Business – Project' && prevStgParam!='project'){
            opp.Opportunity_Closedate__c=null;
            opp.chase_date__c=null;
            opp.Opportunity_Next_Step__c=null;
           
        }

        //check if the previous stage is project
        if((opp.StageName == 'Target Business – Project' || opp.StageName == 'SPOT' || opp.StageName == 'Target Business – Quick Win') && prevStgParam=='project'){
            if( opp.StageName != 'Target Business – Quick Win'){
                opp.Opportunity_Closedate__c=null;
                opp.chase_date__c=null;
            }
            opp.Opportunity_Next_Step__c=null;
            opp.GP__c=null;
            opp.Opportunity_Stage__c=null;
            opp.Opportunity_Probability__c=null;
           
        }
        
        //check if the previous stage is quickwin
        if((opp.StageName == 'Target Business – Project' || opp.StageName == 'SPOT') && prevStgParam=='qw'){
            opp.Opportunity_Closedate__c=null;
            opp.chase_date__c=null;
            opp.GP__c=null;
            opp.Opportunity_Next_Step__c=null;
            opp.Frequency__c=null;
        }

        //check if previous stage is project 
        if(opp.StageName == 'SPOT' || (prevStgParam=='project' && opp.StageName == 'SPOT')){
            //opp.Opportunity_Closedate__c=null;
            calSpotCloseDate();
            opp.chase_date__c=null;
            opp.Opportunity_Closedate__c = null;
        }        
        
    }

    public Integer checkChaseDateDuration(Opportunity opp) {
        
        Integer chaseDateDuration;

        if(opp.Frequency__c != '--None--') {
            if(opp.Frequency__c == '1 Week') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_1_Week__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '2 Weeks') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_2_Week__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '3 Weeks') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_3_Week__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '30 Days') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_1_Month__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '60 Days') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_2_Month__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '90 Days') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_3_Month__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '180 Days') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_6_Month__c.getDescribe().getDefaultValueFormula());
            } else if(opp.Frequency__c == '1 Year') {
                chaseDateDuration = Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_1_Year__c.getDescribe().getDefaultValueFormula());
            }
        }
        
        if(chaseDateDuration != null && opp.ChaseDate_Duration__c > chaseDateDuration) {
            return chaseDateDuration;	
        } else {
        	return Integer.valueOf(opp.ChaseDate_Duration__c);
        }
          
    }
    
    public void calSpotCloseDate() {
    String closedateday;
    
    system.debug('************* opp.Frequency__c == '+opp.Frequency__c);
    //system.debug('************* translation.Week1_string == '+translation.Week1_string); 
    if(opp.Frequency__c!='--None--'){
    if(opp.Frequency__c=='1 Week'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_1_Week__c.getDescribe().getDefaultValueFormula()) ;
      }else if(opp.Frequency__c=='2 Weeks'){
       opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_2_Week__c.getDescribe().getDefaultValueFormula()) ;
      }else if(opp.Frequency__c=='3 Weeks'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_3_Week__c.getDescribe().getDefaultValueFormula());
      }else if(opp.Frequency__c=='30 Days'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_1_Month__c.getDescribe().getDefaultValueFormula());
      }else if(opp.Frequency__c=='60 Days'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_2_Month__c.getDescribe().getDefaultValueFormula());
      }else if(opp.Frequency__c=='90 Days'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_3_Month__c.getDescribe().getDefaultValueFormula());
      }
      else if(opp.Frequency__c=='180 Days'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_6_Month__c.getDescribe().getDefaultValueFormula());
      }
      else if(opp.Frequency__c=='1 Year'){
      opp.Opportunity_Closedate__c=system.today()+Integer.valueof(OpportunitiesCloseandChaseDateValues__c.Spot_Frequency_1_Year__c.getDescribe().getDefaultValueFormula());
      }
       
      }  
        if(opp.Opportunity_Closedate__c!=null){
    Datetime closedt = DateTime.newInstance(opp.Opportunity_Closedate__c, Time.newInstance(0, 0, 0, 0));
                                 closedateday=closedt.format('EEEE'); 
                                 System.debug('closedateday' +closedateday);
                                 if(closedateday=='Sunday'){
                                    opp.Opportunity_Closedate__c=opp.Opportunity_Closedate__c+1;
                                }else if(closedateday=='Saturday'){
                                    opp.Opportunity_Closedate__c=opp.Opportunity_Closedate__c+2;
                                }    
        }
   }
    
    public Pagereference doCancel(){
    pagereference returnPage;
    if(ApexPages.currentPage().getParameters().get('accountId')!=null || pageMode=='edit' || pageMode=='clone' || ApexPages.currentPage().getParameters().get('Id')!=null){
   
       if(ApexPages.currentPage().getParameters().get('accountId')!=null){
           returnPage = new pagereference('/' +(ApexPages.currentPage().getParameters().get('accountId')));  
       }else if(ApexPages.currentPage().getParameters().get('Id')!=null && (pageMode=='edit'|| pageMode=='clone')){
           returnPage = new pagereference('/' +(ApexPages.currentPage().getParameters().get('Id')));  
       }
     
       returnPage.setRedirect(true);
       return returnPage ;
    }else{
       returnPage = new pagereference('/apex/Opportunity_Override?save_new' +(ApexPages.currentPage().getParameters().get('save_new')));    
       returnPage.setRedirect(true);
       return returnPage ;
    }
     
   
    }    
        public void getProjectProbablity(){
            if(opp.Opportunity_Stage__c!=null){
        Decimal probaliltyvalue=[Select DefaultProbability from OpportunityStage where ApiName=:opp.Opportunity_Stage__c].DefaultProbability ;
        opp.Opportunity_Probability__c=probaliltyvalue;
            }
        }
        public void gethideOppSection(){
           checkoppSecShow=true;
           getCppFields();
        }
}