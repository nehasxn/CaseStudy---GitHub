public class GetCoordinates {
    
    public static String[] getAddressCoordinates(String commonAddress){ 
        String[] Coordinates; 
        
        String key='API key';
        String url = 'https://maps.googleapis.com/maps/api/geocode/json?';
        
        url += 'address=' +commonAddress;
        url += '&sensor=false'; 
        url += '&key='+key;
        system.debug(Logginglevel.ERROR,'GeoUtilitiesCoordinates url: ' + url);    
        
        Http h = new Http(); 
        HttpRequest req = new HttpRequest();
        
        req.setMethod('GET');
        req.setEndpoint(url); 
        system.debug('endpoint url=='+req.getEndpoint());
        String responseBody;
        if (!Test.isRunningTest()){ 
            // Methods defined as TestMethod do not support Web service callouts
            HttpResponse res = h.send(req); 
            system.debug('res // ' + res);
            responseBody = res.getBody();
        }
        else {
            // dummy data
            responseBody = '\"location\" : { \"lat\" : 32.0719776,\"lng\" : 34.7914048}';
        } 
        system.debug('responseBody == ' + responseBody);
        return Coordinates; 
    }
}