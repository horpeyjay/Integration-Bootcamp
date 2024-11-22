public with sharing class UsAddressVerification {
    public static Map<String, Object> streetVerification(Id contactId) {
        // Initialize the output list
        Map<String, Object> output = new Map<String, Object>();
        output.put('Id', contactId);
        // Query contact record
        Contact con = [SELECT Id, MailingStreet, MailingCity, MailingState FROM Contact WHERE Id = :contactId];
        String apiUrl = '';

        if (con != null && con.MailingStreet != null) {
            // Authentication parameters
            String authId = '42b6c68a-6bf5-65c1-fb51-d98d8dc22134';
            String authToken = 'P1Vt1Dlu3XXSt4n7uLND';

            // Construct the full API URL
            apiUrl = 'street=' + EncodingUtil.urlEncode(con.MailingStreet, 'UTF-8') + 
                     '&city=' + EncodingUtil.urlEncode(con.MailingCity, 'UTF-8') + 
                     '&state=' + EncodingUtil.urlEncode(con.MailingState, 'UTF-8') + 
                     '&auth-id=' + authId + 
                     '&auth-token=' + authToken;
        }

        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            // Set endpoint
            String endpointUrl = 'callout:streetverification?' + apiUrl;
            request.setEndpoint(endpointUrl);
            System.debug('The endpoint URL is: ' + endpointUrl);

            // Set HTTP method
            request.setMethod('GET');

            // Send HTTP request
            HttpResponse response = http.send(request);

            // Handle the response
            if (response.getStatusCode() == 200) {
                System.debug('The JSON body is: ' + response.getBody());

                // Deserialize JSON response
                List<Response> responseList = (List<Response>) JSON.deserialize(response.getBody(), List<Response>.class);

                if (!responseList.isEmpty()) {
                    // Extract the first response
                    Response firstResponse = responseList[0];

                    // Populate fields into the output list
                    output.put('full address', firstResponse.delivery_line_1);
                    output.put('city address', firstResponse.last_line);
                    output.put('zip code', firstResponse.components.zipcode);
                    output.put('city Name', firstResponse.components.city_name);
                    output.put('latitude', firstResponse.metadata.latitude);
                    output.put('longitude', firstResponse.metadata.longitude);
                    output.put('time zone', firstResponse.metadata.time_zone);  
                    output.put('UTC offset', firstResponse.metadata.utc_offset);

                    System.debug('The object list is: ' + output);

                    // Return the output list
                    return output;
                }
            } else {
                System.debug('The status code is: ' + response.getStatusCode());
            }
        } catch (Exception ex) {
            System.debug('Something went wrong while performing the callout ==> ' + ex.getMessage());
            System.debug('The cause of the error was ==> ' + ex.getCause());
        }

        // Return the output list (empty if no data retrieved)
        return output;
    }

    // Inner classes matching JSON structure
    private class Response {
        String delivery_line_1 { get; set; }
        String last_line { get; set; }
        Components components { get; set; }
        Metadata metadata { get; set; }
    }

    private class Components {
        String zipcode { get; set; }
        String city_name { get; set; }
    }

    private class Metadata {
        Double longitude { get; set; }
        Double latitude { get; set; }
        String time_zone { get; set; }
        Integer utc_offset { get; set; }
    }

    public static List<Location__c> updateContactLocation(Id contactId){
        Map<String, Object> locationDetails = streetVerification(contactId);
        List<Location__c> existingLocation = [Select Contact__c, Name, Address_Geolocation__c From Location__c where Contact__c = : contactId Limit 1];
        Contact con = [Select Id, Name From Contact where Id = : contactId];
        List<Location__c> locationList = new List<Location__c>();
        if(existingLocation.size() == 0){
            if(con != null){
                Location__c loc = new Location__c();
                loc.Contact__c = contactId;
                loc.Name = con.Name + ' - Address';
                loc.Street_Address__c = (String) locationDetails.get('full address'); 
                loc.City_And_State__c = (String) locationDetails.get('city address');
                loc.City_Name__c = (String) locationDetails.get('city Name');
                loc.Address_Geolocation__Latitude__s = (Double) locationDetails.get('latitude');
                loc.Address_Geolocation__Longitude__s = (Double) locationDetails.get('longitude');
                loc.Zip_Code__c = (String) locationDetails.get('zip code');
                loc.TimeZone__c = (String) locationDetails.get('time zone');
                loc.UTC_Offset__c = (Integer) locationDetails.get('UTC offset');
                locationList.add(loc);
            }
            
        }else{

            existingLocation[0].Street_Address__c = (String) locationDetails.get('full address'); 
            existingLocation[0].City_And_State__c = (String) locationDetails.get('city address');
            existingLocation[0].City_Name__c = (String) locationDetails.get('city Name');
            existingLocation[0].Address_Geolocation__Latitude__s = (Double) locationDetails.get('latitude');
            existingLocation[0].Address_Geolocation__Longitude__s = (Double) locationDetails.get('longitude');
            existingLocation[0].Zip_Code__c = (String) locationDetails.get('zip code');
            existingLocation[0].TimeZone__c = (String) locationDetails.get('time zone');
            existingLocation[0].UTC_Offset__c = (Integer) locationDetails.get('UTC offset');
            locationList.add(existingLocation[0]);
        }
        if(locationList.size() > 0){
            return locationList;
        }
        return null;
    }
}
