-- Table: public.shippers

-- DROP TABLE IF EXISTS public.shippers;

CREATE TABLE IF NOT EXISTS public.shippers
(
    "shipperID" integer NOT NULL,
    "companyName" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT shipper_id_pk PRIMARY KEY ("shipperID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.shippers
    OWNER to postgres;