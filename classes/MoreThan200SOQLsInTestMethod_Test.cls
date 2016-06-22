@isTest
public class MoreThan200SOQLsInTestMethod_Test {
	@isTest
	public static void MoreThan200SOQLsInTestMethod() {

		System.assertEquals(0, countBbcs());

		
		//mssi.startScript();	

		Test.startTest();
			
			//System.assertEquals(450, countBbcs());

			//List<BB_C__c> bbcs = [select id, name, X__c from BB_C__c];
			//delete bbcs;

			//System.assertEquals(0, countBbcs());	
			MultiStepScriptImplementation mssi = new MultiStepScriptImplementation();
			mssi.startScript();	

		Test.stopTest();

		System.assertEquals(450, countBbcs());
	}



	private static Integer countBbcs(){
		List<AggregateResult> resultsGroups = [SELECT count(id) theCount from BB_C__c];
		AggregateResult results = resultsGroups[0];
		Integer theCount = (Integer)results.get('theCount');
		return theCount;
	}	
}