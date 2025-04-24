/*  Alter Table:
Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.*/
SELECT * FROM employees
ALTER TABLE employees ADD linkedin_profile VARCHAR(50);


/*Change the linkedin_profile column data type from VARCHAR to TEXT.*/

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;

/*Add unique, not null constraint to linkedin_profile*/

ALTER TABLE employees ALTER COLUMN linkedin_profile SET NOT NULL;
ALTER TABLE employees ADD CONSTRAINT unique_linked_in UNIQUE (linkedin_profile);
ALTER TABLE employees ALTER COLUMN linkedin_profile SET NOT NULL;

/*Drop column linkedin_profile  */
ALTER TABLE employees DROP COLUMN linkedin_profile
