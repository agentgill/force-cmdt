/**
 * @description       : GetCustomMetadataService - Demo Returning CMT via Property allowing for CMT test mocking
 * @author            : agentgill
 * @group             : 
 * @last modified on  : 10-04-2021
 * @last modified by  : agentgill
 https://developer.salesforce.com/docs/atlas.en-us.234.0.apexcode.meta/apexcode/apex_classes_properties.htm
**/
public with sharing class GetCustomMetadataService {

    /**
    * @description Load Custom Metadata using Apex Property
    * @author agentgill | 10-04-2021 
    * @param == 
    * @param null 
    * @return Map<String, MyCustomType__mdt> 
    **/
    @testVisible
    public static Map<String, MyCustomType__mdt> getCustomMetadataService {
        get {
            if (getCustomMetadataService == null){
                getCustomMetadataService = new Map<String, MyCustomType__mdt>();
                for (MyCustomType__mdt cmt : [SELECT MasterLabel,
                                                    Integration__c
                                                    FROM MyCustomType__mdt]) {
                        System.debug(LoggingLevel.INFO, cmt);
                                                        getCustomMetadataService.put(cmt.MasterLabel, cmt);
                }

            }
            System.debug(LoggingLevel.INFO, 'Generating CMT Map using an Apex Class Property');
            return getCustomMetadataService;
        }
        set;
    }
}
