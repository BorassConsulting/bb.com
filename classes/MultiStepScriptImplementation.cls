/*
	This is a Prove of concept that you can use batches when you executes scripts during creation on data on refreshed sandbox
	Author Bartosz Borowiec 
*/
global class MultiStepScriptImplementation  extends MultiStepScriptTemplate{
	
	// public variable. These variables can be shared by many steps of script
	public String stepUniqueId = 'theStep1';

	// one step of script ( can have 200 of SOQLs and 150 DMLs ). In this examle we have only 3 steps, but there are no limits
	global class Step1 extends MultiStepScriptTemplate.ScriptStep{

		global override void executeStep(){
			// how developer can have to variables shared by many steps of scipt
			String stepUniqueId = ((MultiStepScriptImplementation)caller).stepUniqueId; // way to access variables that are shared between steps
			for(Integer i = 0; i < 150; i++ ) {
				List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
				String id2 = stepUniqueId;
				if(bbcs.size() > 0) {
					BB_C__c lastBbc = bbcs[0];
					id2 += lastBBc.Id;
				}
				BB_C__c bbc = new BB_C__c(
					X__c =  id2
				); 		
				insert bbc;
				((MultiStepScriptImplementation)caller).stepUniqueId = 'theStep2';
			}	
		}
	}

	// one step of script ( can have 200 of SOQLs and 150 DMLs ). In this examle we have only 3 steps, but there are no limits
	global class Step2 extends MultiStepScriptTemplate.ScriptStep{
		global override void executeStep(){
			String stepUniqueId = ((MultiStepScriptImplementation)caller).stepUniqueId;
			for(Integer i = 0; i < 150; i++ ) {
				List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
				String id2 = stepUniqueId;
				if(bbcs.size() > 0) {
					BB_C__c lastBbc = bbcs[0];
					id2 += lastBBc.Id;
				}
				BB_C__c bbc = new BB_C__c(
					X__c =  id2
				); 		
				insert bbc;
				((MultiStepScriptImplementation)caller).stepUniqueId = 'theStep3';

			}	
		}
	}

	// one step of script ( can have 200 of SOQLs and 150 DMLs ). In this examle we have only 3 steps, but there are no limits
	global class Step3 extends MultiStepScriptTemplate.ScriptStep{
		global override void executeStep(){
			String stepUniqueId = ((MultiStepScriptImplementation)caller).stepUniqueId;
			for(Integer i = 0; i < 150; i++ ) {
				List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
				String id2 = stepUniqueId;
				if(bbcs.size() > 0) {
					BB_C__c lastBbc = bbcs[0];
					id2 += lastBBc.Id;
				}
				BB_C__c bbc = new BB_C__c(
					X__c =  id2
				); 		
				insert bbc;
			}	
		}
	}

	// here developer creates steps and ensures order of execution
	global override List<ScriptStep> initScriptSteps(){
		return new List<ScriptStep>{
			new Step1(),
			new Step2(),
			new Step3()
		};
	}

}