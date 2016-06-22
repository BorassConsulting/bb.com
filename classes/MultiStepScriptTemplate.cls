/*
	This is a Prove of concept that you can use batches when you executes scripts during creation on data on refreshed sandbox
	Author Bartosz Borowiec 
*/
global abstract class MultiStepScriptTemplate  implements Database.Batchable<sObject>, Database.Stateful {
	
	global abstract class ScriptStep{
		global MultiStepScriptTemplate caller { get; set;}			
		global abstract void executeStep();		
	}
	
	private final String query = 'SELECT id, Index__c from Batch_Step__c order by Index__c';
	private final List<ScriptStep> scriptSteps;

	global abstract List<ScriptStep> initScriptSteps();
	
	protected MultiStepScriptTemplate() {
		// gets script steps
		scriptSteps = initScriptSteps();
		// bind these steps with caller. Because of this trick steps of scrip can share variables. 
		for(ScriptStep theScriptStep : scriptSteps){
			theScriptStep.caller = this;
		}			
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		List<Batch_Step__c> stepCounts = Database.query( query );
		if( StepCounts.size() != 100){
			if( stepCounts.size() > 0 ){
				delete stepCounts;
				Database.EmptyRecycleBin( stepCounts );
			}
			stepCounts = new List<Batch_Step__c>();
			for(Integer i = 0; i < 100; i++){
				Batch_Step__c theStepCount = new Batch_Step__c(
					Index__c = i
				);
				stepCounts.add( theStepCount );
			}
			insert stepCounts; 
		}
		return Database.getQueryLocator(query + ' limit ' + scriptSteps.size() );
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
   		Batch_Step__c theBatchStep = ( Batch_Step__c )scope[ 0 ];
   		Integer stepNumber = theBatchStep.Index__c.intValue();		
		ScriptStep theScriptStep  = scriptSteps[ stepNumber];
		theScriptStep.executeStep();
	}
	
	global void finish(Database.BatchableContext BC) {
		List<Batch_Step__c> stepCounts = Database.query( query );
		delete stepCounts;
		Database.EmptyRecycleBin( stepCounts );	
	}
	// method that is used to start script 
	global void startScript(){		
		Id batchId = Database.executeBatch(this, 1);
		System.debug('Multi Batch Id:' + batchId);
	}
	
}