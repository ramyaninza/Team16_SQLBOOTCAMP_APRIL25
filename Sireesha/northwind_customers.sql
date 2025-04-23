-- Table: public.customers

-- DROP TABLE IF EXISTS public.customers;

CREATE TABLE IF NOT EXISTS public.customers
(
    "customerID" text COLLATE pg_catalog."default" NOT NULL,
    "companyName" text COLLATE pg_catalog."default",
    "contactName" text COLLATE pg_catalog."default",
    "contactTitle" text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    CONSTRAINT customer_id_pk PRIMARY KEY ("customerID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;