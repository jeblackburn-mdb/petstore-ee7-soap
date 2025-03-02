package com.mongodb.modfac.petstore.solace.subscribers;

import com.mongodb.modfac.petstore.solace.SolaceMessagingServiceFactory;
import com.solace.messaging.receiver.DirectMessageReceiver;
import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import com.solace.messaging.receiver.InboundMessage;
import javax.annotation.PreDestroy;

@Singleton
@Startup
public class SolaceSubscriberSingleton {

    private DirectMessageReceiver receiver;
    
    @PostConstruct
    public void init() {
        // create and start the receiver
        receiver = SolaceMessagingServiceFactory.createReceiver("ejb");
        receiver.receiveAsync(this::onMessage);
    }
    
    public void onMessage(InboundMessage im){
        System.out.printf("vvv RECEIVED A MESSAGE vvv%n%s===%n", im.dump());
    }
    
    @PreDestroy
    public void me() {
        receiver.terminate(500);
        System.out.println("quitting.");
    }
}
