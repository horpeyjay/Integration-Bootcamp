public with sharing class HTTPCalloutExamples {
    public static void calloutExamples() {
        Http http = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/users');
        req.setMethod('GET');

        HttpResponse response = http.send(req);
        string status = response.getStatus();
        System.debug('Status => ' + status);
        
        Integer statuscode = response.getStatusCode();
        system.debug('Status Code => ' + statuscode);
        String jsonBody = response.getBody();
        system.debug('The json body is  => ' + jsonBody);
    }

    public static void namedCredCallouts() {
        Http http = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:restAPI/users');
        req.setMethod('GET');

        HttpResponse response = http.send(req);
        string status = response.getStatus();
        System.debug('Status => ' + status);
        
        Integer statuscode = response.getStatusCode();
        system.debug('Status Code => ' + statuscode);
        String jsonBody = response.getBody();
        system.debug('The json body is  => ' + jsonBody);
    }
}