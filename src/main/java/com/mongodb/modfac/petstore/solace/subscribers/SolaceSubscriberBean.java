package com.mongodb.modfac.petstore.solace.subscribers;

import com.mongodb.modfac.petstore.solace.SolaceMessagingServiceFactory;
import com.solace.messaging.receiver.DirectMessageReceiver;
import com.solace.messaging.receiver.InboundMessage;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Initialized;
import javax.enterprise.event.Observes;
import javax.inject.Named;

@Named
@ApplicationScoped
public class SolaceSubscriberBean {

    private DirectMessageReceiver receiver;

    public void onStart(@Observes @Initialized(ApplicationScoped.class) Object pointless) {
        System.out.println("InitializerOnStart.onStart() ");
    }

   @PostConstruct
    public void init() {
        // create and start the receiver
        receiver = SolaceMessagingServiceFactory.createReceiver("applicationScoped");
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
