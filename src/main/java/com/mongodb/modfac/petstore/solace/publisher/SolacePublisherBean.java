package com.mongodb.modfac.petstore.solace.publisher;

import com.mongodb.modfac.petstore.solace.SolaceMessagingServiceFactory;
import static com.mongodb.modfac.petstore.solace.SolaceConstants.*;
import com.solace.messaging.publisher.DirectMessagePublisher;
import com.solace.messaging.publisher.OutboundMessage;
import com.solace.messaging.publisher.OutboundMessageBuilder;
import com.solace.messaging.receiver.InboundMessage;
import com.solace.messaging.resources.Topic;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Initialized;
import javax.enterprise.event.Observes;
import javax.inject.Named;

@Named
@ApplicationScoped
public class SolacePublisherBean {

    private DirectMessagePublisher publisher;

    public void onStart(@Observes @Initialized(ApplicationScoped.class) Object pointless) {
        System.out.println("SolacePublisherBean.onStart()");
    }

    @PostConstruct
    public void init() {
        // create and start the publisher 
        publisher = SolaceMessagingServiceFactory.createPublisher();
        System.out.println("[SolacePublisherBean] ");

    }
    
    public void publish(String payload, String topicSuffix) {
        OutboundMessageBuilder messageBuilder = SolaceMessagingServiceFactory.createMessageBuilder();
        
        try {
            OutboundMessage message = messageBuilder.build(payload);

            String topicString = TOPIC_PREFIX + topicSuffix;
            System.out.printf(">> Calling send() on %s%n",topicString);
            publisher.publish(message, Topic.of(topicString));
        } catch (RuntimeException e) {
            System.out.printf("### Exception caught during SolacePublisherBean.publish(): %s%n",e);
        }
    }
    
    public void onMessage(InboundMessage im){
        System.out.printf("vvv RECEIVED A MESSAGE vvv%n%s===%n", im.dump());
    }
    
    @PreDestroy
    public void me() {
        publisher.terminate(500);
        System.out.println("quitting.");
    }
}
