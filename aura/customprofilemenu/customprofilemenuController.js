({
    doInit: function (component, event, helper) {
        var action = component.get("c.fetchUser");
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.userInfo", storeResponse);
            }
        });
        $A.enqueueAction(action);
    },
    
    handleClick: function (component, event, helper) {
        var source = event.getSource();
        var label = source.get("v.label");
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        console.log("label---->" + label);
        var urlEvent = $A.get("e.force:navigateToURL");
        if(label === 'Home') {
            urlEvent.setParams({
                "url": '/'
            });
        } 
        else if(label === 'My Profile') {
            urlEvent.setParams({
                "url": '/profile/home'
            });
        } 
            else if(label === 'Log Out') {
                window.location.replace("https://profiletracker1-dev-ed.my.salesforce.com/servlet/networks/switch?startURL=%2Fsecur%2Flogout.jsp");   
                
            } 
                else {
                    return null;
                }
        urlEvent.fire();
    }
})