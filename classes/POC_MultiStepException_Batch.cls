global class POC_MultiStepException_Batch implements Database.Batchable<sObject> {
	
	String query = 'SELECT id, Index__c from Batch_Step__c order by Index__c';	
	
	global POC_MultiStepException_Batch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		
		return Database.getQueryLocator( query );
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
	
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}