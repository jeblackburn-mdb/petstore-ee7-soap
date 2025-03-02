package com.mongodb.modfac.petstore.exceptions;

/**
 * @author Antonio Goncalves
 *         http://www.antoniogoncalves.org
 *         --
 *         Thrown when data is not valid
 */

public class ValidationException extends RuntimeException
{
   // ======================================
   // =            Constructors            =
   // ======================================

   public ValidationException()
   {
      super();
   }

   public ValidationException(String message)
   {
      super(message);
   }
}