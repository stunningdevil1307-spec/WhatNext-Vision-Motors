trigger OrderTrigger on Order__c (before insert, after insert) {

    if (Trigger.isBefore && Trigger.isInsert) {
        OrderTriggerHandler.beforeInsert(Trigger.new);
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        OrderTriggerHandler.afterInsert(Trigger.new);
    }
}
