/**
 * @description       : ITriggerHandler interface has method signatures
 * @author            : Neha Saxena 
 * @last modified on  : 21-12-2023
 * @last modified by  : 
**/
public interface ITriggerHandler {
    void beforeInsert(List<SObject> newRecords);
    void beforeUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<ID, SObject> oldRecordMap, Map<ID, SObject> newRecordMap);
    void beforeDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);
    void afterInsert(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
    void afterUpdate(List<SObject> oldRecords, List<SObject> newRecords, Map<ID, SObject> oldRecordMap, Map<ID, SObject> newRecordMap);
    void afterDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);
    void afterUndelete(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
}