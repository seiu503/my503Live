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

           Contact c1 = New Contact(AccountId = a.Id, FirstName='FirstName1', LastName='LastName1');
           Contact c2 = New Contact(AccountId = a.Id, FirstName='FirstName2', LastName='LastName2');
           Contact c3 = New Contact(AccountId = a.Id, FirstName='UserFirst', LastName='UserLast');
           Insert c1;
           Insert c2;
           Insert c3;
        
           //Insert User
           
        //    User u = New User(Contact=c3);
         
            Profile p = [select Id,name from Profile where Name = 'my503Live Community User' limit 1];
            
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

            //Insert Stewards
            CVRSOS__LocalSteward__c st1 = new CVRSOS__LocalSteward__c(	CVRSOS__ContactId__c = c1.Id, CVRSOS__LocalId__c = sublocalId);
            CVRSOS__LocalSteward__c st2 = new CVRSOS__LocalSteward__c(	CVRSOS__ContactId__c = c2.Id, CVRSOS__LocalId__c = sublocalId);
            list<CVRSOS__LocalSteward__c> stewardList = new list<CVRSOS__LocalSteward__c>();
            stewardList.add(st1);
            stewardList.add(st2);
            insert stewardList;

            Test.StartTest(); 

            system.runAs(u){ 
                //code to be executed as this user

                PageReference pageRef = Page.UserContactSublocalStewardList; 
                pageRef.getParameters().put('id', String.valueOf(sublocalId));
                // pageRef.getParameters().put('id', String.valueOf(u.Id)); ????
                Test.setCurrentPage(pageRef);

                ApexPages.StandardController sc = new ApexPages.StandardController(u);
                UserStewardListController ext = new UserStewardListController(sc);

                //Test that Stewards are Inserted
                list<CVRSOS__LocalSteward__c> obj1 = ext.getStewards();
                // system.assertequals(obj1.size(),2);
                
                //Delete Records
                // delete sublocalList;
                // delete stewardList;
                
                //Test that Stewards are Deleted
                list<CVRSOS__LocalSteward__c> obj2 = ext.getStewards();
                // system.assertEquals(obj2.size(),0); 
            }

            Test.StopTest();
        }     

}