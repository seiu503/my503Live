public with sharing class UserCaseListController {
	
    private final User user;
    private final Contact userContact;

    public UserCaseListController(ApexPages.StandardController stdController) {
        System.debug(LoggingLevel.INFO, '>>> UserCaseListController');
        this.user = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUSerId()];
         System.debug(LoggingLevel.INFO, '>>> USER' + user);
        this.userContact = [SELECT Id, Name, AccountId from Contact WHERE Id = :user.ContactId];
       System.debug(LoggingLevel.INFO, '>>> USER CONTACT' + userContact);

    }

    public List<Case> getCases() {
        System.debug(LoggingLevel.INFO, '>>> getCases');
        Case[] caseList = [
            SELECT  Id,
                CaseNumber,
                CreatedDate,
                Subject,
                CreatedById,
                Status 
            FROM    Case
            WHERE   ( CreatedById = :this.user.Id)
            ORDER BY CreatedDate DESC
        ];
        if(caseList.size() > 0) {
            System.debug(LoggingLevel.INFO, '>>> caseList' + caseList);
            return caseList;
        } else {
            System.debug(LoggingLevel.INFO, '>>> caseList.size === 0');
            return null;
        }
         
    }
    
}