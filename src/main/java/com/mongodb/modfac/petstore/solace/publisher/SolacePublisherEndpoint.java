package com.mongodb.modfac.petstore.solace.publisher;

import com.mongodb.modfac.petstore.solace.queue.SolaceQueueProducer;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

@Path("/solace")
public class SolacePublisherEndpoint {

    @Inject
    private SolacePublisherBean solaceBean;

    @Inject
    private SolacePublisherSingleton solaceSingleton;
    
    @Inject
    private SolaceQueueProducer solaceQueueProducer;

    @POST
    @Path("/publish/ejb")
    @Consumes({"application/xml", "application/json", "text/plain"})
    public Response publishToEjb(String payload) {
        solaceSingleton.publish(payload, "ejb");
        return Response.ok(payload).build();
    }
    
    @POST
    @Path("/publish/appscope")
    @Consumes({"application/xml", "application/json", "text/plain"})
    public Response publishToAppScoped(String payload) {
        solaceBean.publish(payload, "applicationScoped");
        return Response.ok(payload).build();
    }
    
    @POST
    @Path("/publish/queue")
    @Consumes({"application/xml", "application/json", "text/plain"})
    public Response publishToQueue(String payload) {
        solaceQueueProducer.createMessageForQueue(payload);
        return Response.ok(payload).build();
    }
}
