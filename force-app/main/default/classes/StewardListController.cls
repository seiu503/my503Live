public with sharing class StewardListController {

    private final CVRSOS__Local__c sublocal;

    public StewardListController(ApexPages.StandardController stdController) {
        this.sublocal = (CVRSOS__Local__c)stdController.getRecord();
        system.debug(LoggingLevel.INFO, '>>> sublocal:');
        system.debug(LoggingLevel.INFO, this.sublocal.Name);
    }

    public List<CVRSOS__LocalSteward__c> getStewards() {
        System.debug(LoggingLevel.INFO, '>>> getStewards');
        CVRSOS__LocalSteward__c[] stewardList = [
            SELECT  Id,
                CVRSOS__StewardName__c,
                Steward_Best_Phone__c,
                Steward_Preferred_Email__c,
                Steward_Worksite_Employer__c,
                Steward_Worksite__c
            FROM    CVRSOS__LocalSteward__c
            WHERE   ( CVRSOS__LocalId__c = :sublocal.id AND CVRSOS__Active__c = True)
        ];
        if(stewardList.size() > 0) {
            System.debug(LoggingLevel.INFO, '>>> stewardList' + stewardList);
            return stewardList;
        } else {
            System.debug(LoggingLevel.INFO, '>>> stewardList.size === 0');
            return null;
        }
    }
}