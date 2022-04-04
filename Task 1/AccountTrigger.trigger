trigger AccountTrigger on Account (after update) {

     if(trigger.isUpdate && trigger.isAfter){
        AccountTriggerHandler.updateAccount(trigger.newMap,trigger.oldMap);   
    }
}