/**
 * @description GetCustomMetadataService
 */


String cmtKey = 'AWS';
MyCustomType__mdt myCMT = GetCustomMetadataService.getCustomMetadataService.get(cmtKey);
System.debug(LoggingLevel.INFO, 'Here is your CMT record:'+myCMT);