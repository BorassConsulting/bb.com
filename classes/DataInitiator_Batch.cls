abstract global class DataInitiator_Batch implements Database.Batchable<sObject>, Database.Stateful {
	
	String query = 'SELECT id, Index__c from Batch_Step__c order by Index__c';	
	
	global DataInitiator_Batch() {
		
	}
	
	global Database.QueryLocator start( Database.BatchableContext BC ) {		
		step1();	
		return Database.getQueryLocator( query );
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		step2();
	}
	
	global void finish(Database.BatchableContext BC) {
		step3();
	}

	virtual global void step1(){
		
	}

	virtual global void step2(){
		
	}

	virtual global void step3(){
	
	}	

	global void initData() {
		Batch_Step__c bs = new Batch_Step__c(
			Index__c = 1
		);
		insert bs;
		Database.executeBatch( this, 1 ); // batch size is 1	
	}

	
}