public with sharing class Questionnaire {
    public class Wrapper {
        @AuraEnabled
        public List < Progress_Bar_Question__c > pb {
            get;
            set;
        }
        @AuraEnabled
        public Boolean showPrevious {
            get;
            set;
        }
        @AuraEnabled
        public Boolean showNext {
            get;
            set;
        }
    }
    
    @AuraEnabled
    public static Integer computePercentage( String recordId){
        Integer retVal = 0;
        String query = null;
        Decimal totalVal = 0;
        Decimal actualVal = 0;
        String cu=recordId;
        List<Progress_Bar_Question__c> pb=[select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c where Object_Name__c='User' WITH SECURITY_ENFORCED];
        Map < String, List < String >> ma = new Map < String, List < String >> ();
        for(Progress_Bar_Question__c p: pb)
        {
            totalVal=totalVal+p.Weightage__c;
        }
        for (Progress_Bar_Question__c p: pb) {
            if(ma.containskey(p.Object_Name__c))
            {
                List < String > field = ma.get(p.Object_Name__c);
                field.add(p.Field_Api_Name__c+';;'+p.Weightage__c);
                ma.put(p.Object_Name__c, field);
            }
            else {
                List < String > field = new List < String > ();
                field.add(p.Field_Api_Name__c+';;'+p.Weightage__c);
                ma.put(p.Object_Name__c, field);
            }
            
        }
        for (String keys: ma.keyset()) {
            for (String ss: ma.get(keys)) {
                String field= ss.substringBefore(';;');
                String Weightage=ss.substringAfter(';;');
                Map < String, List < sObject >> m = new Map < String, List < sObject >> ();
                List < Sobject > res = Database.query('select id,'+ String.escapeSingleQuotes(field) + ' from ' + String.escapeSingleQuotes(keys) + ' ' + 'where' + ' ' + 'Id =' + ':' +'cu');
                m.put(keys, res);
                String soBjectTypeString = String.valueOf(res[0].getSObjectType());
                Type t = Type.forName('Map<String,' + soBjectTypeString + '>');
                Map < String, Sobject > sobjectMap = (Map < String, Sobject > ) t.newInstance();
                for (SObject currentSObject: res) {
                    sobjectMap.put(String.valueOf(currentSObject.get(field)), currentSObject);
                    String k = String.valueOf(currentSObject.get(field));
                    if(!String.isBlank(k))
                    {
                        if (!k.contains('/profilephoto/005/T')) {
                            actualVal = actualVal+decimal.valueOf(Weightage);
                        }
                        else if (k.contains(field))
                        {
                            actualVal = actualVal + decimal.valueOf(Weightage);
                        }
                        else
                        {
                            actualVal = actualVal;   
                        }
                        
                    }
                }
                
            }
        }
        if(totalVal == 0){
            retVal = Integer.valueOf(actualVal );
        }else if (actualVal > 0){
            retVal = Integer.valueOf( ( actualVal / totalVal ) * 100 );  
        } 
        return retVal;             
    }
    @AuraEnabled
    public static wrapper getQue(Integer recLimit, Integer recOffset) {
        Set<ID> se=new Set<ID>();
        String cu = userinfo.getUserId();
        if (recLimit == null || recOffset == null) {
            return null;
        }
        Integer localRecLimit = recLimit + 1;
        List < Progress_Bar_Question__c > pk = [select id, Question__c, Object_Name__c,Field_Api_Name__c  from Progress_Bar_Question__c WITH SECURITY_ENFORCED];
        for(Progress_Bar_Question__c p:pk)
        {  
            String query = 'select ' + p.Field_Api_Name__c + ' from ' + p.Object_Name__c + ' ' + 'where' + ' ' + 'Id =' + ':' + 'cu';  
            String use = String.valueof(Database.query(String.escapeSingleQuotes(query))); 
            if(!use.contains(p.Field_Api_Name__c) || use.contains('/profilephoto/005/T'))
            {
                se.add(p.Id);
            }
            
        }
        List < Progress_Bar_Question__c > pb = [select id, Question__c, Object_Name__c,Field_Api_Name__c  from Progress_Bar_Question__c where id  IN:se WITH SECURITY_ENFORCED LIMIT: localRecLimit OFFSET: recOffset];
        Integer pbSize = pb.size();
        if (pbSize > recLimit)
        {
            pb.remove(localRecLimit - 1);
        }
        if (!pb.isEmpty()) {
            wrapper wr = new wrapper();
            wr.pb = pb;
            wr.showPrevious = (recOffset == 0 ? false : true);
            wr.showNext = (pbSize > recLimit);
            return wr;
        } else {
            return null;
        }
    }
    @AuraEnabled
    public static Decimal getcalculateactual(String recordId) {
        Decimal totalVal = 0;
        Decimal actualVal = 0;
        Integer retVal = 0;
        List < ID > i = new List < ID > ();
        User u=[select id,contactid,accountid from User where id=:recordId WITH SECURITY_ENFORCED];
        if(!String.isEmpty(u.AccountId) && !String.isEmpty(u.ContactId))
        {
            I.add(u.AccountId);
            I.add(u.ContactId);
            I.add(recordId);            
        }
        else
        {
            I.add('0032x000005fL4iAAE');
            I.add('0012x0000075qO7AAI');
            I.add(recordId);
        }
        List < Progress_Bar_Question__c > pq = [select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c WITH SECURITY_ENFORCED];
        for (Progress_Bar_Question__c p: pq) {
            totalVal=totalVal+p.Weightage__c;
        }
        List < Progress_Bar_Question__c > pb = [select id, Weightage__c, Object_Name__c, Field_Api_Name__c from Progress_Bar_Question__c WITH SECURITY_ENFORCED];
        Map < String, List < String >> ma = new Map < String, List < String >> ();
        for (Progress_Bar_Question__c p: pb) {
            if(ma.containskey(p.Object_Name__c))
            {
                List < String > field = ma.get(p.Object_Name__c);
                field.add(p.Field_Api_Name__c+';;'+p.Weightage__c);
                ma.put(p.Object_Name__c, field);
            }
            else {
                List < String > field = new List < String > ();
                field.add(p.Field_Api_Name__c+';;'+p.Weightage__c);
                ma.put(p.Object_Name__c, field);
            }
            
        }
        for (String keys: ma.keyset()) {
            for (String ss: ma.get(keys)) {
                String field= ss.substringBefore(';;');
                String Weightage=ss.substringAfter(';;');
                Map < String, List < sObject >> m = new Map < String, List < sObject >> ();
                String querystring = 'select ' + field + ' from ' + keys + ' ' + 'where' + ' ' + 'Id' + ' ' + 'IN' + ':' + 'I';
                List < Sobject > res = Database.query(String.escapeSingleQuotes(querystring ));
                m.put(keys, res);
                String soBjectTypeString = String.valueOf(res[0].getSObjectType());
                Type t = Type.forName('Map<String,' + soBjectTypeString + '>');
                Map < String, Sobject > sobjectMap = (Map < String, Sobject > ) t.newInstance();
                for (SObject currentSObject: res) {
                    sobjectMap.put(String.valueOf(currentSObject.get(field)), currentSObject);
                    String k = String.valueOf(currentSObject.get(field));
                    if (!String.isBlank(k)) {
                        if (!k.contains('/profilephoto/005/T') || k.contains(field))
                        {
                            actualVal = actualVal + decimal.valueOf(Weightage);
                        }
                        else
                        {
                            actualVal=actualval;
                        }
                    }
                }
                if(totalVal == 0){
                    retVal = Integer.valueOf(actualVal );
                }else if (actualVal > 0){
                    retVal = Integer.valueOf( ( actualVal / totalVal ) * 100 );  
                } 
            }
        }
        
        return retVal;
    }
}