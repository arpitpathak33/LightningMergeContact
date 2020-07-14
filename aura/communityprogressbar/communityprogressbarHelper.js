({ 
    computeProgress : function(component, event, helper)  {
        var action = component.get('c.computePercentage');
        action.setParams({
            
            recordId : $A.get("$SObjectType.CurrentUser.Id"),
        });
        action.setCallback(this, function(a) {
            if (a.getState() === 'SUCCESS') {
                var percVal = a.getReturnValue() ; 
                var progressVal = parseInt(  (percVal/100) * 360  ) ;
                var evt = $A.get("e.c:Result");
                evt.setParams({ "Pass_Result": percVal});
                evt.fire();
                component.set("v.cirDeg" , progressVal );
                component.set("v.perText" , parseInt(percVal)  +'%' );              
            }  
        });
        $A.enqueueAction(action); 
    }
    
})