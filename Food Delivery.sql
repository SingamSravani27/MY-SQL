CREATE DATABASE FOODDELIVERY;
DROP DATABASE IF EXISTS fooddelivery;
USE FOODDELIVERY

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active'
);
DESCRIBE CUSTOMERS;

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_name VARCHAR(100) NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL,
    rating DECIMAL(2,1) DEFAULT 0.0,
    gst_number VARCHAR(20) UNIQUE NOT NULL,
    status ENUM('Open', 'Closed', 'Temporarily Closed') DEFAULT 'Open'
);
DESCRIBE Restaurants ;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);
DESCRIBE CATEGORIES;

CREATE TABLE Menu (
    menu_id INT PRIMARY KEY AUTO_INCREMENT,
    restaurant_id INT NOT NULL,
    category_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    is_veg BOOLEAN DEFAULT TRUE,
    preparation_time INT NOT NULL,
    availability VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurants(restaurant_id),

    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id)
);
DESCRIBE MENU;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    delivery_partner_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    delivery_charge DECIMAL(10,2) DEFAULT 0.00,
    discount DECIMAL(10,2) DEFAULT 0.00,
    tax DECIMAL(10,2) DEFAULT 0.00,
    final_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30) DEFAULT 'Pending',
    payment_status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurants(restaurant_id)
);
DESCRIBE ORDERS;

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    FOREIGN KEY (menu_id)
        REFERENCES Menu(menu_id)
);
DESCRIBE ORDER_ITEMS;

CREATE TABLE Delivery_Partners (
    partner_id INT PRIMARY KEY AUTO_INCREMENT,
    partner_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type VARCHAR(30) NOT NULL,
    license_number VARCHAR(30) UNIQUE NOT NULL,
    joining_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Available'
);
DESCRIBE DELIVERY_PARTNERS;

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(100) UNIQUE,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Pending',

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);
DESCRIBE PAYMENTS;

CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT NOT NULL,
    review VARCHAR(500),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id),

    FOREIGN KEY (restaurant_id)
        REFERENCES Restaurants(restaurant_id),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CHECK (rating BETWEEN 1 AND 5)
);
DESCRIBE Ratings;

-- INSERT VALUES
INSERT INTO Customers
(first_name, last_name, email, phone, password, gender, date_of_birth, city, state, pincode, address, status)
VALUES
('Rahul', 'Sharma', 'rahul@gmail.com', '9876543210', 'Rahul@123', 'Male', '2001-05-15', 'Hyderabad', 'Telangana', '500001', 'Ameerpet, Hyderabad', 'Active'),
('Priya', 'Reddy', 'priya@gmail.com', '9876543211', 'Priya@123', 'Female', '2002-08-20', 'Hyderabad', 'Telangana', '500034', 'Banjara Hills, Hyderabad', 'Active'),
('Arjun', 'Kumar', 'arjun@gmail.com', '9876543212', 'Arjun@123', 'Male', '2000-11-10', 'Bangalore', 'Karnataka', '560001', 'MG Road, Bangalore', 'Active'),
('Sneha', 'Patel', 'sneha@gmail.com', '9876543213', 'Sneha@123', 'Female', '2003-02-25', 'Chennai', 'Tamil Nadu', '600001', 'T Nagar, Chennai', 'Active'),
('Vikram', 'Singh', 'vikram@gmail.com', '9876543214', 'Vikram@123', 'Male', '1999-07-18', 'Mumbai', 'Maharashtra', '400001', 'Andheri, Mumbai', 'Active'),
('Anjali', 'Rao', 'anjali@gmail.com', '9876543215', 'Anjali@123', 'Female', '2001-12-05', 'Pune', 'Maharashtra', '411001', 'Shivaji Nagar, Pune', 'Active'),
('Kiran', 'Das', 'kiran@gmail.com', '9876543216', 'Kiran@123', 'Male', '2002-03-12', 'Kolkata', 'West Bengal', '700001', 'Salt Lake, Kolkata', 'Active'),
('Meena', 'Rani', 'meena@gmail.com', '9876543217', 'Meena@123', 'Female', '2000-09-30', 'Delhi', 'Delhi', '110001', 'Connaught Place, Delhi', 'Active'),
('Ravi', 'Verma', 'ravi@gmail.com', '9876543218', 'Ravi@123', 'Male', '1998-06-22', 'Hyderabad', 'Telangana', '500032', 'Madhapur, Hyderabad', 'Active'),
('Divya', 'Naidu', 'divya@gmail.com', '9876543219', 'Divya@123', 'Female', '2003-04-16', 'Vijayawada', 'Andhra Pradesh', '520001', 'Benz Circle, Vijayawada', 'Active');

