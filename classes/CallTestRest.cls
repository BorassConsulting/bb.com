public with sharing class CallTestRest {
	public CallTestRest() {
		HttpRequest req = new HttpRequest();
	    HttpResponse res = new HttpResponse();
	    Http http = new Http();

	    req.setEndpoint('https://external.service.com');
	    req.setMethod('POST');
	    req.setBody('');
	    req.setCompressed(true); // otherwise we hit a limit of 32000

	    try {
	        res = http.send(req);
	    } catch(System.CalloutException e) {
	        System.debug('Callout error: '+ e);
	        System.debug(res.toString());
	    }
	}


}