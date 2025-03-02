create table ORDER_STATUS
(
    PURCHASE_ORDER_ID     NUMBER(19) not null
        primary key
        constraint FK_PURCHASE_ORDER
            references C##PETSTORE.PURCHASE_ORDER,
    PAYMENT_STATUS        NUMBER(2),
    PAYMENT_EXPIRY_STATUS NUMBER(2),
    DELIVERY_STATUS       NUMBER(2)
)


