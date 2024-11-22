trigger ContactTrigger on Contact (after insert, after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        ContactLocationHandler.ContactLocationHandler(trigger.new);
    }
}