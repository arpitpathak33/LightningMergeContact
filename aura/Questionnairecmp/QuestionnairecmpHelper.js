({
    doInit : function(component) {
        var action = component.get("c.getQue");
        
        action.setParams({
            "recLimit": component.get("v.limit"),
            "recOffset": component.get("v.offset")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                component.set("v.wrapper", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
    computeProgressz : function(component, event, helper)  {
        var action = component.get('c.getcalculateactual');
        action.setParams({
            
            recordId : $A.get("$SObjectType.CurrentUser.Id"),
            sObjectName : 'User',
            totalValueFieldName : 'User',
            actualValueFieldName : 'txt_actualVal'
        });
        action.setCallback(this, function(a) {
            if (a.getState() === 'SUCCESS') {
                var percVal = a.getReturnValue() ; 
                var progressVal = parseInt((percVal/100) * 360) ;
                component.set("v.cirDeg" , progressVal);
                component.set("v.perText" , parseInt(percVal)  +'%' ); 
                var cmpEvnt=component.getEvent("regInChild");
                cmpEvnt.setParams({
                    storeMessage :  percVal    
                });
                cmpEvnt.fire();
                var evt = $A.get("e.c:Result");
                evt.setParams({ "Pass_Result": percVal});
                evt.fire();
            }  
        });
        $A.enqueueAction(action); 
    }
})