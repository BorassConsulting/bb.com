global class ProducerBatch implements Database.Batchable<sObject>, Database.Stateful {
	String query = 'SELECT id, Index__c from Batch_Step__c order by Index__c';	
	public Integer counter = 10; // some initial value

	global ProducerBatch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		counter ++; // counter should be 11 after this line
		BB_C__c bbc = new BB_C__c(
				Name = 'start',
				X__c =  String.valueOf( counter ) 
			); 		
		insert bbc;	
		return Database.getQueryLocator( query );
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		counter ++; // counter should be 12 after this line
		BB_C__c bbc = new BB_C__c(
				Name = 'execute',
				X__c =  String.valueOf( counter ) 
			); 		
		insert bbc;
	}
	
	global void finish(Database.BatchableContext BC) {
		counter ++; // counter should be 13 after this line
		BB_C__c bbc = new BB_C__c(
				Name = 'finish',
				X__c =  String.valueOf( counter ) 
			); 		
		insert bbc;
	}
	
}