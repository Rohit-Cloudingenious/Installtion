@isTest
private class InstallerWelcomeTest {
    
	@TestSetup
    static void setupTestData() {
        Installation__c installation = new Installation__c();
        insert installation;
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
    }
    
    @isTest()
    static void testGetInstallationRecord() {
        Installation__c resultInstallation = IntallerWelcome.getInstallationRecord([SELECT Id FROM Installation__c LIMIT 1].Id);
        System.assertEquals(null, resultInstallation.Site_Number__c);
        Account resultAccount = IntallerWelcome.welcomeMessage([SELECT Id FROM Account LIMIT 1].Id);
    }
}