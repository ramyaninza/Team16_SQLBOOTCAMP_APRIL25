-- Table: public.products

-- DROP TABLE IF EXISTS public.products;

CREATE TABLE IF NOT EXISTS public.products
(
    "productID" integer NOT NULL,
    "productName" text COLLATE pg_catalog."default" NOT NULL,
    "quantityPerUnit" text COLLATE pg_catalog."default" NOT NULL,
    "unitPrice" double precision NOT NULL,
    discontinued boolean NOT NULL,
    "categoryID" integer NOT NULL,
    CONSTRAINT product_id_pk PRIMARY KEY ("productID"),
    CONSTRAINT category_id_fk FOREIGN KEY ("categoryID")
        REFERENCES public.catagories ("catagoryID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.products
    OWNER to postgres;