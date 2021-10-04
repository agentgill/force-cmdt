# Managing & Testing Custom Metadata

Managing custom metadata & custom metadata records via the Salesforce UI is tiedious at best, especially if the number of records is large.

**Alternative** - You can build UI using Flow or LWC but you will need to jump through a number of complex Apex hoops using Metadata.CustomMetadat & Metadata.DeployCallback to get the job done.

**Best Path** - Or you can pull the records into a CSV and use the sfdx-cli to prepare them to be pushed - easy as that

## force:cmdt COMMAND

create and update custom metadata types and their records

USAGE

 ```text
  sfdx force:cmdt:COMMAND
 ```

TOPICS

```bash
  force:cmdt:field   generate a custom metadata field based on the field type provided
  force:cmdt:record  create and update custom metadata type records
```  

COMMANDS

```bash
  force:cmdt:create    creates a new custom metadata type in the current project
  force:cmdt:generate  generates a custom metadata type and all its records for the provided sObject
```

---

## Baiscs of insert CMT using CLI

### Insert cmdt records using CLI

```bash
sfdx force:cmdt:record:create -t MyCustomType -n SFDX -l "Salesforce DX" Integration__c=sfdx
```

### Insert cmdt records using CSV

```bash
sfdx force:cmdt:record:insert -f cmdt.csv -t MyCustomType
```

### Create new cmdt type

```bash
sfdx force:cmdt:create -n Token -l "Crypto Tokens" -p Tokens -d force-app/main/default/objects     
```

## Testing Custom Metadata without any Org Dependency

Switching to an Apex Property and making it testVisible allows for CustomMetadata to be defined and set in the Test Classes (no org dependency) - like magic!

[Apex Class Properties](https://developer.salesforce.com/docs/atlas.en-us.234.0.apexcode.meta/apexcode/apex_classes_properties.htm)

### Example Apex Property Pattern

```java
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
```

### Example Apex Test


```java
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

 
    private static Map<String, MyCustomType__mdt> testCMT {
        get {
            return new Map<String, MyCustomType__mdt> {
                       'Test' => ( MyCustomType__mdt ) JSON.deserialize(
                           '{ "MasterLabel" : "Test", "Integration__c" : "Test" }', MyCustomType__mdt.class )
            };
        }
        private set;
    }
```

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
