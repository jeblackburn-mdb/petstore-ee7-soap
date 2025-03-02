package com.mongodb.modfac.petstore.soap;

import javax.jws.WebService;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebService(endpointInterface = "com.mongodb.modfac.petstore.soap.SayHelloEndpoint")
public class SayHelloEndpointImpl implements SayHelloEndpoint {
    
    private static final Logger log = Logger.getLogger(SayHelloEndpointImpl.class.getName());

    @Override
    public Response sayHelloThere(Greeting request) {
        log.fine("Endpoint received greeting: " + request.getGreetingText());

        String response = String.format("Hello, %s!", request.getGreetingText());

        Response responseObj = new Response();
        responseObj.setResponseText(response);

        log.log(Level.INFO, "Endpoint sending greeting='%s'", response);
        return responseObj;
    }
}
