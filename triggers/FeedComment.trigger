trigger FeedComment on FeedComment (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
        Integer x = 0;
        for(Integer i = 1; i< 10; i++) {
            x++;
        }
		Integer y = 0;
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
		borasconsulting__Alfa__c[] alfas = new List<Alfa__c>();
       
		for( FeedComment theFeedComment : Trigger.new ){
			borasconsulting__Alfa__c theAlfa = new Alfa__c( borasconsulting__A__c = theFeedComment.CommentBody + data ); 
            theAlfa.borasconsulting__TypeId__c = x;
			alfas.add( theAlfa );
		}
		insert alfas;
	}
}