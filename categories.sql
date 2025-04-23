-- Table: public.categories

-- DROP TABLE IF EXISTS public.categories;

CREATE TABLE IF NOT EXISTS public.categories
(
    "categoryID" integer NOT NULL,
    "categoryName" text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    CONSTRAINT categories_pkey PRIMARY KEY ("categoryID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categories
    OWNER to postgres;