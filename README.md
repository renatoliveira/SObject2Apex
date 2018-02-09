# SObject2Apex

Reads a record from Salesforce and displays its data on the console so it is easier to copy data for creating a test.

## But why

At some point while testing a fairly big system, when faced with bugs in production, I would take some time to figure out what was wrong. After finding what was wrong, it is always good to write a test case so that doesn't happen anymore.

The catch here is that sometimes you find bugs in processes that use custom objects that rely on lots of other records in a huge process. Writing the correct data can take a while, specially if you are trying to reproduce conditions that were achieved with production data.

This class reads a record and displays its writeable data in Apex code on the console, so it is possible to copy the line from the console and make little to no modifications to it (references to other records are not included);

## Usage

Open up your anonymous execution console, and pass the Id of the record you want to copy data from, like the following:

```java
SObject2Apex cp = new SObject2Apex ('0010a00001LoSioAAF');
```

This will produce a debug on your console like the following:

```
03:40:06:084 USER_DEBUG [25]|DEBUG|Account record = new Account(Name='United Oil & Gas, Singapore', Type='Customer - Direct', BillingStreet='9 Tagore Lane
03:40:06:000 USER_DEBUG Singapore, Singapore 787472
03:40:06:000 USER_DEBUG Singapore', BillingCity='Singapore', BillingState='Singapore', ShippingStreet='9 Tagore Lane
03:40:06:000 USER_DEBUG Singapore, Singapore 787472
03:40:06:000 USER_DEBUG Singapore', Phone='(650) 450-8810', Fax='(650) 450-8820', AccountNumber='CD355120-B', Website='http://www.uos.com', Sic='4437', Industry='Energy', NumberOfEmployees=3000, Ownership='Public', TickerSymbol='UOS', Site='uos.com/sg', OwnerId='0050a00000JOpDgAAL', CleanStatus='Pending', CustomerPriority__c='High', SLA__c='Platinum', Active__c='Yes', NumberofLocations__c=6, UpsellOpportunity__c='Maybe', SLASerialNumber__c='2457', SLAExpirationDate__c=Date.newInstance(2018, 9, 3));
```

A custom object called `Payment__c` with three custom fields (Account, Date and Amount) would look like this on the log:

```
03:49:26:033 USER_DEBUG [25]|DEBUG|Payment__c record = new Payment__c(Amount__c=347.85, Date__c=DateTime.newInstance(2020, 2, 10, 0, 51, 32));
```

After copying and removing the console part, the code is just plain Apex:

```Apex
Payment__c record = new Payment__c(
    Amount__c=347.85,
    Date__c=DateTime.newInstance(2020, 2, 10, 0, 51, 32)
);
```
