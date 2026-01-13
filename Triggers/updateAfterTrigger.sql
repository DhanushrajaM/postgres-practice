--orders and inventory management
CREATE TABLE IF NOT EXISTS product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES product(product_id),
    quantity INT NOT NULL,
    order_time TIMESTAMP DEFAULT NOW()
);


INSERT INTO product(product_name, stock) VALUES
('Laptop', 50),
('Mouse', 100),
('Keyboard', 75);

CREATE OR REPLACE FUNCTION update_after_order()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE product
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS after_order_insert ON orders;

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION update_after_order();


INSERT INTO orders(product_id, quantity) VALUES (1, 5);  
INSERT INTO orders(product_id, quantity) VALUES (2, 10); 

SELECT * FROM product;


output
 product_id | product_name | stock
------------+--------------+-------
          3 | Keyboard     |    75
          1 | Laptop       |    45
          2 | Mouse        |    90