@isTest
private class InstallerSiteDataTableControllerTest {
    @TestSetup
    static void setupTestData() {
        //Id rtId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Installer/Surveyor').getRecordTypeId();
        Account testAccountInstallation = new Account();
        testAccountInstallation.Name = 'Installer';
        //testAccountInstallation.RecordTypeId = rtId;
        insert testAccountInstallation;
        Installation__c testInstallation = new Installation__c();
        insert testInstallation;
    }
    
    @isTest
    static void testCleanDataMethod() {
        InstallerSiteDataTableController.getData([Select Id From Account Limit 1].Id, 0);
        Test.startTest();
        InstallerSiteDataTableController.getData([Select Id From Account Limit 1].Id, 1);
        InstallerSiteDataTableController.getSubmittedData([Select Id From Account Limit 1].Id, 1);
        InstallerSiteDataTableController.getSubmittedData([Select Id From Account Limit 1].Id, 0);
        Test.stopTest();
    }
}