/**
 * @description       : Case Trigger Handler Apex class. 
 * 						This is called from Case Trigger.
 * @author            : Neha Saxena 
 * @last modified on  : 21-12-2023
 * @last modified by  : 
**/
public class CaseTriggerHandler implements ITriggerHandler {

    private boolean triggerIsExecuting;
    private integer triggerSize;
    private string triggerOperationType;
    public CaseTriggerHelper helper;
    public static Map<String,Set<Id>> mapExecutedRecord = new Map<String,Set<Id>>();

    public CaseTriggerHandler(boolean triggerIsExecuting, integer triggerSize, String triggerOperationType) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.triggerOperationType = triggerOperationType;
        this.helper = new CaseTriggerHelper();
    }
    
    public void beforeInsert(List<Case> newCases) {
        // helper.beforeInsertHelper();
    }
    
    public void beforeUpdate(List<Case> oldCases, List<Case> newCases, Map<ID, SObject> oldCaseMap, Map<ID, SObject> newCaseMap) {
        // helper.beforeUpdateHelper();
    }

    public void beforeDelete(List<Case> oldCases, Map<ID, SObject> oldCaseMap) {
        // helper.beforeDeleteHelper();
    }
    
    public void afterInsert(List<SObject> newCases, Map<ID, SObject> newCaseMap) {
         helper.afterInsertHelper(newCases, newCaseMap);
    }
    
    public void afterUpdate(List<Case> oldCases, List<Case> newCases, Map<ID, SObject> oldCaseMap, Map<ID, SObject> newCaseMap) {
        helper.afterUpdateHelper(oldCases, newCases, oldCaseMap, newCaseMap);
    }
    
    public void afterDelete(List<Case> oldCases, Map<ID, SObject> oldCaseMap) {
        helper.afterDeleteHelper(oldCases, oldCaseMap);
    }

    public void afterUndelete(List<Case> newCases, Map<ID, SObject> newCaseMap) {
        // helper.afterUndeleteHelper();
    }
}