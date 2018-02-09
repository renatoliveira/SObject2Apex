global class QueryBuilder {
    public static String build(SObjectType sObjType) {
        return build(sObjType, null);
    }

    public static String build(SObjectType sObjType, List<String> extraFields) {
        String obj_name = sObjType.getDescribe().getName();
        String query = 'SELECT ';
        for (String field : sObjType.getDescribe().fields.getMap().keySet()) {
            query += field + ', ';
        }
        if (extraFields != null) {
            for (String field : extraFields) {
                query += field + ', ';
            }
        }
        query = query.removeEnd(', ');
        query += ' FROM ' + obj_name;
        return query;
    }
}
