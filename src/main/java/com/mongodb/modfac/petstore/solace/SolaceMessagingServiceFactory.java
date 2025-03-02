package com.mongodb.modfac.petstore.solace;

import static com.mongodb.modfac.petstore.solace.SolaceConstants.*;
import com.solace.messaging.MessagingService;
import com.solace.messaging.config.SolaceProperties;
import com.solace.messaging.config.profile.ConfigurationProfile;
import com.solace.messaging.publisher.DirectMessagePublisher;
import com.solace.messaging.publisher.OutboundMessageBuilder;
import com.solace.messaging.receiver.DirectMessageReceiver;
import com.solace.messaging.resources.TopicSubscription;
import java.util.Properties;

public class SolaceMessagingServiceFactory {
    
    private static final MessagingService messagingService;
    
    static {
        final Properties properties = new Properties();
        properties.setProperty(SolaceProperties.TransportLayerProperties.HOST, HOST + ":" + PORT);
        properties.setProperty(SolaceProperties.ServiceProperties.VPN_NAME, VPN);
        properties.setProperty(SolaceProperties.AuthenticationProperties.SCHEME_BASIC_USER_NAME, USER);
        properties.setProperty(SolaceProperties.AuthenticationProperties.SCHEME_BASIC_PASSWORD, PASSWORD);
        properties.setProperty(SolaceProperties.ServiceProperties.RECEIVER_DIRECT_SUBSCRIPTION_REAPPLY, "true");

        messagingService = MessagingService.builder(ConfigurationProfile.V1).fromProperties(properties).build().connect();
    }
    
    public static DirectMessagePublisher createPublisher() {
        return messagingService.createDirectMessagePublisherBuilder().onBackPressureWait(1).build().start();
    }
    
    public static DirectMessageReceiver createReceiver(String topicSuffix) {
        return messagingService.createDirectMessageReceiverBuilder().withSubscriptions(TopicSubscription.of(TOPIC_PREFIX + topicSuffix)).build().start();
    }
    
    public static OutboundMessageBuilder createMessageBuilder() {
        return messagingService.messageBuilder();
    }
}
