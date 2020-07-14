public class Customprofilemenu {
    @AuraEnabled 
    public static user fetchUser(){
        User u = [select id,Name from User where id =: userInfo.getUserId()];
        return u;
    }
    
}