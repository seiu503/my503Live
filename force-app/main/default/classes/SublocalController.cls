Public class SublocalController{
    @AuraEnabled
    public static Id getLoggedInUser() {
        Id sublocalId;
        try
        {
            User u = [SELECT Id, Contact.CVRSOS__Local__c FROM User WHERE Id =: UserInfo.getUserId()];    
            Id sublocalId = u.Contact.CVRSOS__Local__c;
        }
        catch(Exception ex){
            system.debug(' Exception ==> ' + ex.getMessage());
        }
        return sublocalId;
    }
}