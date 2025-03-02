package com.mongodb.modfac.petstore.solace;

import java.util.ResourceBundle;

public class SolaceConstants {
    
    private static final ResourceBundle SOLACE = ResourceBundle.getBundle("solace");
    private static final String TOPIC_PREFIX_KEY = "topicprefix";
    private static final String HOST_KEY = "host";
    private static final String PORT_KEY = "port";
    private static final String VPN_KEY = "vpn";
    private static final String USER_KEY = "user";
    private static final String PASSWORD_KEY = "password";
    private static final String QUEUE_KEY = "queue";
    
    public static final String HOST = SOLACE.getString(HOST_KEY);
    public static final String PORT = SOLACE.getString(PORT_KEY);
    public static final String VPN = SOLACE.getString(VPN_KEY);
    public static final String USER = SOLACE.getString(USER_KEY);
    public static final String PASSWORD = SOLACE.getString(PASSWORD_KEY);
    public static final String TOPIC_PREFIX = SOLACE.getString(TOPIC_PREFIX_KEY);
    public static final String QUEUE_NAME = SOLACE.getString(QUEUE_KEY);
}
