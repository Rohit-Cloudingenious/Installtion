@isTest
public class OpportunityTriggerHandlerTest {
    
    @TestSetup
    static void setupTestData() {
       Account testAccount = new Account(Name = 'Test Account');
       insert testAccount;
       Opportunity testOpp = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Customer Evaluating',
            CloseDate = System.now().date(),
            //RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('RSG Opportunities').getRecordTypeId(),
            AccountId = testAccount.Id
        );
        insert testOpp;
    }
    
    @isTest
    static void testCreateRelatedProject() {
        List<Opportunity> testOpp = [Select Id, Name, StageName, AccountId, RecordTypeId From Opportunity];
        testOpp[0].Name = 'test';
        update testOpp;
        Test.startTest();
        OpportunityTriggerHandler.createRelatedProject(testOpp);
        Test.stopTest();
    }
}