global class CleanBatch implements Database.Batchable<sObject> {
	
	String query = 'select Id, Name, Counter__c, Flag__c from BB_A__c order by Counter__c';
	
	global CleanBatch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		List<BB_A__c> bbas = (List<BB_A__c>) scope;
		for(BB_A__c theBba : bbas){		
			theBba.Flag__c = false;
		}
		update bbas;
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}