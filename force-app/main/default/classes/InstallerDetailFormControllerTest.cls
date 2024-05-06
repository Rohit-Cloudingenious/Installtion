@isTest
private class InstallerDetailFormControllerTest {

    @TestSetup
    static void setupTestData() {
        Installation__c installation = new Installation__c();
        insert installation;
        ContentNote testNote = new ContentNote(
            Title = 'Test Note',
            Content = Blob.valueOf('Test Note Content')
        );
        insert testNote;
        ContentVersion cv = new ContentVersion(
            Title = 'Test File',
            VersionData = Blob.valueOf('Test File Content'),
            PathOnClient = 'TestFile.txt',
            FirstPublishLocationId = installation.Id
        );
        
        ContentDocumentLink testLink = new ContentDocumentLink(
            LinkedEntityId = installation.Id,
            ContentDocumentId = [Select ContentDocumentId from ContentVersion Limit 1].ContentDocumentId,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert testLink;
    }
    
    @isTest
    static void testGetVersionFiles() {
        String installId = [SELECT Id FROM Installation__c LIMIT 1].Id;
        Test.startTest();
        List<ContentVersion> result = InstallerDetailFormController.getVersionFiles(installId);
        List<ContentVersion> result1 = InstallerDetailFormController.retrieveFiles(installId);
        Installation__c testInstallation = InstallerDetailFormController.updateInstallationRecord(installId, 'Test', 'Open', 'Test0');
        Installation__c testInstall = InstallerDetailFormController.updateInstallCheckbox(new List<Installation__c>{}, installId);
        Installation__c testInstall1 = InstallerDetailFormController.updateInProgressRecord(installId, 'Test', 'Open', 'Test0');
        Test.stopTest();
    }
    
    @isTest
    static void testNotes() {
        String installId = [SELECT Id FROM Installation__c LIMIT 1].Id;
        Test.startTest();
        InstallerDetailFormController.createNote('Test Note', 'This is a test note', installId);
        Installation__c installation = new Installation__c();
        insert installation;
        InstallerDetailFormController.createNote('Test Note1', 'This is a test note1',installation.Id);
        InstallerDetailFormController.getNote(installId, 'Test Note1');
        Test.stopTest();
    }

	@isTest
    static void testFileAndVersion() {
        String installId = [SELECT Id FROM Installation__c LIMIT 1].Id;
        Test.startTest();
        InstallerDetailFormController.uploadFile('U29tZSB0ZXh0IHRvIGJlIHN0cmluZw==', 'test.txt', installId);
        ContentVersion cv = InstallerDetailFormController.createContentVersion('U29tZSB0ZXh0IHRvIGJlIHN0cmluZw==', 'test.txt');
        ContentDocumentLink cdl = InstallerDetailFormController.createContentLink([Select Id From ContentVersion Limit 1].Id, installId);
        Test.stopTest();
    }
    
    @isTest
    static void testData() {
        String installId = [SELECT Id FROM Installation__c LIMIT 1].Id;
        List<Map<String, String>> checkboxSelectList = new List<Map<String, String>>();
        Map<String, String> checkboxMap = new Map<String, String>();
        checkboxMap.put('Id', installId);
        checkboxMap.put('Walkin_Question_One__c', 'Walkin_Question_One__c');
        checkboxSelectList.add(checkboxMap);
        Test.startTest();
        InstallerDetailFormController.updateData(checkboxSelectList, installId, 'Open');
        InstallerDetailFormController.updateGenData(checkboxSelectList, installId, 'Open');
        Test.stopTest();
    }
}