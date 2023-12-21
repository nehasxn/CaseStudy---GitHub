/**
 * @description       : Case Trigger Helper Apex class is called from CaseTriggerHandler.
 * 						This class contains logics to be performed on DML.
 * @author            : Neha Saxena 
 * @last modified on  : 21-12-2023
 * @last modified by  : 
**/
public without sharing class CaseTriggerHelper {

    public CaseTriggerHelper() {
        
    }
    
    public void afterInsertHelper(List<Case> newCases, Map<ID, SObject> newCaseMap) {
        List<Case> newCaseListToProcess = new List<Case>();
        for(Case caseObj : newCases){
            CaseTriggerHandler.mapExecutedRecord.put('AFTER_INSERT',new Set<Id> {caseObj.Id});
            if(CaseTriggerHandler.mapExecutedRecord.size()>0 && CaseTriggerHandler.mapExecutedRecord.get('AFTER_INSERT').contains(caseObj.id)) {
                newCaseListToProcess.add(caseObj);
            }
        }
        addCSRonAccount(newCaseListToProcess);
    }
    
    public void afterUpdateHelper(List<Case> oldCases, List<Case> newCases, Map<ID, SObject> oldCaseMap, Map<ID, SObject> newCaseMap) {
        List<Case> newCaseListToProcess = new List<Case>();
        for(Case caseObj : newCases){
            CaseTriggerHandler.mapExecutedRecord.put('AFTER_UPDATE',new Set<Id> {caseObj.Id});
            if(CaseTriggerHandler.mapExecutedRecord.size()>0 && CaseTriggerHandler.mapExecutedRecord.get('AFTER_UPDATE').contains(caseObj.id)) {
                newCaseListToProcess.add(caseObj);
  			}
        }
        addCSRonAccount(newCaseListToProcess);
    }
    
    public void afterDeleteHelper(List<Case> oldCases, Map<ID, SObject> oldCaseMap) {
        List<Case> oldCaseListToProcess = new List<Case>();
        for(Case caseObj : oldCases){
            CaseTriggerHandler.mapExecutedRecord.put('AFTER_DELETE',new Set<Id> {caseObj.Id});
            if(CaseTriggerHandler.mapExecutedRecord.size()>0 && CaseTriggerHandler.mapExecutedRecord.get('AFTER_DELETE').contains(caseObj.id)) {
                oldCaseListToProcess.add(caseObj);
            }
        }
        addCSRonAccount(oldCaseListToProcess);
    }
    
    /*@ Method Name: addCSRonAccount
	@ Parameters: List<Case> newCases
	@ Create By: Neha Saxena
	@ Created Date:  Dec 2023
	@ Description: Method to update Average Customer Satisfaction Rating on Account from Suppliers 
	@*/
    public void addCSRonAccount(List<Case> newCases) {
                
        Set<Id> accountIdSet = new Set<Id>();
        if(newCases!= null){
            for(Case eachCase: newCases){
                if(eachCase.AccountId !=null){
                    accountIdSet.add(eachCase.AccountId);
                }
            }
        }
        
        if(!accountIdSet.isEmpty()){
        	List<Account> accList = [SELECT Id, CSR__c, CS_Rating__c 
                                 	FROM Account WHERE Id IN : accountIdSet];
            List<Case> caseList = [Select Id, Customer_Satisfaction_Rating__c, AccountId  
                                   FROM CASE WHERE ACCOUNTID IN :accountIdSet AND Status = 'CLOSED'];
        
            if(!accList.isEmpty()){
                List<Account> updateAccList = new List<Account>();
                for(Account acc:accList){
                    Integer count = 0;
                	Double val = 0;
                	for(Case caseObj : caseList){
                    	if(caseObj.AccountId == acc.Id){
                            val = val + caseObj.Customer_Satisfaction_Rating__c;
                            count++;
                        }
                    }
                    if(count !=0){
                        Double finalVal = val / count;
                        acc.CS_Rating__c = finalVal;
                    }
                    updateAccList.add(acc);
                }
                if(!updateAccList.isEmpty()){
                    Database.SaveResult[] results = Database.update(updateAccList, false);
                }
            }
        }
    }

}