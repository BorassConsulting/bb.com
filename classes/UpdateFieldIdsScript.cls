public class UpdateFieldIdsScript {
    public static void execute(){
        ToolingApi theToolingApi = new ToolingApi();
        List<ToolingAPIWSDL.sObject_x> results = theToolingApi.query('Select Id, DeveloperName, NamespacePrefix From CustomObject Where DeveloperName = \'BB_A\'').records;
        ToolingAPIWSDL.sObject_x customObject = (ToolingAPIWSDL.sObject_x)results[0];
        Id customObjectId = customObject.Id;
        List<ToolingAPIWSDL.sObject_x> customFields =   theToolingApi.query('Select Id, DeveloperName From CustomField Where TableEnumOrId = \'' + customObjectId + '\' and DeveloperName = \'Y\' ' , 'ToolingAPIWSDL.CustomField').records;
        ToolingAPIWSDL.CustomField yCustomField = (ToolingAPIWSDL.CustomField)customFields[0];
        String yFieldId = yCustomField.Id.left(15);
        borasconsulting__Field_Ids__c fieldIds = borasconsulting__Field_Ids__c.getInstance();
        if( fieldIds == null){
            fieldIds = new borasconsulting__Field_Ids__c();
        }
        fieldIds.A_Y__c = yFieldId;
        upsert fieldIds;
    }
}