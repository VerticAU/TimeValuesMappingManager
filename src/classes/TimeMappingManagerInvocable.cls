public without sharing class TimeMappingManagerInvocable {
    @InvocableMethod(Label='Time Values Mapping Manager' Description='Updates the values on the target record with the values from the source (cross-object)')
    public static void process(List<InvocableRequest> requests) {
        for(InvocableRequest request: requests){
            Schema.SObjectType sourceType = Id.valueOf(request.sourceRecordId).getSObjectType();
            String sourceRecordId = request.sourceRecordId;
            Schema.SObjectType targetType = Id.valueOf(request.targetRecordId).getSObjectType();

            Set<String> fieldsSet = new Set<String>();
            fieldsSet.add(request.sourceField1ApiName);
            fieldsSet.add(request.sourceField2ApiName);
            fieldsSet.add(request.sourceField3ApiName);
            fieldsSet.add(request.sourceField4ApiName);
            fieldsSet.add(request.sourceField5ApiName);

            String sourceQuery = 'SELECT ';
            for(String fieldName:fieldsSet){
                if(fieldName != null && String.isNotBlank(fieldName)){
                    sourceQuery += fieldName + ', ';
                }
            }
            sourceQuery += 'Id  FROM ' + String.valueOf(sourceType) + ' WHERE Id =:sourceRecordId';

            sObject sourceRecord = Database.query(sourceQuery);
            sObject targetRecord;

            if(sourceRecord != null){
                targetRecord = targetType.newSObject((Id)request.targetRecordId);
                if(request.targetField1ApiName != null && String.isNotBlank(request.targetField1ApiName)) targetRecord.put(request.targetField1ApiName,sourceRecord.get(request.sourceField1ApiName));
                if(request.targetField2ApiName != null && String.isNotBlank(request.targetField2ApiName)) targetRecord.put(request.targetField2ApiName,sourceRecord.get(request.sourceField2ApiName));
                if(request.targetField3ApiName != null && String.isNotBlank(request.targetField3ApiName)) targetRecord.put(request.targetField3ApiName,sourceRecord.get(request.sourceField3ApiName));
                if(request.targetField4ApiName != null && String.isNotBlank(request.targetField4ApiName)) targetRecord.put(request.targetField4ApiName,sourceRecord.get(request.sourceField4ApiName));
                if(request.targetField5ApiName != null && String.isNotBlank(request.targetField5ApiName)) targetRecord.put(request.targetField5ApiName,sourceRecord.get(request.sourceField5ApiName));
            }
            if(targetRecord != null){
                update targetRecord;
            }

        }

    }

    public class InvocableRequest {
        @InvocableVariable(Label='Source Record Id' required=true)
        public String sourceRecordId;
        @InvocableVariable(Label='Target Record Id' required=true)
        public String targetRecordId;

        @InvocableVariable(Label='Source Time Field 1 API Name')
        public String sourceField1ApiName;
        @InvocableVariable(Label='Target Time Field 1 API Name')
        public String targetField1ApiName;

        @InvocableVariable(Label='Source Time Field 2 API Name')
        public String sourceField2ApiName;
        @InvocableVariable(Label='Target Time Field 2 API Name')
        public String targetField2ApiName;

        @InvocableVariable(Label='Source Time Field 3 API Name')
        public String sourceField3ApiName;
        @InvocableVariable(Label='Target Time Field 3 API Name')
        public String targetField3ApiName;

        @InvocableVariable(Label='Source Time Field 4 API Name')
        public String sourceField4ApiName;
        @InvocableVariable(Label='Target Time Field 4 API Name')
        public String targetField4ApiName;

        @InvocableVariable(Label='Source Time Field 5 API Name')
        public String sourceField5ApiName;
        @InvocableVariable(Label='Target Time Field 5 API Name')
        public String targetField5ApiName;
    }

}