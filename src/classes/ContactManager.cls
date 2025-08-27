public with sharing class ContactManager {
    
    // Method to get contacts by Account Id
    public static List<Contact> getContactsByAccountId(Id accountId) {
        if (accountId == null) {
            throw new IllegalArgumentException('Account Id cannot be null');
        }
        
        return [
            SELECT Id, FirstName, LastName, Email, AccountId 
            FROM Contact 
            WHERE AccountId = :accountId
        ];
    }
}