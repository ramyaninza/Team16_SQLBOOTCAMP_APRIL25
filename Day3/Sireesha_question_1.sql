/*Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

SELECT * FROM categories


UPDATE category_Name 
SET category_Name = 'Drinks'
WHERE category_Name = 'Beverages'

