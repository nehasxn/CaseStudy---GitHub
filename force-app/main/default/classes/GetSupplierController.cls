public class GetSupplierController {
    
    @AuraEnabled(Cacheable = true)
    public static List<Supplier__c> searchSuppliers(String strCityName) {
        strCityName = '%' + strCityName + '%';
        List<Supplier__c> supplierList = new List<Supplier__c>();
        try{
            supplierList = [SELECT Id, Name, City__c, Coordinates__Latitude__s, Coordinates__Longitude__s,
                                          Address__Street__s, Address__City__s, Address__StateCode__s,
                                          Address__CountryCode__s, Address__PostalCode__s, Address__GeocodeAccuracy__s, 
                                          Address__Latitude__s, Address__Longitude__s, Address__c, Supplier_Url__c  
                                          FROM Supplier__c WHERE City__c LIKE:strCityName];
        } catch(Exception e){
            system.debug('Exception is : ' + e.getMessage());
        }
        return supplierList; 
    }
    
    @AuraEnabled(Cacheable = true)
    public static Account getAccountCity(Id recordId) {
        Account accountObj = new Account();
        try{
            accountObj = [SELECT Id, BillingCity FROM Account WHERE ID =:recordId LIMIT 1];
        }
        catch(Exception e){
            system.debug('Exception is : ' + e.getMessage());
        }
        return accountObj; 
    }
}