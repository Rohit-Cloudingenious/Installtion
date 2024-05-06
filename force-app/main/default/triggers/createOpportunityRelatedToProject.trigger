trigger createOpportunityRelatedToProject on Project__c (after insert) {
    CreatOpportunityRelatedProjects.createOpportunity(Trigger.new);
}