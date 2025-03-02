package com.mongodb.modfac.petstore.util;

import javax.enterprise.inject.Produces;
import com.mongodb.modfac.petstore.util.Vat;
import javax.inject.Named;
import com.mongodb.modfac.petstore.util.Discount;

public class NumberProducer
{

   @Produces
   @Vat
   @Named
   private Float vatRate;
   @Produces
   @Discount
   @Named
   private Float discountRate;
}