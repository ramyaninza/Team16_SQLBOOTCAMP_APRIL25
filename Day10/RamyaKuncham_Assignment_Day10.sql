CREATE OR REPLACE FUNCTION get_total_stock_value(category INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    total_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO total_value
    FROM products
    WHERE category_id = category;

    RETURN COALESCE(total_value, 0.00);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_price_with_cursor()
LANGUAGE plpgsql
AS $$
DECLARE 
    product_cursor CURSOR FOR
        SELECT product_id, product_name, unit_price, units_in_stocks
        FROM products
        WHERE discontinued = 0;

    product_record RECORD;
    v_new_price DECIMAL(10,2);
BEGIN
    -- Open the cursor
    OPEN product_cursor;

    LOOP
        -- Fetch the next row
        FETCH product_cursor INTO product_record;

        -- Exit when no more rows
        EXIT WHEN NOT FOUND;

        -- Calculate new price
        IF product_record.units_in_stocks < 10 THEN
            v_new_price := product_record.unit_price * 1.10;
        ELSE
            v_new_price := product_record.unit_price * 0.95;
        END IF;

        -- Update the product price
        UPDATE products
        SET unit_price = ROUND(v_new_price, 2)
        WHERE product_id = product_record.product_id;

        -- Log the change
        RAISE NOTICE 'Updated % price from % to %',
            product_record.product_name,
            product_record.unit_price,
            v_new_price;
    END LOOP;

    -- Close the cursor
    CLOSE product_cursor;
END;
$$;

