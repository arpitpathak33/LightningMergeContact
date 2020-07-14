@isTest
public class Customprofilemenutest {
    @isTest static void fetchUser() {
        customprofilemenu.fetchUser();
        User u = [select id,Name from User where id =: userInfo.getUserId() WITH SECURITY_ENFORCED ];
        System.assertEquals('0052x000001XaMEAA0', u.id,'User Id should match');
    }
    
}