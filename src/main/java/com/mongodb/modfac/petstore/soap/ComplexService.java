package com.mongodb.modfac.petstore.soap;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

@WebService(name = "ComplexService")
@SOAPBinding(style = SOAPBinding.Style.DOCUMENT)
public interface ComplexService {

    @WebMethod
    String processComplexRequest(@WebParam(name = "request") Request request);
}