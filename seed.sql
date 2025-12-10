-- seed.sql (first part: schema)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  city VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE menu_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  restaurant_id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  menu_item_id INT NOT NULL,
  ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- additional fields like user_id, qty could be added later
  FOREIGN KEY (menu_item_id) REFERENCES menu_items(id) ON DELETE CASCADE
);

-- Indexes to speed up the query:
CREATE INDEX idx_menu_items_name ON menu_items (name);
CREATE INDEX idx_menu_items_price ON menu_items (price);
CREATE INDEX idx_orders_menu_item ON orders (menu_item_id);



-- seed.sql (second part: sample data)

INSERT INTO restaurants (name, city) VALUES
('Hyderabadi Spice House', 'Hyderabad'),
('Foody Junction', 'Indore'),
('North Indian Dhaba', 'Delhi'),
('Bombay Biryani Co', 'Mumbai'),
('Cafe Veggies', 'Bengaluru'),
('Taste of Lucknow', 'Lucknow'),
('Shriji Food Hub', 'Kolkata'),
('Guru Kripa', 'Hyderabad');

-- menu items: variety of dishes with varied prices
INSERT INTO menu_items (restaurant_id, name, price) VALUES
(1, 'Aloo Paratha', 220.00),
(1, 'Veg Biryani', 320.00),
(2, 'Paneer Kulcha', 180.00),
(3, 'Palak Paneer', 150.00),
(4, 'Palak patta', 260.00),
(5, 'Paneer Biryani', 160.00),
(6, 'Uttapam', 200.00),
(7, 'Paneer Pasanda', 350.00),
(8, 'Bombay Potatoes', 170.00),
(2, 'Rajma', 230.00),
(1, 'Vegetable Pakora', 140.00);

-- create a lot of orders to create counts
-- For simplicity we'll insert many rows (simulate frequently ordered dish)
-- Hyderabadi Spice House Aloo Paratha (menu_item_id = 1) -> 15 orders



-- insert multiple rows with repeated VALUES (example below)
INSERT INTO orders (menu_item_id) VALUES
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1),
(1),(1),(1),(1),(1),(1),(1),(1),(1),(1); -- 100 values -> adjust as needed

-- Other restaurants: a few orders each
INSERT INTO orders (menu_item_id) VALUES
(2),(2),(2),
(3),(3),(3),(3),
(4),(4),(4),(4),(4),
(5),(5),
(6),(6),(6),(6),(6),(6),
(7),(7),(7), -- etc.
(8),(8),(8),(8),(8);