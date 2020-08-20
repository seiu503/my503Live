public with sharing class UserAttendeeListController {
	
    private final User user;

    public UserAttendeeListController(ApexPages.StandardController stdController) {
        System.debug(LoggingLevel.INFO, '>>> UserAttendeeListController');
        this.user = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUserId()];
        System.debug(LoggingLevel.INFO, '>>> USER' + user);
        System.debug(LoggingLevel.INFO, '>>> CONTACT ID (this.user.contactId) ' + this.user.contactId);

    }

    public List<conference360__Attendee__c> getAttendees() {
        System.debug(LoggingLevel.INFO, '>>> getAttendees');
        list<conference360__Attendee__c> attendeeList = [
                SELECT  Id,
                Event_Item_Public_Name__c,
                conference360__Event_Start_Date__c,
                conference360__Registration_Status__c,
                conference360__Contact__c,
                conference360__Contact__r.Id,
                conference360__Event__r.conference360__Status__c
            FROM    conference360__Attendee__c
            WHERE   (
                    conference360__Registration_Status__c = 'Registered' AND  
                    conference360__Event__r.conference360__Status__c = 'Active' AND 
                    conference360__Event_Start_Date__c >= :Date.Today() AND 
                    conference360__Contact__c = :this.user.contactId
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