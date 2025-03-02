package com.mongodb.modfac.petstore.solace.publisher;

import com.mongodb.modfac.petstore.solace.SolaceMessagingServiceFactory;
import com.solace.messaging.publisher.DirectMessagePublisher;
import com.solace.messaging.publisher.OutboundMessage;
import com.solace.messaging.publisher.OutboundMessageBuilder;
import com.solace.messaging.resources.Topic;
import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.Startup;
import static com.mongodb.modfac.petstore.solace.SolaceConstants.*;
import com.solace.messaging.receiver.InboundMessage;
import javax.annotation.PreDestroy;

@Singleton
@Startup
public class SolacePublisherSingleton {
    
    private DirectMessagePublisher publisher;
    
    @PostConstruct
    public void init() {
        // create and start the publisher 
        publisher = SolaceMessagingServiceFactory.createPublisher();

    }
    
    public void publish(String payload, String topicSuffix) {
        OutboundMessageBuilder messageBuilder = SolaceMessagingServiceFactory.createMessageBuilder();
        
        try {
            OutboundMessage message = messageBuilder.build(payload);

            String topicString = TOPIC_PREFIX + topicSuffix;
            System.out.printf(">> Calling send() on %s%n",topicString);
            publisher.publish(message, Topic.of(topicString));
        } catch (RuntimeException e) {
            System.out.printf("### Exception caught during producer.send(): %s%n",e);
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
