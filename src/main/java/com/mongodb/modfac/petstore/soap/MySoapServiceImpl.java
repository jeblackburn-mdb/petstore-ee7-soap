package com.mongodb.modfac.petstore.soap;

import javax.jws.WebService;

@WebService(endpointInterface = "com.mongodb.modfac.petstore.soap.MySoapService")
public class MySoapServiceImpl implements MySoapService {

    @Override
    public String sayHello(String name) {
        return "Hello, " + name + "!";
    }
}
