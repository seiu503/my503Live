public with sharing class UserAttendeeListController {
	
    private final User user;
    private final Contact userContact;
    // private final Id contactId;

    public UserAttendeeListController(ApexPages.StandardController stdController) {
        System.debug(LoggingLevel.INFO, '>>> UserAttendeeListController');
        this.user = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUSerId()];
         System.debug(LoggingLevel.INFO, '>>> USER' + user);
        this.userContact = [SELECT Id, Name, AccountId from Contact WHERE Id = :user.ContactId];
        // this.contactId = this.user.ContactId;
       System.debug(LoggingLevel.INFO, '>>> USER CONTACT ' + userContact);
       System.debug(LoggingLevel.INFO, '>>> CONTACT ID (this.user.contactId) ' + this.user.contactId);

    }

    public List<conference360__Attendee__c> getAttendees() {
        System.debug(LoggingLevel.INFO, '>>> getAttendees');
        conference360__Attendee__c[] attendeeList = [
            SELECT  Id,
                Event_Item_Public_Name__c,
                conference360__Event_Start_Date__c,
                conference360__Registration_Status__c,
                conference360__Contact__c,
                conference360__Contact__r.Id
            FROM    conference360__Attendee__c
            WHERE   (
                conference360__Contact__c = :this.user.ContactId OR 
                conference360__Contact__r.Id = :this.user.ContactId OR 
                conference360__Contact__c = :this.userContact.Id OR 
                conference360__Contact__r.Id = :this.userContact.Id
                )
            ORDER BY conference360__Event_Start_Date__c DESC
        ];
        if(attendeeList.size() > 0) {
            System.debug(LoggingLevel.INFO, '>>> attendeeList' + attendeeList);
            return attendeeList;
        } else {
            System.debug(LoggingLevel.INFO, '>>> attendeeList.size === 0');
            System.debug(LoggingLevel.INFO, '>>> attendeeList' + attendeeList);
            return null;
        }
         
    }

}