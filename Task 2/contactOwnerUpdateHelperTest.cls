@isTest(seeAllData = false)
public class contactOwnerUpdateHelperTest {

     @istest static void testContactOwnerUpdate(){
        
        Account newAccount = new Account(name = 'TestAcc1',Industry='Apparel',OwnerId = UserInfo.getUserId());
        insert newAccount;
        Profile getProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User newUser = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = getProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser232@testorg.com');  
        insert newUser;   
        List<Contact>contactsList = new List<contact>(); 
         List<String>contactIds = new List<String>();
        Contact newCon = new Contact(lastname = 'TestLastName',email= 'test@abc.com',AccountId = newAccount.Id,OwnerId = newUser.Id);
        Contact newCon2 = new Contact(lastname = 'TestLastName2',email= 'test@abc2.com',AccountId = newAccount.Id,OwnerId = newUser.Id); 
        Contact newCon3 = new Contact(lastname = 'TestLastNam3',email= 'test@abc3.com',AccountId = newAccount.Id,OwnerId = newUser.Id);
        Contact newCon4 = new Contact(lastname = 'TestLastName4',email= 'test@abc4.com',AccountId = newAccount.Id,OwnerId = newUser.Id); 
        contactsList.add(newCon); 
        contactsList.add(newCon2); 
        contactsList.add(newCon3); 
        contactsList.add(newCon4); 

        insert contactsList;
         for(Contact eachContact:contactsList){
             contactIds.add(eachContact.id);
         }
        contactOwnerUpdateHelper.getContactsList(newAccount.id); 
        contactOwnerUpdateHelper.updateContacts(contactIds);
       
      }
}