@isTest
private class BetaTest {
	
	@isTest 
	static void checkHowManySOQL() {
		Alfa__c[] alfas = new List<Alfa__c>(); 
		for( Integer i=0; i<3; i++ ){
			Alfa__c  theAlfa = new Alfa__c( Name='Alfa' + i );
			alfas.add( theAlfa );
		}
		insert alfas;
		
		Test.startTest();		
			Beta__c beta = new Beta__c( Name = 'Beta');
			insert beta;		
			System.assertEquals( 2, Limits.getQueries() );
			
		Test.stopTest();		
	}
	
}