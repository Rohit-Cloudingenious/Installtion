public class InstallationWrapper {
	@AuraEnabled
    public String apiname;
    @AuraEnabled
    public Map<String, Boolean> optionWithValue;
    @AuraEnabled
    public String checklistSection;
    @AuraEnabled
    public String question;

    public InstallationWrapper(String apiname, String question, Map<String, Boolean> optionWithValue, String checklistSection, Integer num) {
        this.apiname = apiname;
        this.question = num + '. ' + question;
        this.optionWithValue = optionWithValue;
        this.checklistSection = checklistSection;
    }
}