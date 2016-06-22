public with sharing class TriggerUtils {
	public static final String DEFAULT_CONFIGURATION = 'DefaultConfiguration';
	private static Trigger_Configuration__c triggersConfiguration = Trigger_Configuration__c.getInstance( DEFAULT_CONFIGURATION );

	private void  TriggerUtils() {}

	public static boolean skipTrigger( String triggerName ){
		// I have to add error managemant here
		// for example what should be done when default configuration is not crated or it does not have field that is 
		// related to given trigger

		return ( boolean )triggersConfiguration.get( 'Skip_' + triggerName + '__c' );
	}
}