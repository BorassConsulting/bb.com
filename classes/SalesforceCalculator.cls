global class SalesforceCalculator {

	webservice String parameter { get; set; }

	public SalesforceCalculator() {
		this.parameter = 'value';
	}

	webservice 	static Integer add(Integer a, Integer b){
		return a + b;
	}
}