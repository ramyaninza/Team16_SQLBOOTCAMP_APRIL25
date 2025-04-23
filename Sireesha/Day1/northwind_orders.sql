-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    "orderID" integer NOT NULL,
    "customerID" text COLLATE pg_catalog."default" NOT NULL,
    "employeeID" integer,
    "orderDate" date,
    "requiredDate" date,
    "shippedDate" date,
    "shipperID" integer,
    freight double precision,
    CONSTRAINT order_id_pk PRIMARY KEY ("orderID"),
    CONSTRAINT shipper_id_fk FOREIGN KEY ("shipperID")
        REFERENCES public.shippers ("shipperID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;