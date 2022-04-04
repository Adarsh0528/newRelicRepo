public class AccountTriggerHandler {

    public static void updateAccount(Map<Id,Account>newAccountsMap,Map<Id,Account>oldAccountsMap){
       AccountTriggerHelper.updateOpportunities(newAccountsMap,oldAccountsMap);
    }
}