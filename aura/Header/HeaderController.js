({
    getValueFromApplicationEvent : function(component, event, helper) {
        var ShowResultValue = event.getParam("Pass_Result");
        component.set("v.Get_Result",ShowResultValue );
    }
})