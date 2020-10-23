trigger ContactUpsertTrigger on Contact (after update) {

  if(ContactTriggerChecking.checkIsFirst()) {
    Set<Id> setIds = new Set<Id>();

    for(Contact contact : Trigger.New) {
      setIds.add(contact.AccountId);
    }

    List<Id> listIds = new List<Id>(setIds);

    Map<Id, Account> accountsMap = new Map<Id, Account>();

    for(Account account: [SELECT Id, Name, Closed_Opportunities__c, Closed_Opportunities_Total_Amount__c 
                          FROM Account WHERE Id IN :listIds]) {
      accountsMap.put(account.Id, account);
    }

    for(Contact contact : Trigger.New) {
      Account account = accountsMap.get(contact.AccountId);
      account.Fax = contact.Fax;
    }

    System.debug('Contact trigger called');

    upsert new List<Account>(accountsMap.values());
  } 
}