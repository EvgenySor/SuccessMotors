public class PriceBookFill {
    private Pricebook2 stdPriceBook;
    private List <PricebookEntry> pricesList;
    private List <Product2> productsList;
    
    public PriceBookFill() {
        stdPriceBook = getStdPriceBook();
        getProducts();
    }
    
    private Pricebook2 getStdPriceBook() {
        if (stdPriceBook == null) 
            stdPriceBook    = [select ID, name from Pricebook2 where isStandard = true limit 1];
        return stdPriceBook;    
    }
    
    private void getProducts() {
        productsList = [SELECT ID, Name FROM Product2 WHERE Type__c != NULL];
    }
    
    public void generatePrices() {
        List <PriceBookEntry> pbEntry = new List <PriceBookEntry>();
        for (Product2 prd : productsList) {
            PricebookEntry pbe = new PricebookEntry(
                Pricebook2Id = stdPriceBook.Id, Product2Id = prd.Id,
                UnitPrice = Integer.valueof((Math.random() * 25000)), IsActive = true);
            
            pbEntry.add(pbe);
        }
    
        if(!pbEntry.isEmpty())
            insert pbEntry;
    }
}