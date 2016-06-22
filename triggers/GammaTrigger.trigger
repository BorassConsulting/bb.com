/*
* I decided to write a trigger that will integrate with another salesforce instance 
* when Gamma__c custom object is save or modified it sends a json request via rest
* to create this object on the secound salesforce instance.
* I know that there is an interesting trigger framework https://github.com/kevinohara80/sfdc-trigger-framework/blob/master/src/classes/TriggerHandler.cls
* but I have never seen this framework in any company therefore for this exercise I decided to write my own simple trigger 
* framework. May be in future i will start to use only the framework from given url because it looks promissing. 
*/

trigger GammaTrigger on Gamma__c (
	before insert, 
	before update, 
	before delete, 
	after insert, 
	after update, 
	after delete, 
	after undelete) {
		if( TriggerUtils.skipTrigger( TriggerDictionary.GAMMA_TRIGGER_NAME ) == false  ){
			executeTrigger();	
		}

		public static void executeTrigger(){ // quite interesting pattern but it is legal. You can write static methods inside a trigger 
			if( Trigger.isBefore ){
		    	if( Trigger.isInsert ){
		    		GammaTriggerHelper.beforeInsert( Trigger.newMap );//we have to think about bulkyfy
		    	} else if( Trigger.isUpdate ){
		    		GammaTriggerHelper.beforeUpdate( Trigger.newMap );//we have to think about bulkyfy
	    		} else if( Trigger.isDelete ){
					GammaTriggerHelper.beforeDelete( Trigger.newMap );//we have to think about bulkyfy
	    		}	    
			} else if (Trigger.isAfter) {
		    	if( Trigger.isInsert ){
		    		GammaTriggerHelper.afterInsert( Trigger.newMap );//we have to think about bulkyfy
		    	} else if( Trigger.isUpdate ){
					GammaTriggerHelper.afterUpdate( Trigger.oldMap, Trigger.newMap );//we have to think about bulkyfy
	    		} else if( Trigger.isDelete ){
					GammaTriggerHelper.afterDelete( Trigger.oldMap );//we have to think about bulkyfy
	    		} else if( Trigger.isUnDelete ){	
	    			GammaTriggerHelper.afterUndelete( Trigger.newMap );//we have to think about bulkyfy
	    		}
		    
			}
		}
		
}