SELECT * FROM Customers;

INSERT INTO Restaurants
(restaurant_name, owner_name, email, phone, city, address, opening_time, closing_time, rating, gst_number, status)
VALUES
('Spice Hub', 'Rajesh Kumar', 'spicehub@gmail.com', '9000000001', 'Hyderabad', 'Madhapur, Hyderabad', '10:00:00', '23:00:00', 4.5, 'GSTHYD001', 'Open'),
('Food Palace', 'Suresh Reddy', 'foodpalace@gmail.com', '9000000002', 'Hyderabad', 'Kukatpally, Hyderabad', '09:00:00', '22:30:00', 4.2, 'GSTHYD002', 'Open'),
('Tasty Bites', 'Amit Sharma', 'tastybites@gmail.com', '9000000003', 'Bangalore', 'MG Road, Bangalore', '11:00:00', '23:30:00', 4.7, 'GSTBLR001', 'Open'),
('Urban Kitchen', 'Neha Patel', 'urbankitchen@gmail.com', '9000000004', 'Mumbai', 'Andheri, Mumbai', '10:30:00', '23:00:00', 4.3, 'GSTMUM001', 'Open'),
('South Spice', 'Ramesh Rao', 'southspice@gmail.com', '9000000005', 'Chennai', 'T Nagar, Chennai', '08:00:00', '22:00:00', 4.6, 'GSTCHE001', 'Open');

SELECT * FROM Restaurants;

INSERT INTO Categories
(category_name, description)
VALUES
('Pizza', 'Different varieties of pizzas'),
('Burgers', 'Veg and non-veg burgers'),
('Biryani', 'Different types of biryani'),
('Desserts', 'Sweet dishes and desserts'),
('Beverages', 'Cold and hot beverages'),
('South Indian', 'Traditional South Indian food'),
('Chinese', 'Chinese food and noodles'),
('Starters', 'Veg and non-veg starters');

SELECT * FROM Categories;

INSERT INTO Menu
(restaurant_id, category_id, item_name, description, price, is_veg, preparation_time, availability)
VALUES
(1, 1, 'Margherita Pizza', 'Classic cheese pizza', 249.00, TRUE, 20, 'Available'),
(1, 1, 'Chicken Pizza', 'Chicken loaded pizza', 349.00, FALSE, 25, 'Available'),
(1, 3, 'Chicken Biryani', 'Hyderabadi chicken biryani', 299.00, FALSE, 30, 'Available'),
(1, 5, 'Cold Coffee', 'Chilled coffee', 120.00, TRUE, 10, 'Available'),

(2, 2, 'Veg Burger', 'Fresh vegetable burger', 149.00, TRUE, 15, 'Available'),
(2, 2, 'Chicken Burger', 'Crispy chicken burger', 199.00, FALSE, 18, 'Available'),
(2, 4, 'Chocolate Cake', 'Chocolate cake slice', 129.00, TRUE, 10, 'Available'),
(2, 5, 'Lime Soda', 'Fresh lime soda', 80.00, TRUE, 5, 'Available'),

(3, 3, 'Mutton Biryani', 'Special mutton biryani', 399.00, FALSE, 35, 'Available'),
(3, 7, 'Chicken Noodles', 'Spicy chicken noodles', 229.00, FALSE, 20, 'Available'),
(3, 8, 'Chicken 65', 'Crispy chicken starter', 249.00, FALSE, 20, 'Available'),

