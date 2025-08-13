@IsTest
private class CaseAssignmentHandlerTest {
    @IsTest
    static void testAutoAssign() {
        // Create a mock Case record
        Case testCase = new Case(
            Subject = 'Test Case',
            Priority = 'High',
            Requires_Tech_Support__c = true
        );
        insert testCase;

        Test.startTest();
        CaseAssignmentHandler.autoAssign(new List<Case>{testCase});
        Test.stopTest();

        Case updated = [SELECT OwnerId FROM Case WHERE Id = :testCase.Id];
        System.assertNotEquals(null, updated.OwnerId);
    }
}