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
                conference360__Event_Start_Time__c = TIMEVALUE('10:00:00.000'),
                conference360__Event_End_Date__c = Date.Today().adddays(5),
                conference360__Event_End_Time__c = TIMEVALUE('10:30:00.000')
                );

            conference360__Event__c event2 = new conference360__Event__c(
                Name = 'Test Event 2',
                conference360__Time_Zone__c = '(GMT-08:00) Pacific Standard Time (America/Los_Angeles)',
                conference360__Status__c = 'Active',
                Confirmation_Format__c = 'Virtual',
                conference360__Event_Start_Date__c = Date.Today().adddays(6),
                conference360__Event_Start_Time__c = TIMEVALUE('11:00:00.000'),
                conference360__Event_End_Date__c = Date.Today().adddays(6),
                conference360__Event_End_Time__c = TIMEVALUE('11:30:00.000')
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

            // Insert Attendees

            conference360__Attendee__c attendee1 = new conference360__Attendee__c(
                Accessibility_Needs__c = 'test',
                conference360__AttendeeLink_URL__c = 'http://seiu503.org',
                Dietary_Allergies_Other_Restrictions__c = 'test',
                conference360__Contact__c = c.id,
                conference360__Dietary_Preference__c = 'None',
                Digital_Online_Learning_Accessibility__c = 'I require accommodations and/or am unable to use Zoom',
                conference360__Email__c = 'test@test.com',
                conference360__Event__c = event1.id,
                conference360__Event_Description__c = 'test description',
                conference360__Event_Item__c = item1.id,
                Lodging_ADA_Accessible_Room__c = 'Yes',
                Lodging_Check_In_Date__c = Date.Today().adddays(5),
                Lodging_Check_Out_Date__c = Date.Today().adddays(6),
                Lodging_Gender__c = 'Female',
                Lodging_Needed__c = 'Yes',
                Lodging_Room_Type__c = '1 Bed',
                Lodging_Roommate_Preference__c = 'Please Assign Me a Roommate',
                Lodging_Specific_Accommodations_Needed__c = 'test',
                Lodging_Will_Share_With_Name__c = 'test',
                Lodging_Willing_to_Share__c = 'YES -- I\'ll share with an SEIU member or staff',
                conference360__Phone__c = '123-456-7890',
                Materials_Accessibility__c = 'I will receive materials digitally/online',
                conference360__Registration_Status__c = 'Registered',
                Shirt_Jacket_Size__c = 'Fitted M',
                Simultaneous_Translation__c = 'Spanish',
                Written_Materials_Translation__c = 'Spanish'
            );


            conference360__Attendee__c attendee2 = new conference360__Attendee__c(
                Accessibility_Needs__c = 'test',
                conference360__AttendeeLink_URL__c = 'http://seiu503.org',
                Dietary_Allergies_Other_Restrictions__c = 'test',
                conference360__Contact__c = c.id,
                conference360__Dietary_Preference__c = 'None',
                Digital_Online_Learning_Accessibility__c = 'I require accommodations and/or am unable to use Zoom',
                conference360__Email__c = 'test@test.com',
                conference360__Event__c = event2.id,
                conference360__Event_Description__c = 'test description',
                conference360__Event_Item__c = item1.id,
                Lodging_ADA_Accessible_Room__c = 'Yes',
                Lodging_Check_In_Date__c = Date.Today().adddays(6),
                Lodging_Check_Out_Date__c = Date.Today().adddays(7),
                Lodging_Gender__c = 'Female',
                Lodging_Needed__c = 'Yes',
                Lodging_Room_Type__c = '1 Bed',
                Lodging_Roommate_Preference__c = 'Please Assign Me a Roommate',
                Lodging_Specific_Accommodations_Needed__c = 'test',
                Lodging_Will_Share_With_Name__c = 'test',
                Lodging_Willing_to_Share__c = 'YES -- I\'ll share with an SEIU member or staff',
                conference360__Phone__c = '123-456-7890',
                Materials_Accessibility__c = 'I will receive materials digitally/online',
                conference360__Registration_Status__c = 'Registered',
                Shirt_Jacket_Size__c = 'Fitted M',
                Simultaneous_Translation__c = 'Spanish',
                Written_Materials_Translation__c = 'Spanish'
            );

            insert attendee1;
            insert attendee2;

            list<conference360__Attendee__c> attendeeListTest = [
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
            System.debug(LoggingLevel.INFO, '>>> attendeeListTest');
            System.debug(LoggingLevel.INFO, '>>>' + attendeeListTest);

            Test.startTest();

            System.runAs(u) { 
                PageReference pageRef = Page.UserAttendeeList; 
                pageRef.getParameters().put('id', String.valueOf(contactId));
                Test.setCurrentPage(pageRef);

                ApexPages.StandardController sc = new ApexPages.StandardController(u);
                UserAttendeeListController ext = new UserAttendeeListController(sc);

                //Test that Attendees are Inserted
                list<conference360__Attendee__c> attendeeList = ext.getAttendees();
                System.assertEquals(attendeeList.size(),2);

            }
            Test.StopTest();


	        try {

                Delete attendeeList;
                Delete attendeeListTest;
                Delete c;
                Delete event1;
                Delete event2;
                Delete item1;
                Delete item2;
                Delete attendee1;
                Delete attendee2;

	        } catch (DmlException e) {

                System.debug(LoggingLevel.INFO, '>>> deleteExceptions' + e);

	        }
            
        }     

}