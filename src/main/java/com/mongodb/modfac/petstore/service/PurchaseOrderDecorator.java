package com.mongodb.modfac.petstore.service;

import com.mongodb.modfac.petstore.service.ComputablePurchaseOrder;
import javax.decorator.Decorator;
import javax.inject.Inject;
import javax.decorator.Delegate;

@Decorator
public abstract class PurchaseOrderDecorator implements ComputablePurchaseOrder
{

   @Inject
   @Delegate
   private ComputablePurchaseOrder delegate;
}