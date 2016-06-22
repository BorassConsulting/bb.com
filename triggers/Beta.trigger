trigger Beta on Beta__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

	if ( Trigger.isBefore && Trigger.isInsert ) {    	
    	beforeInsert();
	} else if ( Trigger.isBefore && Trigger.isUpdate ){
		beforeUpdate();
	}

	private static void beforeInsert(){
		execute();
	}

	public static void beforeUpdate(){
		execute();
	}

	private static void execute() {
	/*	AggregateResult[] results = [ select count( Id ) theCount from Alfa__c ];
		AggregateResult theResult = results[ 0 ];
		Integer count = (Integer)theResult.get( 'theCount' );*/

		List<Alfa__c> alfas = [
			SELECT Id
			FROM Alfa__c
		];
		Integer count = alfas.size();
		for( Beta__c theBeta : Trigger.new ){
			theBeta.alfaCounter__c = count;
		}

	}
}