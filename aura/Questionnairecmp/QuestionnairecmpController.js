({
    getQuestions : function(component, event, helper) {
        helper.doInit(component,event,helper);
        helper.computeProgressz(component,event,helper);
    },
    showPrevious : function(component, event, helper) {
        var wrapper = component.get("v.wrapper");
        if(wrapper.showPrevious) {
            var limit = component.get("v.limit");
            var offset = component.get("v.offset");
            if(offset>0)
            {
                component.set("v.offset", (offset - limit));
            }
            helper.doInit(component,event,helper);
            helper.computeProgressz(component,event,helper);
            
        }
    },
    
    showNext : function(component, event, helper) {
        var wrapper = component.get("v.wrapper");
        if(wrapper.showNext) {
            var limit = component.get("v.limit");
            var offset = component.get("v.offset");
            console.log('Offset--->'+offset);
            console.log('Limit--->'+limit);
            
            
                component.set("v.offset", (offset + limit));
            
            helper.doInit(component,event,helper);
            helper.computeProgressz(component,event,helper);
            
        }
        
    },
    Updates:function(component,event,helper){
        var obj =  event.getSource().get("v.value");
        var fields =  event.getSource().get("v.title");
        console.log(obj);
        console.log(fields);
        component.set("v.objects",obj);
        component.set("v.fields",fields);
        if(obj=='User' && fields=='smallphotourl'){
            component.set("v.uploads",true);
        } else{
            component.set("v.truthy",true);
        }
        helper.doInit(component,event,helper);
        
    }
})