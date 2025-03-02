
package com.mongodb.modfac.petstore.soap;

import javax.xml.bind.annotation.*;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "response", propOrder = {
    "responseText"
})
@XmlRootElement(name = "response")
public class Response {

    @XmlElement(name = "response-text")
    protected String responseText;

    /**
     * Gets the value of the responseText property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getResponseText() {
        return responseText;
    }

    /**
     * Sets the value of the responseText property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setResponseText(String value) {
        this.responseText = value;
    }

}
