trigger OpportunityUpsertTrigger on Opportunity (after update){
  Set<Id> setIds = new Set<Id>();

  for(Opportunity opportunity : Trigger.New) {
    if(opportunity.StageName == 'Closed Won') {
        setIds.add(opportunity.AccountId);
    }   
  }

  List<Id> listIds = new List<Id>(setIds);

  Map<Id, Account> accountsMap = new Map<Id, Account>();

  for(Account account: [SELECT Id, Name, Closed_Opportunities__c, Closed_Opportunities_Total_Amount__c 
                        FROM Account WHERE Id IN :listIds]) {
    accountsMap.put(account.Id, account);
  }

  for(Opportunity opportunity : Trigger.New) {
    if(opportunity.StageName == 'Closed Won') {
      Account account = accountsMap.get(opportunity.AccountId);
      account.Closed_Opportunities__c += 1;
      account.Closed_Opportunities_Total_Amount__c += opportunity.Amount;
    }   
  }

  upsert new List<Account>(accountsMap.values());
}