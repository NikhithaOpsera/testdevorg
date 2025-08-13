public with sharing class CaseAssignmentHandler {
    public static void autoAssign(List<Case> cases) {
        if (!FeatureManagement.checkPermission('Tech_Support_Access')) return;

        Id techQueueId = [SELECT Id FROM Group WHERE Name = 'Tech Support Queue' LIMIT 1].Id;

        for (Case c : cases) {
            if (c.Priority == 'High' && c.Requires_Tech_Support__c) {
                c.OwnerId = techQueueId;
            }
        }
    }
    //test PR validation
}