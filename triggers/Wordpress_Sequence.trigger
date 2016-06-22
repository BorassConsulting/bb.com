trigger Wordpress_Sequence on Wordpress_Sequence__c (before insert, after insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        beforeInsert();
    } else if (Trigger.isAfter && Trigger.isInsert){
        afterInsert();
    }
    
    public static void beforeInsert(){
        System.debug('BB before new:' + trigger.new + ' old:' + trigger.old);
    }
    
    public static void afterInsert(){
        System.debug('BB after new:' + trigger.new + ' old:' + trigger.old);
    }
    
}