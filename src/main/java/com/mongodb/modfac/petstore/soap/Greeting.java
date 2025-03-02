
package com.mongodb.modfac.petstore.soap;


import javax.xml.bind.annotation.*;

@XmlRootElement(name = "greeting")
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name="greeting", propOrder={"greetingText"})
public class Greeting {

    @XmlElement(name = "greeting-text")
    protected String greetingText;

    /**
     * Gets the value of the greetingText property.
     *
     * @return
     *     possible object is
     *     {@link String }
     *
     */
    public String getGreetingText() {
        return greetingText;
    }

    /**
     * Sets the value of the greetingText property.
     *
     * @param value
     *     allowed object is
     *     {@link String }
     *
     */
    public void setGreetingText(String value) {
        this.greetingText = value;
    }

}
