@isTest
private class MultiStepsBatch_Test {
	

	//this method should not throw an exeption
	@isTest 
	static void MultiStepsBatchTestPass() {

		Integer numberOfInteration = 1;
		createData( numberOfInteration );

		Test.startTest();

			POC_MultiStepException_Batch pocMultiStepExceptionBatch = new POC_MultiStepException_Batch();
			Database.executeBatch( pocMultiStepExceptionBatch, 1); // batch size is 1	

		Test.stopTest();
		System.assert(true);			
	}
	
	//this method will throw an exeption because in test method execute from inteface Database.Batchable can be executed. Sorry Salesforce limits:) 
	//System.UnexpectedException: No more than one executeBatch can be called from within a testmethod. Please make sure the iterable returned from your start method matches the batch size, resulting in one executeBatch invocation.
	@isTest 
	static void MultiStepsBatchTestFail() {

		Integer numberOfInteration = 2;
		createData( numberOfInteration );

		try{
		Test.startTest();

			POC_MultiStepException_Batch pocMultiStepExceptionBatch = new POC_MultiStepException_Batch();
			Database.executeBatch( pocMultiStepExceptionBatch, 1); // batch size is 1

		Test.stopTest();
		System.assert(false);// exception should be thrown in line 35 Test.stopTest();	
		} catch (Exception theException){
			System.assertEquals('No more than one executeBatch can be called from within a testmethod. Please make sure the iterable returned from ' +
				'your start method matches the batch size, resulting in one executeBatch invocation.', theException.getMessage());

		}
	}


	private static void createData(Integer numberOfInteration){
		List<Batch_Step__c> stepCounts = new List<Batch_Step__c>();
		for(Integer i = 0; i < numberOfInteration; i++){
			Batch_Step__c theStepCount = new Batch_Step__c(
				Index__c = i
			);
			stepCounts.add( theStepCount );
		}
		insert stepCounts;
	}

}