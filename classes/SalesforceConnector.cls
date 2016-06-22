public with sharing class SalesforceConnector {
	private String UPSERT_COMMAND = 'upsert';	
	private String DELETE_COMMAND = 'delete';
	private String COMMAND_ELEMENT = 'command';
	private String GAMMA_ELEMENT = 'gammas';

	public SalesforceConnector() {
		
	}

	public void insertObjects( Map<Id, Gamma__c> newMap ){
		sendGammasToSalesforce( UPSERT_COMMAND, newMap.values() );
	}

	public void updateObjects( Map<Id, Gamma__c> newMap ){
		sendGammasToSalesforce( UPSERT_COMMAND, newMap.values() );
	}

	public void deleteObjects( Map<Id, Gamma__c> newMap ){
		sendGammasToSalesforce( DELETE_COMMAND, newMap.values() );
	}

	
	private void sendGammasToSalesforce(String theCommand, list<Gamma__c> gammas  ){
		String gammasString = Json.serialize( gammas );// this is kind of short cut. In real word sceniario i will send only values that changed to 
													   // to do it i will build my own key value map and serialize it using JSON.serialize( Map<STring, Object> )
		JSonGenerator generator = JSon.createGenerator( true );// I pass parameter true for a pretty formating. In real word sceniario it should be false.
		generator.writeStartObject();
		generator.writeStringField(COMMAND_ELEMENT, theCommand);
		generator.writeStringField(GAMMA_ELEMENT, gammasString );
		generator.writeEndObject();
		String jsonToSend = generator.getAsString();
		makeAnyncCall( jsonToSend );
	}

	@future(callout=true)// callout=true has to be set to call a webservice from a trigger . Of couse we have to do it asynch. in future method 
	private static void makeAnyncCall( String jsonToSend ){
			   
        String oauth = oauthLogin( 
            '3MVG9Rd3qC6oMalVwLE3NcIIVGXP91EJMQFS1W03mVx.5PGr_267EXj3d2pMQ9rHTUte0Tbus9euuLzcQ3zM9', // consumer key
            '6411921374637452720', // consumer secret 
            'test1@bb2.com', // user name 
            'Bartosz1s1ZQWsqPcFb4jbP5uqPZsQ04'); //for obvious reason these values CANNOT be hardcoded. and this code cannot pass code inspection with them, but of couse this is done only 
        							   // for demonstration purpouses 

        Map<String, Object> oauthMap = (Map<String, Object>)JSON.deserializeUntyped(oauth);
            
        String accessToken = (String)oauthMap.get('access_token');
        String instanceUrl = (String)oauthMap.get('instance_url');

        HttpRequest req = new HttpRequest(); 
 
 		System.debug('jsonToSend:' + jsonToSend);
        req.setMethod('POST');
        req.setEndpoint(instanceUrl+'/services/apexrest/GammaWebService');
        req.setHeader('Authorization', 'OAuth '+accessToken);
        req.setBody('JSON='+jsonToSend);

        Http http = new Http();
  
        HTTPResponse res = http.send(req);

        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
    	
    	// here we should write some logs to salesforce database     	

    }       


    private static String oauthLogin(String clientId,
        String clientSecret, String username, String password) {
        HttpRequest req = new HttpRequest(); 
 
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setBody('grant_type=password' +
            '&client_id=' + clientId +
            '&client_secret=' + clientSecret +
            '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') +
            '&password=' + EncodingUtil.urlEncode(password, 'UTF-8'));
    
        Http http = new Http();
  
        HTTPResponse res = http.send(req);

        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
        
        return res.getBody();
    }
}