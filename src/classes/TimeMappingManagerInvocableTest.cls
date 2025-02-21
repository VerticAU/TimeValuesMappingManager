@isTest
public class TimeMappingManagerInvocableTest {

    @isTest
    static void testProcess() {
        Task sourceTask = new Task(
                ActivityDate = Date.today().addDays(-10)
        );
        insert sourceTask;

        Task targetTask = new Task();
        insert targetTask;

        TimeMappingManagerInvocable.InvocableRequest request = new TimeMappingManagerInvocable.InvocableRequest();
        request.sourceRecordId = sourceTask.Id;
        request.targetRecordId = targetTask.Id;
        request.sourceField1ApiName = 'ActivityDat';
        request.targetField1ApiName = 'ActivityDate';

        List<TimeMappingManagerInvocable.InvocableRequest> requests = new List<TimeMappingManagerInvocable.InvocableRequest>();
        requests.add(request);

        Test.startTest();
        TimeMappingManagerInvocable.process(requests);
        Test.stopTest();

        Task updatedTarget = [SELECT Id, ActivityDate FROM Task WHERE Id = :targetTask.Id];

        System.assertEquals(sourceTask.ActivityDate, updatedTarget.ActivityDate, 'Field 1 should be copied from source to target.');
    }
}