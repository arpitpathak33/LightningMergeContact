public with sharing class ProfileModalController {
    
    @AuraEnabled
    public static string updateProfile(string obj,string flds){
        System.debug('Object------>'+obj   +'================='+flds);
        String objectName = obj;
        String fieldName = flds;
        SObjectType r = ((SObject)(Type.forName('Schema.'+objectName).newInstance())).getSObjectType();
        DescribeSObjectResult d = r.getDescribe();
        String types = string.valueof(d.fields.getMap().get(fieldName).getDescribe().getType());
          System.debug('Type------>'+types);
        return types; 
    }
    @AuraEnabled
    public static string updateRecord(string obj,string flds,string inputValues){
        list<Id> ids=new list<Id>();
        Id conId = '0032x000005fL4iAAE';
        Id accId = '0012x0000075qO7AAI';
        Id userId= UserInfo.getUserId();
        ids.add(conId);
        ids.add(accId); 
        ids.add(userId);  
        String objectName = obj;
		String fieldName = flds;
        SObjectType r = ((SObject)(Type.forName('Schema.'+objectName).newInstance())).getSObjectType();
	    DescribeSObjectResult d = r.getDescribe();
        String types = string.valueof(d.fields.getMap().get(fieldName).getDescribe().getType());
        list<sobject> obs = Database.query(String.escapeSingleQuotes('Select Id,' + flds + ' FROM '+obj+' WHERE ID IN:ids'));
        for(sobject ob:obs){
            if(types == 'DATE'){
                Date dt = Date.valueOf( inputValues );
                ob.put(flds,dt);
            } else {
                ob.put(flds,inputValues);
            }
            update ob;
        }
        return obj+' '+flds;
    }
}