@isTest
private class DMLTest {
	
	@isTest static void DML150() {
		for( Integer i=0; i<150; i++ ){
			Alfa__c theAlfa = new Alfa__c( name = 'Alfa' );
			insert theAlfa;
		}
	}

	@isTest static void DML151() {
		Boolean flag = false;
		try{
			for( Integer i=0; i<151; i++ ){
				Alfa__c theAlfa = new Alfa__c( name = 'Alfa' );
				insert theAlfa;
			}
			System.assert( false, 'Program execution should no reach this point' );
		} catch ( Exception ex ){
			flag = true;
		}
		System.assertEquals( true, flag, 'Exception has to be thrown' );
	}		
}