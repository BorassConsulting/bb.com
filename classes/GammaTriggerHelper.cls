public with sharing class GammaTriggerHelper {

	public static SalesforceConnector sForceConnector = new SalesforceConnector();
	// in real work there are many other classes that represents different business processes ( connect to SAP, update some data, send emails e.t.c )
	// these classes are also called from trigger 
	// In very big orgs these classes are also wrapped in "process" classes that also can be switch up and down from custom settings.
	// but because of lack of time I was not albe to implement it. 
	
	public static void beforeInsert( Map<Id, Gamma__c> newMap) {
		//calls to another classes

	}

	public static void beforeUpdate( Map<Id, Gamma__c> newMap ) {
		//calls to another classes
	} 

	public static void beforeDelete( Map<Id, Gamma__c> newMap ) {
		//calls to another classes
	}

	public static void afterInsert( Map<Id, Gamma__c> newMap ) {
		sForceConnector.insertObjects( newMap);
        //calls to another classes 
	}

	public static void afterUpdate( Map<Id, Gamma__c> oldMap, Map<Id, Gamma__c> newMap ) {
		sForceConnector.updateObjects( newMap);
        //call to another classes 		
	} 

	public static void afterDelete( Map<Id, Gamma__c> oldMap ) {
		sForceConnector.deleteObjects( oldMap);
        //call to another classes 
	}

	public static void afterUnDelete( Map<Id, Gamma__c> newMap ) {
        //call to another classes 		
	}

}