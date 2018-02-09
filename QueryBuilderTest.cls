@IsTest
private class QueryBuilderTest {
    static testMethod void test_build () {
        QueryBuilder.build(Contact.SObjectType, new List<String>{'Account.Name'});
    }
}
