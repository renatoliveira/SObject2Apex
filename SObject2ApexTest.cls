@isTest
private class SObject2ApexTest {
    static testMethod void test_copy () {
        Account testAccount = new Account(
            Name = 'United Oil & Gas',
            AccountNumber='CD355120-B',
            Website='http://www.uos.com',
            Sic='4437',
            Industry='Energy',
            NumberOfEmployees=3000,
            Ownership='Public',
            TickerSymbol='UOS',
            Site='uos.com/sg'
        );
        insert testAccount;
        
        Test.startTest();
        SObject2Apex cp = new SObject2Apex(testAccount.Id);
        Test.stopTest();
        
        System.assert(cp.recordTemplate.contains('Site') && cp.recordTemplate.contains('uos.com/sg'));
        System.assert(cp.recordTemplate.contains('Sic') && cp.recordTemplate.contains('4437'));
        
        Date today = Date.today();
        Datetime now = Datetime.now();
        String dateformat = cp.formatField(today);
        String datetimeformat = cp.formatField(now);
        
        System.assert(dateformat == String.format(
            'Date.newInstance({0}, {1}, {2})',
            new List<String>{today.year()+'', today.month()+'', today.day()+''}
        ));
        System.assert(datetimeformat == String.format(
            'Datetime.newInstance({0}, {1}, {2}, {3}, {4}, {5})',
            new List<String>{now.year()+'', now.month()+'', now.day()+'', now.hour()+'', now.minute()+'', now.second()+''}
        ));
    }
}
