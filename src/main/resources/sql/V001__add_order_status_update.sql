CREATE OR REPLACE PACKAGE petstore_sp AS
    PROCEDURE update_expired_credit_cards(expiry_date IN VARCHAR2);
    PROCEDURE add_order_status(the_po_id IN NUMERIC, expiry_status IN NUMERIC);
END petstore_sp;
/

CREATE OR REPLACE PACKAGE BODY petstore_sp AS
    PROCEDURE update_expired_credit_cards(expiry_date IN VARCHAR2) IS
        CURSOR expired_cards_cursor IS
            SELECT *
            FROM purchase_order
            WHERE CREDIT_CARD_EXPIRY_DATE < TO_DATE(expiry_date, 'YYYY-MM-DD');
        expired_card_row  purchase_order%ROWTYPE;
        v_order_status_id purchase_order.ID%TYPE;
    BEGIN
        open expired_cards_cursor;
        loop
            fetch expired_cards_cursor into expired_card_row;
            BEGIN
                SELECT PURCHASE_ORDER_ID
                INTO v_order_status_id
                FROM ORDER_STATUS
                WHERE PURCHASE_ORDER_ID = expired_card_row.ID;
                update ORDER_STATUS
                set PAYMENT_EXPIRY_STATUS = 1
                where PURCHASE_ORDER_ID = expired_card_row.ID;
-- If the row exists, process it here
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    add_order_status(expired_card_row.ID, 1);
            END;
        end loop;
    END update_expired_credit_cards;

    procedure add_order_status(the_po_id IN NUMERIC, expiry_status IN NUMERIC) as
    BEGIN
        insert into ORDER_STATUS(PURCHASE_ORDER_ID, PAYMENT_STATUS, PAYMENT_EXPIRY_STATUS, DELIVERY_STATUS)
        values (the_po_id, 0, expiry_status, 0);
    end add_order_status;

END petstore_sp;
/