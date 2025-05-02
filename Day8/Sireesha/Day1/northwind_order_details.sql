-- Table: public.order_details

-- DROP TABLE IF EXISTS public.order_details;

CREATE TABLE IF NOT EXISTS public.order_details
(
    "orderID" integer NOT NULL,
    "productID" integer NOT NULL,
    "unitPrice" double precision NOT NULL,
    quantity integer NOT NULL,
    discount double precision,
    CONSTRAINT product_id_fk FOREIGN KEY ("productID")
        REFERENCES public.products ("productID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_details
    OWNER to postgres;