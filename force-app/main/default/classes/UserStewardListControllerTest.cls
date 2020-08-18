@isTest
private class UserStewardListControllerTest {

    static testMethod void testMethod1(){
            //Insert SubLocal Record 
            CVRSOS__Local__c s = new CVRSOS__Local__c(Division__c='Care Providers');
            list<CVRSOS__Local__c> sublocalList = new list<CVRSOS__Local__c>();
            sublocalList.add(s);
            insert sublocalList;

            Id sublocalId = sublocalList[0].Id;
        
           //Insert Contacts
           Account a = new Account(Name = 'Test Account', Sublocal__c = sublocalId);
       	   Insert a;

           Contact c1 = New Contact(AccountId = a.Id, FirstName='FirstName1', LastName='LastName1', Is_Steward__c = 'C');
           Contact c2 = New Contact(AccountId = a.Id, FirstName='FirstName2', LastName='LastName2', Is_Steward__c = 'S');
           Contact c3 = New Contact(AccountId = a.Id, FirstName='UserFirst', LastName='UserLast');
           Insert c1;
           Insert c2;
           Insert c3;
        
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
                contactId = c3.id
            );
            insert u;
            System.debug(LoggingLevel.INFO, '>>> u');
            System.debug(LoggingLevel.INFO, '>>>' + u);
            System.debug(LoggingLevel.INFO, '>>> c3.AccountId');
            System.debug(LoggingLevel.INFO, '>>>' + c3.AccountId); 
            System.debug(LoggingLevel.INFO, '>>> a.Id');
            System.debug(LoggingLevel.INFO, '>>>' + a.Id); 

            // Insert Stewards -- this is required in production but doesn't work in sandbox as of July 2020 because of changes
            // to steward creation processes made in production between Feb & July 2020

            CVRSOS__LocalSteward__c st1 = new CVRSOS__LocalSteward__c(	CVRSOS__ContactId__c = c1.Id, CVRSOS__LocalId__c = sublocalId);
            CVRSOS__LocalSteward__c st2 = new CVRSOS__LocalSteward__c(	CVRSOS__ContactId__c = c2.Id, CVRSOS__LocalId__c = sublocalId);
            list<CVRSOS__LocalSteward__c> stewardList = new list<CVRSOS__LocalSteward__c>();
            stewardList.add(st1);
            stewardList.add(st2);
            insert stewardList;

            list<CVRSOS__LocalSteward__c> stewListTest = [
                SELECT  Id,
                    CVRSOS__StewardName__c,
                    Steward_Mobile_Phone__c,
                    Steward_Preferred_Email__c,
                    Steward_Worksite_Employer__c,
                    Steward_Worksite__c,
                    Active_Auto__c,
                    C_S__c,
                    CVRSOS__ContactId__r.Account.Id,
                    CVRSOS__ContactId__r.Title 
                FROM    CVRSOS__LocalSteward__c
                WHERE   (Active_Auto__c = TRUE AND CVRSOS__ContactId__r.Account.Id = :a.Id)
                // WHERE   Active_Auto__c = TRUE
                // WHERE   (CVRSOS__ContactId__r.Account.Id = :a.Id)
            ];
            System.debug(LoggingLevel.INFO, '>>> stewListTest');
            System.debug(LoggingLevel.INFO, '>>>' + stewListTest);

            Test.startTest();

            System.runAs(u) { 
                PageReference pageRef = Page.UserContactSublocalStewardList; 
                pageRef.getParameters().put('id', String.valueOf(sublocalId));
                Test.setCurrentPage(pageRef);

                ApexPages.StandardController sc = new ApexPages.StandardController(u);
                UserStewardListController ext = new UserStewardListController(sc);

                //Test that Stewards are Inserted
                list<CVRSOS__LocalSteward__c> stewList = ext.getStewards();
                list<CVRSOS__LocalSteward__c> chiefStewList = ext.getChiefStewards();
                System.assertEquals(stewList.size(),2);
                System.assertEquals(chiefStewList.size(),1);

            }
            Test.StopTest();


	        try {

                Delete stewardList;
                Delete stewListTest;
                Delete c1;
                Delete c2;
                Delete c3;
                Delete a;

	        } catch (DmlException e) {

                System.debug(LoggingLevel.INFO, '>>> deleteExceptions' + e);

	        }
            
        }     

}