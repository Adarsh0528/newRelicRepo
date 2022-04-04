public with sharing class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name 
            FROM Account limit 5];
    }

    @AuraEnabled(cacheable=false)
    public static List<Account> getAccountDetails(Id accountId) {
      
        system.debug('AccountId'+accountId);
        return [SELECT Id, Name,Industry,Type,Owner.Name 
        FROM Account where Id = :accountId];
    }
}