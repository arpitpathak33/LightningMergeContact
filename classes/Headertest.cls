@isTest
public class Headertest {
    @isTest static void converttointegertest() {
       Header.converttointeger(50.91);
       Integer intConvertedValue = 50.91.intValue();
       System.assertEquals(50, intConvertedValue,'Value should be converted to integer');
    }
    
}