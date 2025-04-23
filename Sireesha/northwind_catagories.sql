-- Table: public.catagories

-- DROP TABLE IF EXISTS public.catagories;

CREATE TABLE IF NOT EXISTS public.catagories
(
    "catagoryID" integer NOT NULL,
    "catagoryName" text COLLATE pg_catalog."default" NOT NULL,
    "Description" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT catagories_id_pk PRIMARY KEY ("catagoryID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.catagories
    OWNER to postgres;