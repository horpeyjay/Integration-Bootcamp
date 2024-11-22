public with sharing class ContactLocationHandler {
    public static void ContactLocationHandler(List<Contact> conList) {
        Set<ID> conIds = new Set<ID>();
        if(!conList.isEmpty()){
            for(Contact con : conList){
                if(con.Id != null){
                    conIds.add(con.Id);
                }
            }
        }
        List<Location__c> locationToUpsert = new List<Location__c>();
        if(conIds != null){
            for(Id i : conIds){
                List<Location__c> locationList =  UsAddressVerification.updateContactLocation(i);
                if(locationList != null && locationList.size() > 0){
                    locationToUpsert.addAll(locationList);
                }
            }
        }

        if(!locationToUpsert.isEmpty()){
            upsert locationToUpsert;
        }
    }
}