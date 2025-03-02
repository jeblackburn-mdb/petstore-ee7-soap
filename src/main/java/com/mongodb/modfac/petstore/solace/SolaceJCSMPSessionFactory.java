package com.mongodb.modfac.petstore.solace;

import com.solacesystems.jcsmp.ConsumerFlowProperties;
import com.solacesystems.jcsmp.InvalidPropertiesException;
import com.solacesystems.jcsmp.JCSMPFactory;
import com.solacesystems.jcsmp.JCSMPProperties;
import com.solacesystems.jcsmp.JCSMPSession;
import com.solacesystems.jcsmp.Queue;

public class SolaceJCSMPSessionFactory {
    
    private static final JCSMPProperties PROPERTIES;
    
    static {
        PROPERTIES = new JCSMPProperties();
        PROPERTIES.setProperty(JCSMPProperties.HOST, SolaceConstants.HOST + ":" + SolaceConstants.PORT);
        PROPERTIES.setProperty(JCSMPProperties.USERNAME, SolaceConstants.USER);
        PROPERTIES.setProperty(JCSMPProperties.VPN_NAME,  SolaceConstants.VPN);
        PROPERTIES.setProperty(JCSMPProperties.PASSWORD, SolaceConstants.PASSWORD);
        PROPERTIES.setProperty(JCSMPProperties.GENERATE_SEQUENCE_NUMBERS, true);
    }
    
    public static JCSMPSession createJCSMPSession() {
        try {
            return JCSMPFactory.onlyInstance().createSession(PROPERTIES);
        } catch (InvalidPropertiesException ex) {
            return null;
        }
    }
    
    public static Queue createQueue() {
        return JCSMPFactory.onlyInstance().createQueue(SolaceConstants.QUEUE_NAME);
    }
    
    public static ConsumerFlowProperties createConsumerFlowProperties() {
        final ConsumerFlowProperties flowProp = new ConsumerFlowProperties();
        flowProp.setEndpoint(createQueue());
        flowProp.setAckMode(JCSMPProperties.SUPPORTED_MESSAGE_ACK_CLIENT);
        
        return flowProp;
    }
}
