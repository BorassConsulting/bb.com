@isTest
private class ProducerBatch_Test {
	
	@isTest 
	static void thisTestPasses() {

		Test.startTest();
			// lines  7 to 10 will ensure that 'execute' method from batch is executed only once. Therefore in this batch methods 'start' 'execute' and 'finish' will be executed only once 
			Integer numberOfInteration = 1;
			createData( numberOfInteration );
			ProducerBatch theProducerBatch = new ProducerBatch();
			Database.executeBatch( theProducerBatch, 1 ); 		

		Test.stopTest();

		List<BB_C__c> bbcs = [Select Id, Name, X__c from BB_C__c where Name = 'start' ];
		System.assertEquals(1, bbcs.size());
		BB_C__c theBbcStart = bbcs[0];
		System.assertEquals('11', theBbcStart.X__c); // initial counter value (10) was increased by 1 and stored in X__c variable

		bbcs = [Select Id, Name, X__c from BB_C__c where Name = 'execute' ];
		System.assertEquals(1, bbcs.size());
		BB_C__c theBbcExecute = bbcs[0];
		System.assertEquals('12', theBbcExecute.X__c); // after execution of method 'start' counter equals 11 and now is increased by 1( equals 12) and stored in X__c variable
		
		bbcs = [Select Id, Name, X__c from BB_C__c where Name = 'finish' ];
		System.assertEquals(1, bbcs.size());
		BB_C__c theBbcFinish = bbcs[0];
		System.assertEquals('13', theBbcFinish.X__c); // after execution of method 'execute' counter equals 12 and now is increased by 1( equals 13) and stored in X__c variable

		System.assertEquals(10, theProducerBatch.counter); // counter does not change form point of view of unit test transaction. It still has its initial value( equals 10)


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