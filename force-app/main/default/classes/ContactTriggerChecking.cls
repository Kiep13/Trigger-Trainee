public with sharing class ContactTriggerChecking {

    private static Boolean isFirst = true;

    public static Boolean checkIsFirst() {
        System.debug('Contact trigger is first: ' + isFirst);

        if(isFirst) {
            isFirst = false;
            return true;
        } else {
            return false;
        }
    }
}
