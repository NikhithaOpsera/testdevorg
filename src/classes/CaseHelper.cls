public with sharing class CaseHelper {
    
    /**
     * Gets the subjects of all open high-priority cases.
     * @return List of case subjects.
     */
    public static List<String> getOpenHighPriorityCaseSubjects() {
        List<Case> highPriorityCases = [
            SELECT Id, Subject
            FROM Case
            WHERE Status != 'Closed' AND Priority = 'High'
        ];

        List<String> subjects = new List<String>();
        for (Case c : highPriorityCases) {
            subjects.add(c.Subject);
        }
        return subjects;
    }
}