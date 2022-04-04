public class AccountTriggerHelper {
    
    public static void updateOpportunities(Map<Id,Account>newAccountsMap,Map<Id,Account>oldAccountsMap){
        
        set<Id>accountIds = new set<Id>();
        for(Account eachAccount:newAccountsMap.values()){
            if(newAccountsMap.get(eachAccount.id).OwnerId != oldAccountsMap.get(eachAccount.id).OwnerId){
                accountIds.add(eachAccount.Id); 
            }
        }      
        
        Map<Id,Account>accountIdMap = new Map<Id,Account>([select id,name,ownerid from Account where id in :accountIds]);
        List<Opportunity>opptysList = [select id,name,stageName,AccountId,Account.OwnerId from Opportunity where AccountId in :accountIds and stageName !='Closed Won'];
        List<opportunity>updatedOpptysList = new List<Opportunity>();
        
        for(Opportunity eachOppty: opptysList){
            eachOppty.OwnerId = accountIdMap.get(eachOppty.AccountId).ownerId;
            updatedOpptysList.add(eachOppty);
        }
        
        if(updatedOpptysList !=null &&  !updatedOpptysList.isEmpty() && updatedOpptysList.size()>0 ){
            update updatedOpptysList;
        }
    }
}