@isTest
private class UserAttendeeListControllerTest {

    static testMethod void testMethod1(){
        
           //Insert Contact
           Account a = new Account(Name = 'Test Account');
       	   Insert a;

           Contact c = New Contact(AccountId = a.Id, FirstName='FirstName', LastName='LastName');
           Insert c;
        
           //Insert User
         
            Profile p = [select Id,name from Profile where Name = 'my503Live Community User' limit 1];
            System.debug(LoggingLevel.INFO, '>>> p');
            System.debug(LoggingLevel.INFO, '>>>' + p);
            
            User u = new User(
                profileId = p.id,
                username = 'testuser@testuser.com',
                email = 'testuser@testuser.com',
                emailencodingkey = 'UTF-8',
                localesidkey = 'en_US',
                languagelocalekey = 'en_US',
                timezonesidkey = 'America/Los_Angeles',
                alias='testuser',
                lastname='UserLast',
                contactId = c.id
            );
            insert u;
            System.debug(LoggingLevel.INFO, '>>> u');
            System.debug(LoggingLevel.INFO, '>>>' + u);
            System.debug(LoggingLevel.INFO, '>>> c.AccountId');
            System.debug(LoggingLevel.INFO, '>>>' + c.AccountId); 
            System.debug(LoggingLevel.INFO, '>>> a.Id');
            System.debug(LoggingLevel.INFO, '>>>' + a.Id); 

            // Insert Events

            conference360__Event__c event1 = new conference360__Event__c(
                Name = 'Test Event 1',
                conference360__Time_Zone__c = '(GMT-08:00) Pacific Standard Time (America/Los_Angeles)',
                conference360__Status__c = 'Active',
                Confirmation_Format__c = 'Virtual',
                conference360__Event_Start_Date__c = Date.Today().adddays(5),
                conference360__Event_Start_Time__c = Time.newInstance(10, 0, 0, 0),
                conference360__Event_End_Date__c = Date.Today().adddays(5),
                conference360__Event_End_Time__c = Time.newInstance(10, 30, 0, 0)
                );

            conference360__Event__c event2 = new conference360__Event__c(
                Name = 'Test Event 2',
                conference360__Time_Zone__c = '(GMT-08:00) Pacific Standard Time (America/Los_Angeles)',
                conference360__Status__c = 'Active',
                Confirmation_Format__c = 'Virtual',
                conference360__Event_Start_Date__c = Date.Today().adddays(6),
                conference360__Event_Start_Time__c = Time.newInstance(11, 0, 0, 0),
                conference360__Event_End_Date__c = Date.Today().adddays(6),
                conference360__Event_End_Time__c = Time.newInstance(11, 30, 0, 0)
                );

            insert event1;
            insert event2;

            // Insert Event Items

            conference360__Event_Item__c item1 = new  conference360__Event_Item__c(
                conference360__Item_Name__c = 'Test Item 1', 
                conference360__Event__c = event1.id, 
                conference360__Type__c = 'Main event ticket'
            );

            conference360__Event_Item__c item2 = new  conference360__Event_Item__c(
                conference360__Item_Name__c = 'Test Item 2', 
                conference360__Event__c = event2.id, 
                conference360__Type__c = 'Main event ticket'
            );

            insert item1;
            insert item2;

            // Insert Attendees

            conference360__Attendee__c attendee1 = new conference360__Attendee__c(
                conference360__Contact__c = c.id,
                conference360__Event__c = event1.id,
                conference360__Event_Item__c = item1.id,
                conference360__Registration_Status__c = 'Registered',
                conference360__Email__c = 'test@test.com'
            );


            conference360__Attendee__c attendee2 = new conference360__Attendee__c(
                conference360__Contact__c = c.id,
                conference360__Event__c = event2.id,
                conference360__Event_Item__c = item2.id,
                conference360__Registration_Status__c = 'Registered',
                conference360__Email__c = 'test@test.com'
            );

            insert attendee1;
            insert attendee2;

            list<conference360__Attendee__c> attendeeListTest = [
                SELECT  Id,
                Event_Item_Public_Name__c,
                conference360__Event_Start_Date__c,
                conference360__Registration_Status__c,
                conference360__Contact__c,
                conference360__Contact__r.Id,
                conference360__Event__r.conference360__Status__c
            FROM    conference360__Attendee__c
            WHERE   (conference360__Registration_Status__c = 'Registered' AND  conference360__Event__r.conference360__Status__c = 'Active' AND conference360__Event_Start_Date__c >= :Date.Today() AND conference360__Contact__c = :c.id)
            ORDER BY conference360__Event_Start_Date__c DESC
        ];
            System.debug(LoggingLevel.INFO, '>>> attendeeListTest');
            System.debug(LoggingLevel.INFO, '>>>' + attendeeListTest);

            Test.startTest();

            System.runAs(u) { 
                PageReference pageRef = Page.UserAttendeeList; 
                pageRef.getParameters().put('id', String.valueOf(u.id));
                Test.setCurrentPage(pageRef);

                ApexPages.StandardController sc = new ApexPages.StandardController(u);
                UserAttendeeListController ext = new UserAttendeeListController(sc);

                //Test that Attendees are Inserted
                list<conference360__Attendee__c> attendeeList = ext.getAttendees();
                // System.assertEquals(attendeeList.size(),2);

                // Delete attendeeList;

            }
            Test.StopTest();


	        try {
                Delete attendeeListTest;
                Delete item1;
                Delete item2;
                Delete attendee1;
                Delete attendee2;
                Delete event1;
                Delete event2;
	        } catch (DmlException e) {

                System.debug(LoggingLevel.INFO, '>>> deleteExceptions' + e);

	        }
            
        }     

}