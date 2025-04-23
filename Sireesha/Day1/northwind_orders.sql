-- Table: public.orders

-- DROP TABLE IF EXISTS public.orders;

CREATE TABLE IF NOT EXISTS public.orders
(
    "orderID" integer NOT NULL,
    "customerID" text COLLATE pg_catalog."default" NOT NULL,
    "employeeID" integer NOT NULL,
    "orderDate" date NOT NULL,
    "requiredDate" date NOT NULL,
    "shippedDate" date,
    "shipperID" integer NOT NULL,
    freight double precision NOT NULL,
    CONSTRAINT order_id_pk PRIMARY KEY ("orderID"),
    CONSTRAINT customer_id_fk FOREIGN KEY ("customerID")
        REFERENCES public.customers ("customerID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT employee_id_fk FOREIGN KEY ("employeeID")
        REFERENCES public.employees ("employeeID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT shipper_id_fk FOREIGN KEY ("shipperID")
        REFERENCES public.shippers ("shipperID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.orders
    OWNER to postgres;