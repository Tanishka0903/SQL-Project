USE classicmodels;
-- SELECT Clause
SELECT 
    employeeNumber, firstName, lastName
FROM employees
WHERE jobTitle = 'Sales Rep'
        AND reportsTo = 1102;
    
SELECT DISTINCT
    (productLine)
FROM products
WHERE productLine LIKE '%Cars';
    
-- Case statements for segmentation
SELECT
    customerNumber,
    customerName,
    CASE
        WHEN country IN ('USA', 'Canada') THEN 'North America'
        WHEN country IN ('UK', 'France', 'Germany') THEN 'Europe'
        ELSE 'Other'
    END AS CustomerSegment
FROM Customers;

-- Group By with Aggregation functions and Having clause, Date and Time functions
SELECT
    productCode,
    SUM(quantityOrdered) AS TotalOrderQuantity
FROM OrderDetails
GROUP BY productCode
ORDER BY TotalOrderQuantity DESC
LIMIT 10;

SELECT 
   MONTHNAME(paymentDate) AS Payment_month,
    COUNT(*) AS num_payments
FROM Payments
GROUP BY MONTHNAME(paymentDate)
HAVING COUNT(*) > 20
ORDER BY num_payments DESC;

-- CONSTRAINTS: Primary, key, foreign key, Unique, check, not null, default

CREATE DATABASE Customers_Orders;
USE customers_orders;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone_number VARCHAR(20)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CHECK (total_amount >= 0)
);

-- JOINS
USE classicmodels;
SELECT Customers.country, COUNT(orderNumber) AS order_count
FROM Customers
JOIN Orders ON Customers.customerNumber = Orders.customerNumber
GROUP BY Customers.country
ORDER BY order_count DESC
LIMIT 5;

-- SELF JOIN
CREATE TABLE project (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) CHECK(Gender IN('Male', 'Female')),
    ManagerID INT
);
INSERT INTO project (EmployeeID, FullName, Gender, ManagerID)
VALUES
    (1, 'Pranaya', 'Male', 3),
    (2, 'Priyanka', 'Female', 1),
    (3, 'Preety', 'Female', NULL),
    (4, 'Anurag', 'Male', 1),
    (5, 'Sambit', 'Male', 1),
    (6, 'Rajesh', 'Male', 3),
    (7, 'Hina', 'Female', 3);

SELECT p1.FullName AS "Manager Name", p2.FullName AS "Emp Name"
FROM project AS p1 JOIN project AS p2
ON p1.EmployeeID = p2.ManagerId
ORDER BY p1.EmployeeID;

-- DDL Commands: Create, Alter, Rename
CREATE TABLE facility (
    Facility_ID INT,
    Name VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100)
);
ALTER TABLE facility
ADD PRIMARY KEY (Facility_ID),
MODIFY Facility_ID INT AUTO_INCREMENT;
ALTER TABLE facility
ADD city VARCHAR(100) NOT NULL AFTER Name;
DESC facility;

-- Views in SQL
CREATE VIEW product_category_sales AS
SELECT
    pl.productLine AS productLine,
    SUM(od.quantity * od.priceEach) AS total_sales,
    COUNT(DISTINCT o.orderNumber) AS number_of_orders
FROM Products p
JOIN OrderDetails od ON p.productCode = od.productCode
JOIN Orders o ON od.orderNumber = o.orderNumber
JOIN ProductLines pl ON p.productLine = pl.productLine
GROUP BY pl.productLine;
SELECT * FROM product_category_sales;

-- Stored Procedures in SQL with parameters
-- stored procedures get_country_payments created with following code

CREATE DEFINER=`root`@`localhost` PROCEDURE `Get_country_payments`(yr INT,cnty VARCHAR(50))
BEGIN
SELECT YEAR(paymentDate) AS "Year",
	   country ,
	   CONCAT(FORMAT(SUM(amount) / 1000, 0), 'K') AS TotalAmount
    FROM payments JOIN customers
    ON payments.customerNumber = customers.customerNumber
    WHERE YEAR(paymentDate)=yr AND country=cnty
	GROUP BY Year;
END

-- Window functions - Rank, dense_rank, lead and lag
SELECT
    CustomerName,
    COUNT(orderNumber) AS Order_count,
    DENSE_RANK() OVER(ORDER BY COUNT(orderNumber) DESC) AS order_frequency_rnk
FROM orders 
JOIN customers ON orders.customerNumber = customers.CustomerNumber
GROUP BY CustomerName
  ORDER BY
    Order_count DESC;  
 
 SELECT
 YEAR(orderDate) AS "Year",
 MONTHNAME(orderDate) AS "Month",
 COUNT(orderNumber) AS "Total Orders",
 CONCAT(ROUND(
	   ((COUNT(orderNumber)-LAG(COUNT(orderNumber),1) OVER())/
	   LAG(COUNT(orderNumber),1)OVER())*100
       ), "%")AS "% YOY Change"
 FROM Orders
 GROUP BY Year,Month;
 
-- Subqueries and their applications
SELECT productLine,
COUNT(productLine) AS Total
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products)
GROUP BY productLine
ORDER BY Total DESC;

-- ERROR HANDLING in SQL
CREATE TABLE Emp_EH (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    EmailAddress VARCHAR(100)
);
-- Stored procedure "error handling" created with this code 

CREATE DEFINER=`root`@`localhost` PROCEDURE `Error Handling`(id INT, Name VARCHAR(100),eadd VARCHAR(100))
BEGIN
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
SELECT "Error Occured";

INSERT INTO emp_eh (EmpID, EmpName, EmailAddress)
VALUES (id,Name,eadd);
SELECT*FROM emp_eh;
END

-- TRIGGERS
CREATE TABLE Emp_BIT (
    Name VARCHAR(100),
    Occupation VARCHAR(100),
    Working_date DATE,
    Working_hours INT
);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  
 
-- trigger code
CREATE DEFINER=`root`@`localhost` TRIGGER `emp_bit_BEFORE_INSERT` BEFORE INSERT ON `emp_bit` FOR EACH ROW BEGIN
IF NEW.Working_hours < 0 THEN
SET NEW.Working_hours = - NEW.Working_hours;
END IF;
END
