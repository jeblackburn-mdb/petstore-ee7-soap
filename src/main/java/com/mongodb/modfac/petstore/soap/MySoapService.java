package com.mongodb.modfac.petstore.soap;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public interface MySoapService {

    @WebMethod
    String sayHello(String name);
}