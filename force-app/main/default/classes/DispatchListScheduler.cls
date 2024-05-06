global class DispatchListScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        String USERNAME = 'Nexus Masterbilt';
        String PASSWORD = 'HW07O#gkAB';
        // Construct SOAP request
        String soapRequest = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:nex="http://nexus.officetrax.com/">' +
                                '<soapenv:Header/>' +
                                '<soapenv:Body>' +
                                    '<nex:GetNewDispatchList>' +
                                        '<nex:WSUser>' +
                                            '<nex:Name>'+USERNAME+'</nex:Name>' +
                                            '<nex:Password>'+PASSWORD+'</nex:Password>' +
                                        '</nex:WSUser>' +
                                    '</nex:GetNewDispatchList>' +
                                '</soapenv:Body>' +
                             '</soapenv:Envelope>';
        
        // Send SOAP request to API endpoint
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://nexus.dollartree.core7.net/Service.asmx'); //API endpoint URL
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', 'http://nexus.officetrax.com/GetNewDispatchList');
        request.setHeader('Content-length', '402');
        request.setBody(soapRequest);
        HttpResponse response = http.send(request);
        
        // Process SOAP response
        if (response.getStatusCode() == 200) {
            String soapResponse = response.getBody();
            // Parse the SOAP response and process the data as needed
            // You can call the parseSoapResponse method from the previous example to parse the response
            // SoapApiParser.parseSoapResponse(soapResponse);
        } else {
            System.debug('SOAP API request failed with status code: ' + response.getStatusCode());          
        }
    }
}