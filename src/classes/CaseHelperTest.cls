@isTest
private class CaseHelperTest {

    @isTest
    static void testGetOpenHighPriorityCaseSubjects() {
        // Create test data
        Case case1 = new Case(Subject = 'High priority issue', Priority = 'High', Status = 'New');
        Case case2 = new Case(Subject = 'Another high case', Priority = 'High', Status = 'In Progress');
        Case case3 = new Case(Subject = 'Closed case', Priority = 'High', Status = 'Closed');
        Case case4 = new Case(Subject = 'Low priority case', Priority = 'Low', Status = 'New');
        insert new List<Case>{case1, case2, case3, case4};

        // Call the method
        List<String> results = CaseHelper.getOpenHighPriorityCaseSubjects();

        // Assertions
        System.assertEquals(2, results.size(), 'Should return 2 open high-priority cases');
        System.assert(results.contains('High priority issue'));
        System.assert(results.contains('Another high case'));
    }
}