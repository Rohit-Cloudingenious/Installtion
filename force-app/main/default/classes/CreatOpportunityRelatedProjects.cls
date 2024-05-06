public class CreatOpportunityRelatedProjects {
    public static void createOpportunity(List<Project__c> projects) {
        List<Opportunity> oppList = new List<Opportunity>();
        List<Project__c> projectList = new List<Project__c>();
        for (Project__c project: projects) {
            Opportunity opp = new opportunity();
            opp.Name = project.Name + '-Opportunity';
            opp.Installation_Date__c = System.today().addDays(30);
            opp.CloseDate = System.today().addDays(30);
            opp.StageName = 'Prospecting';
            opp.OwnerId = project.CreatedById;
            opp.RecordTypeId = '0123t000000dy52AAA';
            opp.AccountId = project.Customer_Name__c;
            oppList.add(opp);
        }
        insert oppList;
        System.debug(oppList);
        for (Project__c project: projects) {
            for (Opportunity opp: oppList) {
                if (opp.OwnerId == project.CreatedById) {
                    Project__c pro = new Project__c();
                    pro.Id = project.Id;
                    pro.Opportunity__c = opp.Id;
                    projectList.add(pro);
                }
        	}
        }
        update projectList;
        System.debug('Project: '+projectList);
    }
}