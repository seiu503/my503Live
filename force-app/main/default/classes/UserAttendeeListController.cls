public with sharing class UserAttendeeListController {
	
    private final User user;
    private final Contact userContact;
    private final Id contactId;

    public UserAttendeeListController(ApexPages.StandardController stdController) {
        System.debug(LoggingLevel.INFO, '>>> UserAttendeeListController');
        this.user = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUSerId()];
         System.debug(LoggingLevel.INFO, '>>> USER' + user);
        this.userContact = [SELECT Id, Name, AccountId from Contact WHERE Id = :user.ContactId];
        this.contactId = userContact.ContactId;
       System.debug(LoggingLevel.INFO, '>>> USER CONTACT' + userContact);
       System.debug(LoggingLevel.INFO, '>>> CONTACT ID' + contactId);

    }

    public List<conference360__Attendee__c> getAttendees() {
        System.debug(LoggingLevel.INFO, '>>> getAttendees');
        conference360__Attendee__c[] attendeeList = [
            SELECT  Id,
                Accessibility_Needs__c,
                conference360__AttendeeLink_URL__c,
                Dietary_Allergies_Other_Restrictions__c,
                conference360__Contact__c,
                conference360__Dietary_Preference__c,
                Digital_Online_Learning_Accessibility__c,
                conference360__Email__c,
                conference360__Event__c,
                conference360__Event_Description__c,
                conference360__Event_Details__c,
                conference360__Event_Item__c,
                Event_Item_Public_Name__c,
                Event_Item_Short_Description__c,
                conference360__Event_Start_Date__c,
                conference360__Event_Start_Time__c,
                Lodging_ADA_Accessible_Room__c,
                Lodging_Check_In_Date__c,
                Lodging_Check_Out_Date__c,
                Lodging_Gender__c,
                Lodging_Needed__c,
                Lodging_Room_Type__c,
                Lodging_Roommate_Preference__c,
                Lodging_Specific_Accommodations_Needed__c,
                Lodging_Will_Share_With_Name__c,
                Lodging_Willing_to_Share__c,
                conference360__Phone__c,
                Materials_Accessibility__c,
                conference360__Registration_Status__c,
                Shirt_Jacket_Size__c,
                Simultaneous_Translation__c,
                conference360__Venue_City__c,
                conference360__Venue_Name__c,
                conference360__Venue_Postal_Code__c,
                conference360__Venue_State_Province__c,
                conference360__Venue_Street__c,
                Written_Materials_Translation__c
            FROM    conference360__Attendee__c
            WHERE   (conference360__Registration_Status__c = 'Registered' AND  conference360__Event__r.conference360__Status__c = 'Active' AND conference360__Event_Start_Date__c >= :Date.Today() AND conference360__Contact__c = :this.contactId)
            ORDER BY conference360__Event_Start_Date__c DESC
        ];
        if(attendeeList.size() > 0) {
            System.debug(LoggingLevel.INFO, '>>> attendeeList' + attendeeList);
            return attendeeList;
        } else {
            System.debug(LoggingLevel.INFO, '>>> attendeeList.size === 0');
            return null;
        }
         
    }

}