/**
 * This class is the handler for the Opportunity Edit Override.
 *
 * @author      Steve Woollard <steven.woollard@solutionsspectrum.co.uk>
 * @version     1.0
 */
  
public with sharing class OpportunityEditOverride {

    public Opportunity opp {get; set;}
    public Boolean isCppOpp {get; set;} 
    private ApexPages.StandardController stdCtrl;
    
    /**
     * Executes all the logic needed on instantiation.
     *
     */
     
    public OpportunityEditOverride(ApexPages.StandardController controller) {

        this.stdCtrl = controller;
        stdCtrl.addFields(new List<String>{'StageName'});
        Id cppRecTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('CPP').getRecordTypeId();
        this.opp = (Opportunity) controller.getRecord();
        if(opp.RecordTypeId == cppRecTypeId) {
            this.isCppOpp = true;
        } else {
        	this.isCppOpp = false;
        }
        
    }
    
    /**
     * If the record being edited is a true Opportunity record then direct to the Opportunity edit page
     * however if the record being edited is a CPP record then re-direct to the CPPOpportunitySelection page
     *
     * @param N/A
     */
     
    public PageReference getLandingPage() {
    	
        PageReference pageRef;
    
        if(isCppOpp) {
            pageRef= new PageReference('/apex/CppOpportunitySelection');
            pageRef.getParameters().put('Id', opp.Id);         
            pageRef.getParameters().put('pageMode','edit');
            if((opp.stagename == 'Business Lost') || (opp.stagename == 'Business Out Of Reach') || (opp.stagename == 'Business Under Threat') || opp.stagename == 'Not Used' ||
                    (opp.stagename == 'Other potential') || (opp.stagename == 'Existing Business') || (opp.stagename == 'Missed Opportunity')) {
                pageRef.getParameters().put('previousstage','cpp');
            } else {
                pageRef.getParameters().put('previousstage','noncpp');
            }           
            if(opp.stagename.contains('Target Business') && opp.stagename.contains('Project')) {
                pageRef.getParameters().put('prevstg','project');
            } else if((opp.stagename.contains('Target Business') &&  opp.stagename.contains('Quick Win')) || opp.stagename == 'Target Business Tidy Up 2017' || 
                        opp.stagename == 'Target Business' || opp.stagename == 'Marchés Cible à Revoir') {
                pageRef.getParameters().put('prevstg','qw');
            } else if(opp.stagename == 'SPOT') {
                pageRef.getParameters().put('prevstg','sp');
            }
            pageRef.setRedirect(true);        	
        } else {
        	pageRef = new PageReference('/' + stdCtrl.getId() + '/e');
            pageRef.getParameters().put('retURL', stdCtrl.getId());         
            pageRef.getParameters().put('nooverride', '1');        	
        }
        return pageRef;        
            	    	
    }
    
}