package com.mongodb.modfac.petstore.solace.queue;

import com.mongodb.modfac.petstore.solace.SolaceJCSMPSessionFactory;
import com.solacesystems.jcsmp.DeliveryMode;
import com.solacesystems.jcsmp.JCSMPException;
import com.solacesystems.jcsmp.JCSMPFactory;
import com.solacesystems.jcsmp.JCSMPSession;
import com.solacesystems.jcsmp.JCSMPStreamingPublishCorrelatingEventHandler;
import com.solacesystems.jcsmp.Queue;
import com.solacesystems.jcsmp.TextMessage;
import com.solacesystems.jcsmp.XMLMessageProducer;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.ejb.Singleton;
import javax.ejb.Startup;

@Singleton
@Startup
public class SolaceQueueProducer {

    private JCSMPSession session;
    private Queue queue;
    private XMLMessageProducer prod;
    
    @PostConstruct
    public void init() {
        session = SolaceJCSMPSessionFactory.createJCSMPSession();
        
        try {
            session.connect();
            queue = SolaceJCSMPSessionFactory.createQueue();
            prod = session.getMessageProducer(new JCSMPStreamingPublishCorrelatingEventHandler() {
                
                @Override
                public void responseReceivedEx(Object key) {
                    System.out.printf("Producer received response for msg ID #%s%n", key);
                }

                @Override
                public void handleErrorEx(Object key, JCSMPException cause, long timestamp) {
                    System.out.printf("Producer received error for msg ID %s @ %s - %s%n", key,timestamp,cause);
                }
            });
        } catch (JCSMPException ex) {
        }
    }
    
    @PreDestroy
    public void shutDown() {
        session.closeSession();
    }
    
    public void createMessageForQueue(String textToSend) {
        TextMessage msg = JCSMPFactory.onlyInstance().createMessage(TextMessage.class);
        msg.setDeliveryMode(DeliveryMode.PERSISTENT);

        msg.setText(textToSend);
        
        try {
            // Send message directly to the queue
            prod.send(msg, queue);
        } catch (JCSMPException ex) {
        }
	    
        System.out.println("Message sent.");
    }
}
