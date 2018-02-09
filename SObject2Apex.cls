global class SObject2Apex {
    @testVisible
    private String recordTemplate;

    public SObject2Apex (Id recordId) {
        SObjectType sObjType = recordId.getSObjectType();
        String objectName = sObjType.getDescribe().getName();
        SObject record = Database.query(QueryBuilder.build(sObjType) + ' WHERE Id = :recordId');
        List<String> copiable = new List<String>();
        Map<String, Schema.SObjectField> fieldMap = sObjType.getDescribe().fields.getMap();
        for (String field : fieldMap.keySet()) {
            Schema.DescribeFieldResult description = fieldMap.get(field).getDescribe();
            if (description.isCreateable() && description.isUpdateable()) {
                copiable.add(description.getName());
            }
        }
        this.recordTemplate = objectName + ' record = new ' + objectName + '(';
        for (String fieldName : copiable) {
            String f = formatField(record.get(fieldName));
            if (f != null)
	            this.recordTemplate += fieldName + '=' + f + ', ';
        }
        this.recordTemplate = this.recordTemplate.removeEnd(', ');
        this.recordTemplate += ');';
        System.debug(this.recordTemplate);
    }
    
    @testVisible
    private String formatField (Object fieldValue) {
        if (fieldValue instanceof Date) {
            Date d = (Date) fieldValue;
            return String.format('Date.newInstance({0}, {1}, {2})', new List<String>{
                d.year()+'', d.month()+'', d.day()+''
            });
        } else if (fieldValue instanceof DateTime) {
            DateTime d = (DateTime) fieldValue;
            return String.format('DateTime.newInstance({0}, {1}, {2}, {3}, {4}, {5})', new List<String>{
                d.year()+'', d.month()+'', d.day()+'', d.hour()+'', d.minute()+'', d.second()+''
            });
        }
        if (fieldValue == null) {
            return null;
        }
        if (fieldValue instanceof Integer || fieldValue instanceof Decimal) {
            return String.valueOf(fieldValue);
        }
        return '\'' + String.valueOf(fieldValue) + '\'';
    }
}
