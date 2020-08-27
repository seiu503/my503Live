public without sharing class UserAttendeeListController {
	
    private final User user;
    private final Contact userContact;
    private final Id contactId;

    public UserAttendeeListController(ApexPages.StandardController stdController) {
        System.debug(LoggingLevel.INFO, '>>> UserAttendeeListController');
        this.user = [SELECT Id, ContactId, Full_Name__c FROM User WHERE Id = :UserInfo.getUserId()];
        this.userContact = [SELECT Id, Name from Contact WHERE Id = :user.ContactId];
        this.contactId = this.userContact.Id;
        System.debug(LoggingLevel.INFO, '>>> USER' + user);
        System.debug(LoggingLevel.INFO, '>>> CONTACT ID (this.user.contactId) ' + this.user.contactId);
        System.debug(LoggingLevel.INFO, '>>> CONTACT ID (this.contactId) ' + this.contactId);

    }

    public List<conference360__Attendee__c> getAttendees() {
        System.debug(LoggingLevel.INFO, '>>> getAttendees');
        List<conference360__Attendee__c> attendeeList = [
                SELECT  Id,
                conference360__Event_Name__c,
                conference360__Event_Start_Date__c,
                conference360__Registration_Status__c,
                conference360__Contact__c,
                conference360__Event__r.conference360__Status__c,
                conference360__AttendeeLink__c
            FROM    conference360__Attendee__c
            WHERE   (
                    conference360__Contact__c = :this.contactId AND conference360__Registration_Status__c = 'Registered'
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