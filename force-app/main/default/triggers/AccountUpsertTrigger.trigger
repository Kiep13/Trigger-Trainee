trigger AccountUpsertTrigger on Account (after update) {

  if(AccountTriggerChecking.checkIsFirst()) {
    Set<Id> setIds = new Set<Id>();

    for(Account account : Trigger.New) {
      setIds.add(account.Id);
    }
  
    List<Id> listIds = new List<Id>(setIds);
  
    List<Account> accounts = [SELECT Id, Name, Fax, (SELECT Id, Name, Fax FROM Contacts) FROM Account WHERE Id IN :listIds];
  
    List<Contact> contacts = new List<Contact>();
  
    for (Account account : accounts) {
      for(Contact contact: account.Contacts) {
        contact.Fax = account.Fax;
        contacts.add(contact);
      }
    }
  
    System.debug('Account trigger called');
  
    upsert contacts;
  }
}