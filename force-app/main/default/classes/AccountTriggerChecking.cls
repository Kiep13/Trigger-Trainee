public with sharing class AccountTriggerChecking {

    private static Boolean isFirst = true;

    public static Boolean checkIsFirst() {
        System.debug('Account trigger is first: ' + isFirst);
        if(isFirst) {
            isFirst = false;
            return true;
        } else {
            return false;
        }
    }
}
