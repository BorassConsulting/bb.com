global class BatchPOC implements Database.Batchable<sObject> {
	
	String query = 'select Id, Name, Counter__c, Flag__c from BB_A__c order by Counter__c';
	
	global BatchPOC() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		List<BB_A__c> bbas = (List<BB_A__c>) scope;
		for(BB_A__c theBba : bbas){
			if(theBBa.Counter__c == 666){
				theBba.X__c = null; //it should throw an error
				theBba.Y__c = null; //it should throw an error
			}
			theBba.Flag__c = true;
		}
		update bbas;		
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}