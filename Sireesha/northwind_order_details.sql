-- Table: public.order_detailes

-- DROP TABLE IF EXISTS public.order_detailes;

CREATE TABLE IF NOT EXISTS public.order_detailes
(
    "orderID" integer NOT NULL,
    "productID" integer,
    "unitPrice" double precision,
    quantity integer,
    discount double precision,
    CONSTRAINT order_id_pk FOREIGN KEY ("orderID")
        REFERENCES public.orders ("orderID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_detailes
    OWNER to postgres;