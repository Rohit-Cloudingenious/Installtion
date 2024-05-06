trigger TriggerOnProject on Project__c (after insert, after Update) {
    ProjectTriggerHandler.createRelatedInstall(Trigger.New);
}