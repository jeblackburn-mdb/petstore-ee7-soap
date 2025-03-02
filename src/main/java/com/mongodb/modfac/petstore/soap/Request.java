package com.mongodb.modfac.petstore.soap;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import java.util.List;
import java.util.Map;

@XmlRootElement(name = "ComplexRequest")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ComplexRequest", propOrder = { "items", "attributes", "customData" })
public class Request {

    @XmlElement(name = "items")
    private List<Item> items;

    @XmlElement(name = "attributes")
    private Map<String, String> attributes;  // Note: JAXB does not serialize Map<String, String> directly

    @XmlElement(name = "customData")
    private CustomType customData;

    public Request() {}

    public List<Item> getItems() { return items; }
    public void setItems(List<Item> items) { this.items = items; }

    public Map<String, String> getAttributes() { return attributes; }
    public void setAttributes(Map<String, String> attributes) { this.attributes = attributes; }

    public CustomType getCustomData() { return customData; }
    public void setCustomData(CustomType customData) { this.customData = customData; }
}