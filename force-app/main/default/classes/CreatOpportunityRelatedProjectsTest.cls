@isTest
private class CreatOpportunityRelatedProjectsTest {
    @isTest
    static void testCreateOpportunity() {
        Project__c project = new Project__c();
        project.Name = 'Test Project ';
        insert project;
        List<Project__c> testProject = [Select Id, Name, CreatedById, Installation_Type__c, Customer_Name__c, Installer_Name__c, Site_Number__c,Site_Address__StateCode__s
                                        From Project__c];
        Test.startTest();
        CreatOpportunityRelatedProjects.createOpportunity(testProject);
        Test.stopTest();
    }
}