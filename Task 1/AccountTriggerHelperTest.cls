@isTest(seeAllData = false)
public class AccountTriggerHelperTest {

      @istest static void testOpptyUpdate(){
        
        Account newAccount = new Account(name = 'TestAcc1',Industry='Apparel');
        insert newAccount;
        List<Opportunity>opptyList = new List<opportunity>();   
        opportunity newOppty = new opportunity(name='TestOppty',StageName = 'Qualification',AccountId = newAccount.Id,closeDate = date.today().addDays(30));
        opptyList.add(newOppty);
        opportunity newOppty2 = new opportunity(name='TestOppty2',StageName = 'Prospecting',AccountId = newAccount.Id,closeDate = date.today().addDays(30));
        opptyList.add(newOppty2);   
        opportunity newOppty3 = new opportunity(name='TestOppty3',StageName = 'Closed Won',AccountId = newAccount.Id,closeDate = date.today());
        opptyList.add(newOppty3);     
        insert opptyList;
        Profile getProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User newUser = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = getProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser232@testorg.com');  
        insert newUser;  
        newAccount.ownerId = newUser.Id;
        update newAccount;  
       
      }
}