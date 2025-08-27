@isTest
private class ContactManagerTest {

    @isTest
    static void testGetContactsByAccountId() {
        // Create test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create test Contacts
        Contact contact1 = new Contact(
            FirstName = 'John', 
            LastName = 'Doe', 
            Email = 'john@example.com', 
            AccountId = testAccount.Id
        );
        
        Contact contact2 = new Contact(
            FirstName = 'Jane', 
            LastName = 'Smith', 
            Email = 'jane@example.com', 
            AccountId = testAccount.Id
        );
        
        insert new List<Contact>{contact1, contact2};

        // Call the method and verify results
        List<Contact> contacts = ContactManager.getContactsByAccountId(testAccount.Id);
        
        System.assertEquals(
            2, 
            contacts.size(), 
            'Expected 2 contacts to be returned for the test account.'
        );

        System.assertEquals(
            testAccount.Id, 
            contacts[0].AccountId, 
            'First contact should be associated with the test account.'
        );
    }

    @isTest
    static void testGetContactsWithNullAccountId() {
        try {
            ContactManager.getContactsByAccountId(null);
            System.assert(false, 'Expected exception was not thrown for null AccountId.');
        } catch (IllegalArgumentException e) {
            System.assertEquals(
                'Account Id cannot be null', 
                e.getMessage(), 
                'Exception message did not match the expected value.'
            );
        }
    }
}