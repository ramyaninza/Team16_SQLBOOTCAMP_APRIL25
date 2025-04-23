-- Table: public.employees

-- DROP TABLE IF EXISTS public.employees;

CREATE TABLE IF NOT EXISTS public.employees
(
    "employeeID" integer NOT NULL,
    "employeeName" text COLLATE pg_catalog."default",
    title text COLLATE pg_catalog."default",
    city text COLLATE pg_catalog."default",
    country text COLLATE pg_catalog."default",
    "reportsTo" integer,
    CONSTRAINT employee_id_pk PRIMARY KEY ("employeeID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.employees
    OWNER to postgres;