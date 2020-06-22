@isTest
private class UserCaseListControllerTest {

    static testMethod void testMethod1(){
        
           //Insert Contact
           Account a = new Account(Name = 'Test Account');
       	   Insert a;

           Contact ct = New Contact(AccountId = a.Id, FirstName='FirstName', LastName='LastName');
           Insert ct;

           //Insert Case 
           Case c = new Case(
              Status = 'New',
							ContactId = ct.Id,
							Origin = 'Web',
							Subject = 'Test'
        		);
        
           //Insert User
         
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
                contactId = ct.id
            );
            insert u;

            Test.StartTest(); 

            system.runAs(u){ 
                //code to be executed as this user

                PageReference pageRef = Page.UserCaseList; 
                pageRef.getParameters().put('id', String.valueOf(u.Id));

                Test.setCurrentPage(pageRef);

                ApexPages.StandardController sc = new ApexPages.StandardController(u);
                UserCaseListController ext = new UserCaseListController(sc);

                //Test that Case is Inserted
                list<Case> caseList = ext.getCases();
                system.assertequals(caseList.size(),1);
                
                //Delete Records
                delete caseList;
                
                //Test that Case is Deleted
                system.assertEquals(caseList.size(),0); 
            }

            Test.StopTest();
        }     

}