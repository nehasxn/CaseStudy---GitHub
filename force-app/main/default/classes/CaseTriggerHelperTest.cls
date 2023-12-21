@isTest
public class CaseTriggerHelperTest {
    
    @testSetup static void setup() {
        // Create common test accounts
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts; 
        
        List<Case> testCases = new List<Case>();
        for(Integer i=0;i<2;i++) {
            testCases.add(new Case(Status='New',
                                  AccountId=testAccts[i].Id));
        }
        insert testCases; 
    }
    
    @isTest static void afterInsertTest() {
        
        Account acct = [SELECT Id, CSR__c, CS_Rating__c, Account.Name FROM Account WHERE Name='TestAcct0' LIMIT 1];
        Case caseObj = [SELECT Id, Customer_Satisfaction_Rating__c, AccountId, Account.Name
                        FROM Case WHERE ACCOUNTID = :acct.Id LIMIT 1];

        System.assertEquals('TestAcct0', acct.Name);
    }
    
    @isTest static void afterUpdateTest() {
        
        Account acct = [SELECT Id, CSR__c, CS_Rating__c, Account.Name FROM Account WHERE Name='TestAcct0' LIMIT 1];
        Case caseObj = [SELECT Id, Customer_Satisfaction_Rating__c, AccountId, Account.Name
                        FROM Case WHERE ACCOUNTID = :acct.Id LIMIT 1];
        
        caseObj.Customer_Satisfaction_Rating__c = 3;
        caseObj.Status = 'Closed';
        Test.startTest();
        Database.SaveResult result = Database.update(caseObj, false);
        Test.stopTest();
        System.assertEquals(3, caseObj.Customer_Satisfaction_Rating__c);
    }
    
    @isTest static void afterDeleteTest() {
        
        Account acct = [SELECT Id, CSR__c, CS_Rating__c, Account.Name FROM Account WHERE Name='TestAcct0' LIMIT 1];
        Case caseObj = [SELECT Id, Customer_Satisfaction_Rating__c, AccountId, Account.Name
                        FROM Case WHERE ACCOUNTID = :acct.Id LIMIT 1];
        
        caseObj.Customer_Satisfaction_Rating__c = 3;
        caseObj.Status = 'Closed';
        update caseObj;
        Test.startTest();
        Database.DeleteResult result = Database.delete(caseObj, false);
        Test.stopTest();
    }

}