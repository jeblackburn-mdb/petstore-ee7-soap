package com.mongodb.modfac.petstore.model;

import javax.persistence.*;
import javax.validation.constraints.Min;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "order_line")
public class OrderLine implements Serializable
{

   // ======================================
   // = Attributes =
   // ======================================

   @Id
   @GeneratedValue(strategy = GenerationType.AUTO)
   @Column(name = "id", updatable = false, nullable = false)
   private Long id;
   @Version
   @Column(name = "version")
   private int version;

   @Column(nullable = false)
   @Min(1)
   private Integer quantity;

   @ManyToOne(cascade = CascadeType.PERSIST)
   @JoinColumn(name = "item_fk", nullable = false)
   private Item item;

   // ======================================
   // = Constructors =
   // ======================================

   public OrderLine()
   {
   }

   public OrderLine(Integer quantity, Item item)
   {
      this.quantity = quantity;
      this.item = item;
   }

   // ======================================
   // = Business methods =
   // ======================================

   public Float getSubTotal()
   {
      return item.getUnitCost() * quantity;
   }

   // ======================================
   // = Getters & setters =
   // ======================================

   public Long getId()
   {
      return this.id;
   }

   public void setId(final Long id)
   {
      this.id = id;
   }

   public int getVersion()
   {
      return this.version;
   }

   public void setVersion(final int version)
   {
      this.version = version;
   }

   public Integer getQuantity()
   {
      return quantity;
   }

   public void setQuantity(Integer quantity)
   {
      this.quantity = quantity;
   }

   public Item getItem()
   {
      return this.item;
   }

   public void setItem(final Item item)
   {
      this.item = item;
   }

   // ======================================
   // = Methods hash, equals, toString =
   // ======================================

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderLine orderLine = (OrderLine) o;
        return quantity.equals(orderLine.quantity) && item.equals(orderLine.item);
    }

    @Override
    public int hashCode() {
        return Objects.hash(quantity, item);
    }

    @Override
   public String toString()
   {
      return "OrderLine{" +
               "id=" + id +
               ", version=" + version +
               ", quantity=" + quantity +
               ", item=" + item +
               '}';
   }
}
