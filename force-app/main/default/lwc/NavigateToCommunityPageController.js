({    invoke : function(component, event, helper) {  
    var slug = component.get("v.pageSlug"); 
    var aUrl = "/"+slug;
    var urlEvent = $A.get("e.force:navigateToURL");
 
// Set the URL
urlEvent.setParams({
   "url": aUrl,
   "isredirect":true
 });
     
// Navigate
urlEvent.fire();
}})