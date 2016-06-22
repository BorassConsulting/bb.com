public with sharing class PaginationController {
    public boolean displayNext{get; private set;}
    public boolean displayPrev{get; private set;}
    public List<BB_A__c> bbas{get; private set;}	
    private Integer offsetSize = 0;
    private Integer recordLimit  = 10;

    
    public PaginationController() {
         calculateBbas();
         displayPrev = false;
         displayNext = true;
    }

    public PageReference next(){
        offsetSize = offsetSize + 10;
        calculateBbas();
        return null;
    }

    public PageReference prev(){
        offsetSize = offsetSize + 10;
         calculateBbas();
        return null;
    }

    private void calculateBbas(){
        bbas = [select Id, Name, X__c, Y__c, Flag__c, Counter__c from BB_A__c order by Counter__c limit :recordLimit offset :offsetSize];    
    }   
    
}