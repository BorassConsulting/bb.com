/*
// This class has to be installed on target org
// all customizations has to be done on this org
*/
@RestResource(urlMapping='/GammaWebService/*')
global class GammaWebService { // webservices have to be global
	private static final String UPSERT_COMMAND = 'Upsert';// it is duplicated with information from SalesforceConnector Class but this class is deployed on an another org. 	
	private static final String DELETE_COMMAND = 'Delete'; 
	private static final String COMMAND_ELEMENT = 'Command';
	private static final String GAMMA_ELEMENT = 'Gamma';

	public GammaWebService() { }

	@HttpPost
	global static String receiveJSon( ){
		RestRequest theRequest;
		String responseBody = '';
		boolean isError = false;
		try{
			theRequest = RestContext.request;
			String requestBody = theRequest.requestBody.toString();
			responseBody = proceedRequest( requestBody );
			return responseBody; // this will be returned to sender 
		} catch ( Exception ex ){
			isError = true;				
			responseBody = 'Cause:' + ex.getCause() +
				';LineNumber:' + ex.getLineNumber() +
				';Message:' + ex.getMessage() + 
				';StackTrace:' + ex.getStackTraceString();
			throw ex;
		}		
	}

	private static String proceedRequest( String requestBody ){

		Map<String,Object> jsonMap = (Map<String,Object>)Json.deserializeUntyped( requestBody );
		String command = (String)jsonMap.get( COMMAND_ELEMENT );
		List<Map<String, Object>> gammaObjectList = (List<Map<String,Object>>)jsonMap.get( GAMMA_ELEMENT );// get gamma list that was connected to gamma element
		
		// this so done to demonstration purpouses. In bigger system this type of opperations should be encapsulated in DAO layer 
		if( command == UPSERT_COMMAND ){
			List<Gamma__c> gammas = createGammaList( gammaObjectList );
			Database.upsert( gammas, Gamma__c.fields.eID__c, false ); // use external Id during upsert to determine object (of couse ids of objects are different on different orgs), and 
			 												  // and all AllOrNone parameter to false to be able to partialy success
			// here we shoud add some logging and send data
		} else if ( command == DELETE_COMMAND ){
			// as far as i remember you cannot delete an object using externallId thefore I have to waste one SOQL query to look for object list
			Set<string> externalIds = getGammaExternalIds( gammaObjectList );
			List<Gamma__c> gammas = [SELECT Id FROM Gamma__c WHERE eid__c in:externalIds];
			Database.delete( gammas, false );
			// here we shoud add some logging and send data
		}
		return 'OK'; // for demonstration purpouses only. Logging and dealing with errors should be implemented here 
	}

	private static List<Gamma__c> createGammaList( List<Map<String, Object>> gammaObjectList ){
		List<Gamma__c> gammas = new List<Gamma__c>();
		for( Map<String, Object> theGammaObject : gammaObjectList ) {
			Gamma__c theGamma = new GAmma__c();
			theGamma.Name = (String)theGammaObject.get('name');
			theGamma.A__c = (String)theGammaObject.get('a__c');
			theGamma.B__c = (String)theGammaObject.get('b__c');
			theGamma.eId__c = (String)theGammaObject.get('eid__c');
			gammas.add( theGamma );
		}
		return gammas;
	}

	private static Set<String> getGammaExternalIds ( List<Map<String, Object>> gammaObjectList ){
		Set<String> externalIds = new Set<String>();
		for( Map<String, Object> theGammaObject : gammaObjectList ) {			
			String theEId = (String)theGammaObject.get('eid__c');
			externalIds.add( theEId );
		}
		return externalIds;
	}

}