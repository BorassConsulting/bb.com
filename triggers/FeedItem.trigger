trigger FeedItem on FeedItem (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {

	if ( Trigger.isBefore ){
    	if( Trigger.isInsert ){
			createObject( 'BeforeInsert' );
    	} else if( Trigger.isUpdate ){
			createObject( 'BeforeUpdate' );
    	} else if( Trigger.isDelete ){
			createObject( 'BeforeDelete' );
    	}	    
	} else if (Trigger.isAfter) {
    	if( Trigger.isInsert ){
			createObject( 'AfterInsert' );
    	} else if( Trigger.isUpdate ){
			createObject( 'AfterUpdate' );
    	} else if( Trigger.isDelete ){
			createObject( 'AfterDelete' );    		
    	}	    
	}

	static void createObject( String data ){
		Alfa__c[] alfas = new List<Alfa__c>();
		for( FeedItem theFeedItem : Trigger.new ){
			Alfa__c theAlfa = new Alfa__c( A__c = theFeedItem.Body + data );
			alfas.add( theAlfa );
		}
		insert alfas;
	}
}