public with sharing class StewardListController {

    private final CVRSOS__Local__c sublocal;

    public StewardListController(ApexPages.StandardController stdController) {
        this.sublocal = (CVRSOS__Local__c)stdController.getRecord();
    }

    public List<CVRSOS__LocalSteward__c> getStewards() {
        return [
            SELECT  Id,
                CVRSOS__StewardName__c,
                Steward_Best_Phone__c,
                Steward_Preferred_Email__c,
                Steward_Worksite_Employer__c,
                Steward_Worksite__c
            FROM    CVRSOS__LocalSteward__c
            WHERE   ( CVRSOS__LocalId__c = :sublocal.id AND CVRSOS__Active__c = True)
        ];
    }
}