(4, 1, 'Paneer Pizza', 'Paneer loaded pizza', 299.00, TRUE, 25, 'Available'),
(4, 2, 'Cheese Burger', 'Double cheese burger', 179.00, TRUE, 15, 'Available'),
(4, 4, 'Brownie', 'Chocolate brownie', 110.00, TRUE, 10, 'Available'),

(5, 6, 'Masala Dosa', 'Crispy masala dosa', 120.00, TRUE, 15, 'Available'),
(5, 6, 'Idli Sambar', 'Soft idli with sambar', 90.00, TRUE, 10, 'Available'),
(5, 5, 'Filter Coffee', 'Traditional South Indian coffee', 60.00, TRUE, 5, 'Available');

SELECT * FROM Menu;

INSERT INTO Delivery_Partners
(partner_name, phone, email, vehicle_number, vehicle_type, license_number, joining_date, city, status)
VALUES
('Ramesh Kumar', '9100000001', 'ramesh@delivery.com', 'TS09AB1234', 'Bike', 'DLTS001', '2025-01-10', 'Hyderabad', 'Available'),
('Sanjay Rao', '9100000002', 'sanjay@delivery.com', 'TS09CD5678', 'Bike', 'DLTS002', '2025-02-15', 'Hyderabad', 'Available'),
('Akash Singh', '9100000003', 'akash@delivery.com', 'KA01EF9012', 'Bike', 'DLKA001', '2025-03-20', 'Bangalore', 'Available'),
('Manoj Patel', '9100000004', 'manoj@delivery.com', 'MH02GH3456', 'Scooter', 'DLMH001', '2025-04-05', 'Mumbai', 'Available'),
('Karthik Das', '9100000005', 'karthik@delivery.com', 'TN01IJ7890', 'Bike', 'DLTN001', '2025-05-12', 'Chennai', 'Available');

SELECT * FROM Delivery_Partners;

INSERT INTO Orders
(customer_id, restaurant_id, delivery_partner_id, total_amount, delivery_charge, discount, tax, final_amount, order_status, payment_status)
VALUES
(1, 1, 1, 299.00, 40.00, 20.00, 16.00, 335.00, 'Delivered', 'Paid'),
(2, 2, 2, 278.00, 30.00, 10.00, 15.00, 313.00, 'Delivered', 'Paid'),
(3, 3, 3, 399.00, 40.00, 0.00, 20.00, 459.00, 'Delivered', 'Paid'),
(4, 4, 4, 299.00, 35.00, 25.00, 15.00, 324.00, 'Out for Delivery', 'Paid'),
(5, 5, 5, 210.00, 30.00, 10.00, 11.00, 241.00, 'Preparing', 'Paid'),
(6, 1, 1, 469.00, 40.00, 30.00, 24.00, 503.00, 'Delivered', 'Paid'),
(7, 2, 2, 229.00, 30.00, 0.00, 12.00, 271.00, 'Cancelled', 'Refunded'),
(8, 3, 3, 478.00, 40.00, 20.00, 24.00, 522.00, 'Delivered', 'Paid'),
(9, 4, 4, 289.00, 35.00, 15.00, 15.00, 324.00, 'Pending', 'Pending'),
(10, 5, 5, 180.00, 25.00, 0.00, 9.00, 214.00, 'Delivered', 'Paid');

SELECT * FROM ORDERS;

INSERT INTO Order_Items
(order_id, menu_id, quantity, item_price, total_price)
VALUES
(1, 3, 1, 299.00, 299.00),
(2, 5, 1, 149.00, 149.00),
(2, 7, 1, 129.00, 129.00),
(3, 9, 1, 399.00, 399.00),
(4, 12, 1, 299.00, 299.00),
(5, 15, 1, 120.00, 120.00),
(5, 16, 1, 90.00, 90.00),
(6, 2, 1, 349.00, 349.00),
(6, 4, 1, 120.00, 120.00),
(8, 10, 1, 229.00, 229.00),
(8, 11, 1, 249.00, 249.00),
(9, 13, 1, 179.00, 179.00),
(9, 14, 1, 110.00, 110.00),
(10, 15, 1, 120.00, 120.00),
(10, 16, 1, 90.00, 90.00);

