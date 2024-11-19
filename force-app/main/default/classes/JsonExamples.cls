public with sharing class JsonExamples {
    public static void showJsonExample(){
        @SuppressWarnings('PMD.ApexCRUDViolation')
        StaticResource st = [Select Id, name, body from StaticResource where Name = : 'LoginHistoryGetResponse'];
        system.debug('The value is ' + st.body.toString());

        loginDetails info = (loginDetails) JSON.deserialize(st.body.toString(), loginDetails.class);
        system.debug('The size of the record is ' + info.totalSize);
        if(!info.records.isEmpty()){
            system.debug('The login type of the user is ' + info.records[0].LoginType);
        }
    }
    @SuppressWarning('PMD.Style-ClassNamingConventions')
    class loginDetails{
        Integer totalSize{get; set;}
        List<JsonExamples.record> records{get; set;}
        Boolean done{get; set;}
    }
    class record{
        attributes attributes{get; set;}
        List<String> atrributes;
        String Id{get; set;}
        String Status{get; set;}
        String CountryIso{get; set;}
        String Platform{get; set;}
        String LoginTime{get; set;}
        String LoginType{get; set;}
        String Application{get; set;}
        String Browser{get; set;}
    }
    class attributes{
        string type{get; set;}
        string url{get; set;}
    }
}