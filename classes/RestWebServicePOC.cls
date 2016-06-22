@RestResource(urlMapping='/RestWebServicePOC/*')
global with sharing class RestWebServicePOC {

    @HttpPost
    global static String sub(Integer a, Integer b) {
        /*RestContext.response.responseBody = Blob.valueOf('{"ala" : "x", "ola" : "y"}');*/
        return 'test';
    }
}