SELECT * FROM Order_Items;

INSERT INTO Payments
(order_id, payment_method, transaction_id, amount, payment_status)
VALUES
(1, 'UPI', 'TXN10001', 335.00, 'Success'),
(2, 'Card', 'TXN10002', 313.00, 'Success'),
(3, 'UPI', 'TXN10003', 459.00, 'Success'),
(4, 'Cash', NULL, 324.00, 'Pending'),
(5, 'UPI', 'TXN10005', 241.00, 'Success'),
(6, 'Card', 'TXN10006', 503.00, 'Success'),
(7, 'UPI', 'TXN10007', 271.00, 'Refunded'),
(8, 'UPI', 'TXN10008', 522.00, 'Success'),
(9, 'Card', 'TXN10009', 324.00, 'Pending'),
(10, 'Cash', NULL, 214.00, 'Success');

SELECT * FROM Payments;

INSERT INTO Ratings
(customer_id, restaurant_id, order_id, rating, review)
VALUES
(1, 1, 1, 5, 'Excellent food and fast delivery'),
(2, 2, 2, 4, 'Good food and service'),
(3, 3, 3, 5, 'Very tasty biryani'),
(4, 4, 4, 4, 'Pizza was delicious'),
(5, 5, 5, 5, 'Great South Indian food'),
(6, 1, 6, 4, 'Good taste and quality'),
(8, 3, 8, 5, 'Amazing noodles and starters'),
(10, 5, 10, 4, 'Good dosa and coffee');

SELECT * FROM Ratings;
-- 1. Find all customers whose account status is Active.
SELECT *
FROM Customers
WHERE status = 'Active';

-- 2. Find all restaurants whose status is Open.
SELECT *
FROM Restaurants
WHERE status = 'Open';

-- 3. Find all restaurants located in a particular city.
-- Example: Hyderabad
SELECT *
FROM Restaurants
WHERE city = 'Hyderabad';

-- 4. Find all menu items whose price is greater than ₹300.
SELECT *
FROM Menu
WHERE price > 300;

-- 5. Find all available vegetarian menu items.
SELECT *
FROM Menu
WHERE is_veg = TRUE
  AND availability = 'Available';

-- 6. Find all menu items whose preparation time is less than 20 minutes.
SELECT *
FROM Menu
WHERE preparation_time < 20;

-- 7. Find all delivery partners who are currently Available.
SELECT *
FROM Delivery_Partners
WHERE status = 'Available';

-- 8. Find all orders whose status is Delivered.
SELECT *
FROM Orders
WHERE order_status = 'Delivered';

-- 9. Find all orders where the final amount is greater than ₹1,000.
SELECT *
FROM Orders
WHERE final_amount > 1000;

-- 10. Find all successful payments made using UPI or Credit Card.
SELECT *
FROM Payments
WHERE payment_status = 'Success'
  AND payment_method IN ('UPI', 'Card');

-- 11. Find all ratings where the rating is 1 or 2 stars.
SELECT *
FROM Ratings
WHERE rating IN (1, 2);

-- 12. Find all customers whose first name starts with A, ignoring case.
SELECT *
FROM Customers
WHERE LOWER(first_name) LIKE 'a%';

-- 13. Display all unique customer cities.
SELECT DISTINCT city
FROM Customers;

-- 14. Display all unique restaurant cities.
SELECT DISTINCT city
FROM Restaurants;

-- 15. Display all unique food categories.
SELECT DISTINCT category_name
FROM Categories;

-- 16. Display all unique vehicle types used by delivery partners.
SELECT DISTINCT vehicle_type
FROM Delivery_Partners;

-- 17. Display all unique payment methods.
SELECT DISTINCT payment_method
FROM Payments;

-- 18. Display restaurants from highest to lowest rating.
SELECT *
FROM Restaurants
ORDER BY rating DESC;

-- 19. Display menu items from cheapest to most expensive.
SELECT *
FROM Menu
ORDER BY price ASC;

