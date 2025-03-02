package com.mongodb.modfac.petstore.solace.queue;

import com.mongodb.modfac.petstore.solace.SolaceJCSMPSessionFactory;
import com.solacesystems.jcsmp.BytesXMLMessage;
import com.solacesystems.jcsmp.FlowReceiver;
import com.solacesystems.jcsmp.JCSMPException;
import com.solacesystems.jcsmp.JCSMPSession;
import com.solacesystems.jcsmp.TextMessage;
import com.solacesystems.jcsmp.XMLMessageListener;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Singleton;
import javax.ejb.Startup;

@Singleton
@Startup
public class SolaceQueueConsumer {
    
    private JCSMPSession session;
    private FlowReceiver consumer;
    
    @PostConstruct
    public void init() {
        session = SolaceJCSMPSessionFactory.createJCSMPSession();
        
        try {
            session.connect();
            consumer = session.createFlow(new XMLMessageListener() {
                @Override
                public void onReceive(BytesXMLMessage message) {
                    if (message instanceof TextMessage) {
                        System.out.printf("TextMessage received: '%s'%n", ((TextMessage) message).getText());
                    } else {
                        System.out.println("Message received.");
                    }
                    System.out.printf("Message Dump:%n%s%n", message.dump());

                    // When the ack mode is set to SUPPORTED_MESSAGE_ACK_CLIENT,
                    // guaranteed delivery messages are acknowledged after
                    // processing
                    message.ackMessage();
                }

                @Override
                public void onException(JCSMPException exception) {
                    System.out.printf("Consumer received exception: %s%n", exception);
                }
            },
                    SolaceJCSMPSessionFactory.createConsumerFlowProperties());
            consumer.start();
        } catch (JCSMPException ex) {
        }
    }
    
    @PreDestroy
    public void shutDown() {
        consumer.close();
        session.closeSession();
    }
}
