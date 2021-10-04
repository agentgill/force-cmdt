/**
 * @description       : GetCustomMetadataServiceTest
 * @author            : agentgill
 * @group             : 
 * @last modified on  : 10-04-2021
 * @last modified by  : agentgill
**/
@isTest
public with sharing class GetCustomMetadataServiceTest {
    

    @isTest
    static void testCustomMetadataService(){

        // Set my TestVisible getCustomMetadataService using an Automatic Property
        GetCustomMetadataService.getCustomMetadataService = testCMT;

        Test.startTest();
        MyCustomType__mdt myCMT = GetCustomMetadataService.getCustomMetadataService.get('Test');
        System.debug(LoggingLevel.INFO, 'My Custom Metadata record for testing:'+myCMT);
        Test.stopTest();
        // Can I assert my Test CustomMetadata?
        System.assertEquals('Test',myCMT.Integration__c,'Something went wrong!');

    }

    /**
    * @description Override my Apex property and inject a cmt record for testing
    * @author agentgill | 10-04-2021 
    * @param JSON.deserialize 
    * @return Map<String, MyCustomType__mdt> 
    **/
    private static Map<String, MyCustomType__mdt> testCMT {
        get {
            return new Map<String, MyCustomType__mdt> {
                       'Test' => ( MyCustomType__mdt ) JSON.deserialize(
                           '{ "MasterLabel" : "Test", "Integration__c" : "Test" }', MyCustomType__mdt.class )
            };
        }
        private set;
    }
}


