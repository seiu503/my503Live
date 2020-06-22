public with sharing class UserStewardListController {
	
    private final User user;
    private final Contact userContact;
    public final Account userAccount;
    private final CVRSOS__Local__c sublocal;
    private final Id sublocalId;

    public UserStewardListController(ApexPages.StandardController stdController) {
        System.debug(LoggingLevel.INFO, '>>> UserStewardListController');
        this.user = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUSerId()];
         System.debug(LoggingLevel.INFO, '>>> USER' + user);
        this.userContact = [SELECT Id, Name, AccountId from Contact WHERE Id = :user.ContactId];
       System.debug(LoggingLevel.INFO, '>>> USER CONTACT' + userContact);

 			this.userAccount = [SELECT Id, Name, Sublocal__c, Organizer_Name__c, Organizer_Email__c, Organizer_Cell_Phone__c from Account WHERE Id = :userContact.AccountId];
            System.debug(LoggingLevel.INFO, '>>> USER ACCOUNT' + userAccount);

                this.sublocal = [SELECT Id from CVRSOS__Local__c where Id = :userAccount.Sublocal__c];
                this.sublocalId = sublocal.Id;
                System.debug(LoggingLevel.INFO, '>>> SUBLOCAL' + sublocal);
                System.debug(LoggingLevel.INFO, '>>> SUBLOCALID' + sublocalId);

    }

    public List<CVRSOS__LocalSteward__c> getStewards() {
        System.debug(LoggingLevel.INFO, '>>> getStewards');
        CVRSOS__LocalSteward__c[] stewardList = [
            SELECT  Id,
                CVRSOS__StewardName__c,
                Steward_Mobile_Phone__c,
                Steward_Preferred_Email__c,
                Steward_Worksite_Employer__c,
                Steward_Worksite__c,
                CVRSOS__ContactId__r.Title 
            FROM    CVRSOS__LocalSteward__c
            WHERE   ( CVRSOS__LocalId__c = :this.sublocalId)
            ORDER BY Steward_Worksite__c ASC, CVRSOS__StewardName__c ASC
        ];
        if(stewardList.size() > 0) {
            System.debug(LoggingLevel.INFO, '>>> stewardList' + stewardList);
            return stewardList;
        } else {
            System.debug(LoggingLevel.INFO, '>>> stewardList.size === 0');
            return null;
        }
         
    }
    
    public Account getUserAccount() {
        return userAccount;
    }
}