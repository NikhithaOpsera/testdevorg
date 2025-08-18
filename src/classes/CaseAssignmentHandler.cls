public with sharing class CaseAssignmentHandler {
    // Internal flag for test mode
    // testing git to git
    public static Boolean isTestMode = false;

    public static void autoAssign(List<Case> cases) {
        // Bypass feature check if test mode is enabled
        if (!isTestMode && !FeatureManagement.checkPermission('Tech_Support_Access')) return;

        Id techQueueId = [SELECT Id FROM Group WHERE Name = 'Tech Support Queue' LIMIT 1].Id;

        for (Case c : cases) {
            if (c.Priority == 'High' && c.Requires_Tech_Support__c) {
                c.OwnerId = techQueueId;
            }
        }
    }
}