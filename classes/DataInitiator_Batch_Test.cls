@isTest
global class DataInitiator_Batch_Test {
	global class MyDataInitiator extends DataInitiator_Batch{
		String stepUniqueId = 'theStep1';
		override global void step1(){		

			for(Integer i = 0; i < 149; i++ ) { // one DML is vasted for updating custom settings 
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
				stepUniqueId = 'theStep2';	
			}

			DataInitiator_Batch_Test.countSOQLsAndDMLs(); // information about soql has to be stored in custom settings. We cannot use local variable from batch because values of 
			                                              //	these variables cannot be transfered back to test method	
		}

		override global void step2(){

			for(Integer i = 0; i < 149; i++ ) {
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
				stepUniqueId = 'theStep3';
			}		
			DataInitiator_Batch_Test.countSOQLsAndDMLs();

		}

		override global void step3(){
			for(Integer i = 0; i < 149; i++ ) {
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
			DataInitiator_Batch_Test.countSOQLsAndDMLs();
		}
		
	}


	@isTest 
	static void testDataInitiator() {		
		Limits_Information__c limitsInformation = new Limits_Information__c(			
			DML_Counter__c = 0,
			SOQL_Counter__c = 0	
		);
		insert limitsInformation;
		
		Test.startTest();
	
			for(Integer i = 0; i < 98; i++ ) {
				List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
				String id2 = 'step0';
				if(bbcs.size() > 0) {
					BB_C__c lastBbc = bbcs[0];
					id2 += lastBBc.Id;
				}
				BB_C__c bbc = new BB_C__c(
					X__c =  id2
				); 		
				insert bbc; // insert in a 'for loop' is for tests purpouses only, do not do it at home or during your interview:) 
			}		
			DataInitiator_Batch_Test.countSOQLsAndDMLs();
			
			DataInitiator_Batch_Test.MyDataInitiator dataInitiator = new DataInitiator_Batch_Test.MyDataInitiator();
			dataInitiator.initData();

		Test.stopTest();

		List<AggregateResult> resultsGroups = [SELECT count(id) theCount from BB_C__c];
		AggregateResult results = resultsGroups[ 0 ];
		Integer theCount = (Integer)results.get('theCount');
		System.assertEquals(545, theCount);	
		List<Limits_Information__c> limitsInformations = [select Id, Name, DML_COUNTER__c, SOQL_COUNTER__C from Limits_Information__c  limit 1];	
		Limits_Information__c theLimitsInformation = limitsInformations[0]; 		
		System.assertEquals(548, theLimitsInformation.SOQL_Counter__c.intValue());
		System.assertEquals(545, theLimitsInformation.DML_Counter__c.intValue());					
	}


	public static void countSOQLsAndDMLs(){

		List<Limits_Information__c> limitsInformations = [select Id, Name, DML_COUNTER__c, SOQL_COUNTER__C from Limits_Information__c  limit 1];	
		Limits_Information__c theLimitsInformation = limitsInformations[0]; 
		thelimitsInformation.DML_Counter__c += Limits.getDMLStatements();		
		thelimitsInformation.SOQL_Counter__c += Limits.getQueries();
		System.debug( Limits.getDMLStatements() );
		System.debug( Limits.getQueries() );
		update theLimitsInformation;

	}		

}