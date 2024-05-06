trigger triggerOnCredit on Credit__c (after update) {   
    if(Trigger.IsUpdate){
        SendEmailForCreditController.sendCreditEmailNotifications(Trigger.New, Trigger.OldMap);
    }
}