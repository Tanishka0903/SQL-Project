USE classicmodels;
SHOW TABLES;
SELECT*FROM customers;
SELECT DISTINCT
    (country)
FROM
    customers
WHERE
    country LIKE 'a%' OR country LIKE 'b%'
        OR country LIKE 'c%';
SELECT 
    customernumber,
    creditlimit,
    CASE
        WHEN creditLimit > 100000 THEN 'High'
        WHEN creditlimit BETWEEN 25000 AND 100000 THEN 'medium'
        ELSE 'Low'
    END AS Customer_type
FROM Customers;
SELECT * FROM payments;
SELECT 
    YEAR(paymentDate) AS 'Year',
    MONTHNAME(paymentDate) AS 'Month',
    SUM(amount) AS 'Total Amount'
FROM payments
GROUP BY Year , Month
ORDER BY paymentDate; 
select * from customers;
SELECT 
    c.customerNumber,
    c.customerName,
    SUM(od.priceeach * od.quantityOrdered) AS Sales
FROM
    customers c
        INNER JOIN
    orders o USING (customerNumber)
        INNER JOIN
    orderdetails od USING (orderNumber)
GROUP BY c.customerNumber
ORDER BY Sales DESC;

    
    