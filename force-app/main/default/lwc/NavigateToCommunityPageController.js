({    invoke : function(component, event, helper) {  
    // Get the Lightning event that opens a URL
    var urlEvent = $A.get("e.force:navigateToURL");

    //Find the text value of the component with aura:id set to "pageSlug"
    var slug = component.find("pageSlug").get("v.value");
     
    // Set the URL
    urlEvent.setParams({
       "url": slug
     });
         
    // Navigate
    urlEvent.fire();
 }})