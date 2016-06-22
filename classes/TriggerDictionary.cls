/* This class is being used to keep names of the trigger that we will futher use in the code. (for example to skip a trigger.) I prefer to 
 * do it in this way because because if it is written as a plain code in many places of application we can be sure that somebody will do a spelling mistake 
 * and then another trigger can be skipped ( i had this situation during my experience with salesforce. It was a nightmare to investigate)
 *
 */



public class TriggerDictionary {
	public static final String GAMMA_TRIGGER_NAME = 'Gamma_Trigger'; 


	private TriggerDictionary() {} // we do not want to create an instance of this class this is only a dictionary
}