-- 20. Display customers from newest to oldest registration date.
SELECT *
FROM Customers
ORDER BY created_at DESC;

-- 21. Display delivery partners from newest to oldest joining date.
SELECT *
FROM Delivery_Partners
ORDER BY joining_date DESC;

-- 22. Display orders from highest to lowest final amount.
SELECT *
FROM Orders
ORDER BY final_amount DESC;

-- 23. Display payments from newest to oldest payment date.
SELECT *
FROM Payments
ORDER BY payment_date DESC;

-- 24. Display restaurants alphabetically by city
-- and then restaurant name.
SELECT *
FROM Restaurants
ORDER BY city ASC, restaurant_name ASC;

-- 25. Display customers alphabetically by their complete name using CONCAT().
SELECT *,
       CONCAT(first_name, ' ', last_name) AS full_name
FROM Customers
ORDER BY full_name ASC;


-- 26. Display menu items from longest to shortest preparation time.
SELECT *
FROM Menu
ORDER BY preparation_time DESC;

-- 27. Display orders from highest to lowest discount amount.
SELECT *
FROM Orders
ORDER BY discount DESC;

-- 28. Find the 5 highest-rated restaurants.
SELECT *
FROM Restaurants
ORDER BY rating DESC
LIMIT 5;

-- 29. Find the 10 most expensive menu items.
SELECT *
FROM Menu
ORDER BY price DESC
LIMIT 10;

-- 30. Find the 5 cheapest menu items.
SELECT *
FROM Menu
ORDER BY price ASC
LIMIT 5;

-- 31. Find the 5 customers who registered most recently.
SELECT *
FROM Customers
ORDER BY created_at DESC
LIMIT 5;

-- 32. Find the 5 delivery partners who joined most recently.
SELECT *
FROM Delivery_Partners
ORDER BY joining_date DESC
LIMIT 5;

-- 33. Find the 10 largest orders based on final amount.
SELECT *
FROM Orders
ORDER BY final_amount DESC
LIMIT 10;

-- 34. Find the 5 restaurants with the highest rating.
SELECT *
FROM Restaurants
ORDER BY rating DESC
LIMIT 5;

-- 35. Find the 10 largest successful payments.
SELECT *
FROM Payments
WHERE payment_status = 'Success'
ORDER BY amount DESC
LIMIT 10;

-- 36. Find the total number of customers.
SELECT COUNT(*) AS total_customers
FROM Customers;

-- 37. Find the total number of restaurants.
SELECT COUNT(*) AS total_restaurants
FROM Restaurants;

-- 38. Find the total number of menu items.
SELECT COUNT(*) AS total_menu_items
FROM Menu;

-- 39. Find the average restaurant rating,
-- rounded to 2 decimal places.
SELECT ROUND(AVG(rating), 2) AS average_rating
FROM Restaurants;

-- 40. Find the cheapest and most expensive menu item.
SELECT 
    MIN(price) AS cheapest_price,
    MAX(price) AS most_expensive_price
FROM Menu;

-- 41. Find the average menu item price.
SELECT ROUND(AVG(price), 2) AS average_menu_price
FROM Menu;

-- 42. Find the total number of orders.
SELECT COUNT(*) AS total_orders
FROM Orders;

-- 43. Find the total number of food items ordered.
SELECT SUM(quantity) AS total_food_items
FROM Order_Items;

-- 44. Calculate the total food revenue using Order_Items.total_price.
SELECT SUM(total_price) AS total_food_revenue
FROM Order_Items;

-- 45. Calculate the total delivery charges collected.
SELECT SUM(delivery_charge) AS total_delivery_charges
FROM Orders;

-- 46. Calculate the total discounts given to customers.
SELECT SUM(discount) AS total_discounts
FROM Orders;

-- 47. Calculate the total successful payment amount
-- and total refunded amount.
SELECT
    SUM(CASE
        WHEN payment_status = 'Success'
        THEN amount
        ELSE 0
    END) AS total_successful_amount,
    SUM(CASE
        WHEN payment_status = 'Refunded'
        THEN amount
        ELSE 0
    END) AS total_refunded_amount
FROM Payments;