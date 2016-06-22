@isTest
global class POC_WorkaroundFor200SOQLLimitInUT {
	
	global class InitDatabase extends WorkaroundFor200SOQLLimitInUT{
		//public String id1;
		//public String id2;
		//public String id3;
		//public Integer soqlCounter = 0;
		//public Integer dmlCounter = 0;

		override global void step1(){
			/*BB_C__c bbc; 
			for(Integer i = 0; i < 150; i++ ) {
				List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
				String idx = 'Step1:';
				if(bbcs.size() > 0) {
					BB_C__c lastBbc = bbcs[0];
					idx += lastBBc.Id;
				}
				bbc = new BB_C__c(
					X__c =  idx
				); 		
				insert bbc;
			}
			id1 = bbc.id;
			soqlCounter += Limits.getSoslQueries();
			dmlCounter += Limits.getDMLStatements();
			*/
		}

		override global void step2(){
			//BB_C__c bbc; 
			//for(Integer i = 0; i < 150; i++ ) {
			//	List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
			//	String idx = 'Step2:' + id1 +':';
			//	if(bbcs.size() > 0) {
			//		BB_C__c lastBbc = bbcs[0];
			//		idx += lastBBc.Id;
			//	}
			//    bbc = new BB_C__c(
			//		X__c =  idx
			//	); 		
			//	insert bbc;
			//}
			//id2 = bbc.id;
			//soqlCounter += Limits.getSoslQueries();
			//dmlCounter += Limits.getDMLStatements();
		}

		override global void step3(){
			//BB_C__c bbc;
			//for(Integer i = 0; i < 150; i++ ) {
			//	List<BB_C__c> bbcs = [SELECT ID FROM BB_C__c order by createdDate desc limit 1];
			//	String idx = 'Step3:' + id2 +':';
			//	if(bbcs.size() > 0) {
			//		BB_C__c lastBbc = bbcs[0];
			//		idx += lastBBc.Id;
			//	}
			//	bbc = new BB_C__c(
			//		X__c =  idx
			//	); 		
			//	insert bbc;
			//}
			//id3 = bbc.id;
			//soqlCounter += Limits.getSoslQueries();
			//dmlCounter += Limits.getDMLStatements();
		}
	}


	//static InitDatabase databaseInitiator = new InitDatabase();

	@isTest 
	static void pocTest() {
		Test.startTest();	
		InitDatabase databaseInitiator = new InitDatabase();
		//databaseInitiator.initDatabase();
		Database.executeBatch(databaseInitiator, 1);		
		Test.stopTest();
		//System.debug('soqlCounter : ' + databaseInitiator.soqlCounter);
		//System.debug('dmlCounter : ' + databaseInitiator.dmlCounter);	
	}
}