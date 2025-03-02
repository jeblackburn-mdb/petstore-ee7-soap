package com.mongodb.modfac.petstore.soap;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

@WebService(name = "SayHello")
@SOAPBinding(style = SOAPBinding.Style.DOCUMENT)
public interface SayHelloEndpoint {
    
    @WebMethod
    Response sayHelloThere(@WebParam(name="greeting") Greeting request);
}
