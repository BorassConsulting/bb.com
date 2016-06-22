global virtual class WorkaroundFor200SOQLLimitInUT implements Database.Batchable<sObject>, Database.Stateful {
	
	public String query = 'SELECT id, Index__c from Batch_Step__c order by Index__c';	
	
	global WorkaroundFor200SOQLLimitInUT() {
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		Batch_Step__c theStepCount = new Batch_Step__c(
			Index__c = 0
		);		
		insert theStepCount; 
			
	//	step1();
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
	//	step2();
	}
	
	global void finish(Database.BatchableContext BC) {
	//	step3();
	}

	global virtual void step1(){

	}

	global virtual void step2(){

	}
	
	global virtual  void step3(){

	}

	global void initDatabase(){		
			//Database.executeBatch(this, 1);			
	}

}