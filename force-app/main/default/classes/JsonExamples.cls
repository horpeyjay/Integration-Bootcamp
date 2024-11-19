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

        //to generate a json manually
        String newJson = JSON.serialize(info);
        System.debug('Json text using serialization is => '+ newJson);
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

    //to create a json file

    public static void createJson() {
        // Create JSON generator
        JSONGenerator generator = JSON.createGenerator(true);
    
        // Start the main object
        generator.writeStartObject();
        generator.writeNumberField('totalSize', 1);
        generator.writeFieldName('records');
        
        // Start the records array
        generator.writeStartArray();
        generator.writeStartObject();
    
        // Add attributes object
        generator.writeFieldName('attributes');
        generator.writeStartObject();
        generator.writeStringField('type', 'LoginHistory');
        generator.writeStringField('url', '/services/data/v57.0/sobjects/LoginHistory/0Ya6s00000g5kkPCAQ');
        generator.writeEndObject();
    
        // Add remaining fields in the record object
        generator.writeStringField('Status', 'Success');
        generator.writeStringField('LoginTime', '2023-03-29T13:10:25.000+0000');
        generator.writeStringField('CountryIso', 'US');
        generator.writeStringField('Platform', 'Unknown');
        generator.writeStringField('LoginType', 'Remote Access 2.0');
        generator.writeStringField('Application', 'Salesforce CLI');
        generator.writeStringField('Browser', 'Unknown');
    
        // End the record object and array
        generator.writeEndObject();
        generator.writeEndArray();
    
        // End the main object
        generator.writeBooleanField('done', true);
        generator.writeEndObject();
    
        // Convert JSON generator to string
        String jsonString = generator.getAsString();
        System.debug('The Json body is ' + jsonString);
    }
    
}