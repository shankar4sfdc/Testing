	@AuraEnabled
    public static List<String> getMonths(){
		Date d1 = Date.Today().AddMonths(-12);
		Date d2 = Date.Today();
		List<String> monthYearSet = new List<String>();

        while(d1 < d2)
        {
            String yearOfProduct =  String.valueOf(d1.Year());                        
            String monthYear = d1.Month() + '-' + yearOfProduct.substring(2,2);            
            monthYearSet.add(d1.Month() + '-' + yearOfProduct.substring(2,2));
            d1.addMonths(1);
        }
        
        System.Debug(monthYearSet);
        
        return monthYearSet;
    }