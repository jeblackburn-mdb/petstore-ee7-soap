package com.mongodb.modfac.petstore.soap;

import javax.jws.WebService;

@WebService(endpointInterface = "com.mongodb.modfac.petstore.soap.ComplexService")
public class ComplexServiceImpl implements ComplexService {

    @Override
    public String processComplexRequest(Request request) {
        // Procesamos los datos
        StringBuilder response = new StringBuilder("Received Complex Request:\n");

        if (request.getItems() != null) {
            request.getItems().forEach(item -> response.append("Item: ").append(item.getId()).append(" - ").append(item.getName()).append("\n"));
        }

        if (request.getAttributes() != null) {
            request.getAttributes().forEach((key, value) -> response.append("Attribute: ").append(key).append(" = ").append(value).append("\n"));
        }

        if (request.getCustomData() != null) {
            response.append("Custom Data: ").append(request.getCustomData().getValue()).append("\n");
        }

        return response.toString();
    }
}