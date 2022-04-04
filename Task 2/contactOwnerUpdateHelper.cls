public class contactOwnerUpdateHelper {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsList(String accountId) {
        return [SELECT Id,Name,MailingCountry,Owner.Name,OwnerId,AccountId FROM Contact where accountId = :accountId];
    }

    @AuraEnabled(cacheable=false)
    public static void updateContacts(String selectedContacts) { 
      
      List<contact>contactsList = (List<contact>)JSON.deserialize(selectedContacts, List<contact>.class);
      system.debug('selectedCon'+contactsList);
      set<Id>contactIds = new set<Id>();  
      for(Contact eachContact: contactsList){
          contactIds.add(eachContact.Id);  
      }  
      List<Contact>getContactsList = [select id,name,owner.Name,MailingCountry,AccountId,Account.OwnerId from Contact where Id in :contactIds];
      List<contact>contactsToBeUpdatedList = new List<Contact>();

       for(Contact eachContact: getContactsList){
          eachContact.OwnerId  = eachContact.Account.OwnerId; 
          contactsToBeUpdatedList.add(eachContact);
       }
       if(contactsToBeUpdatedList!=null && !contactsToBeUpdatedList.isEmpty() && contactsToBeUpdatedList.size()>0){
           update contactsToBeUpdatedList;
       }
    }
}