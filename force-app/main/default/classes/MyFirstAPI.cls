@RestResource(urlMapping = '/myapi')
global with sharing class MyFirstAPI {
    @HttpGet
    global static String fetchAccount() {
        Account [] accList = [Select Id, Name, Website, AccountNumber from Account];

        String jsonBody = JSON.serialize(accList);
        return jsonBody;
    }
}