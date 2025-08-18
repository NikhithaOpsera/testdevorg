@IsTest
private class CaseAssignmentHandlerTest {
    @IsTest
    static void testAutoAssign_AssignsCase() {
        CaseAssignmentHandler.isTestMode = true;

        // Create the required public queue
        Group techQueue = new Group(Name = 'Tech Support Queue', Type = 'Queue');
        insert techQueue;

        // Create a matching case
        Case testCase = new Case(
            Subject = 'High Priority',
            Priority = 'High',
            Requires_Tech_Support__c = true
        );
        insert testCase;

        Test.startTest();
        CaseAssignmentHandler.autoAssign(new List<Case>{testCase});
        Test.stopTest();

        Case updated = [SELECT OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertEquals(techQueue.Id, updated.OwnerId, 'Owner should be set to Tech Support Queue');
    }

    @IsTest
    static void testAutoAssign_DoesNotAssignIfPriorityLow() {
        CaseAssignmentHandler.isTestMode = true;

        Group techQueue = new Group(Name = 'Tech Support Queue', Type = 'Queue');
        insert techQueue;

        Case testCase = new Case(
            Subject = 'Low Priority',
            Priority = 'Low',
            Requires_Tech_Support__c = true
        );
        insert testCase;

        Id originalOwnerId = testCase.OwnerId;

        Test.startTest();
        CaseAssignmentHandler.autoAssign(new List<Case>{testCase});
        Test.stopTest();

        Case result = [SELECT OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertEquals(originalOwnerId, result.OwnerId, 'Owner should not change for low priority');
    }

    @IsTest
    static void testAutoAssign_DoesNotAssignIfSupportNotRequired() {
        CaseAssignmentHandler.isTestMode = true;

        Group techQueue = new Group(Name = 'Tech Support Queue', Type = 'Queue');
        insert techQueue;

        Case testCase = new Case(
            Subject = 'Support Not Required',
            Priority = 'High',
            Requires_Tech_Support__c = false
        );
        insert testCase;

        Id originalOwnerId = testCase.OwnerId;

        Test.startTest();
        CaseAssignmentHandler.autoAssign(new List<Case>{testCase});
        Test.stopTest();

        Case result = [SELECT OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertEquals(originalOwnerId, result.OwnerId, 'Owner should not change if support not required');
    }

    @IsTest
    static void testAutoAssign_ExitsIfPermissionDisabled() {
        // Leave test mode off — this tests the real permission check path
        Case testCase = new Case(
            Subject = 'Permission Disabled',
            Priority = 'High',
            Requires_Tech_Support__c = true
        );
        insert testCase;

        Id originalOwnerId = testCase.OwnerId;

        Test.startTest();
        CaseAssignmentHandler.autoAssign(new List<Case>{testCase});
        Test.stopTest();

        Case result = [SELECT OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertEquals(originalOwnerId, result.OwnerId, 'Owner should not change if permission not granted');
    }
}