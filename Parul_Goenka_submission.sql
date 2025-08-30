/* IMPORTANT INSTRUCTIONS FOR LEARNERS
1) DO NOT CHANGE THE ORDER OF COLUMNS.
2) YOUR QUERY SHOULD DISPLAY COLUMNS IN THE SAME ORDER AS MENTIONED IN ALL QUESTIONS.
3) YOU CAN FIND THE ORDER OF COLUMNS IN QUESTION TEMPLATE SECTION OF EACH QUESTION.
4) USE ALIASING AS MENTIONED IN QUESTION TEMPLATE FOR ALL COLUMNS
5) DO NOT CHANGE COLUMN NAMES*/
                   
-- Question 1 (Marks: 2)
-- Objective: Retrieve data using basic SELECT statements
-- List the names of all customers in the database.
-- Question Template: Display CustomerName Column

-- Write your SQL solution here
SELECT CustomerName from customers;
-- Question 2 (Marks: 2)
-- Objective: Apply filtering using the WHERE clause
-- Retrieve the names and prices of all products that cost less than $15.
-- Question Template: Display ProductName Column

-- Write your SQL solution here
SELECT ProductName,Price 
FROM products 
WHERE Price<15.0;
-- Question 3 (Marks: 2)
-- Objective: Use SELECT to extract multiple fields
-- Display all employees first and last names.
-- Question Template: Display FirstName, LastName Columns

-- Write your SQL solution here
SELECT FirstName, LastName FROM employees;

-- Question 4 (Marks: 2)
-- Objective: Filter data using a function on date values
-- List all orders placed in the year 1997.
-- Question Template: Display OrderID, OrderDate Columns

-- Write your SQL solution here
SELECT OrderID, OrderDate FROM orders where year(OrderDate)=1997;

-- Question 5 (Marks: 2)
-- Objective: Apply numeric filters
-- List all products that have a price greater than $50.
-- Question Template: Display ProductName, Price Column

-- Write your SQL solution here
select ProductName, Price from products where Price>50.0;

-- Question 6 (Marks: 3)
-- Objective: Perform multi-table JOIN operations
-- Show the names of customers and the names of the employees who handled their orders.
-- Question Template: Display CustomerName, FirstName, LastName Columns

-- Write your SQL solution here
SELECT c.CustomerName,e.FirstName,e.LastName
from customers c inner join orders o on o.CustomerID=c.CustomerID
inner join employees e on e.EmployeeID=o.EmployeeID;
-- Question 7 (Marks: 3)
-- Objective: Use GROUP BY for aggregation
-- List each country along with the number of customers from that country.
-- Question Template: Display Country, CustomerCount Columns

-- Write your SQL solution here
select country, count(customerID) as No_of_customers from customers group by country;
-- Question 8 (Marks: 3)
-- Objective: Group data by a foreign key relationship and apply aggregation
-- Find the average price of products grouped by category.
-- Question Template: Display CategoryName, AvgPrice Columns

-- Write your SQL solution here
select categories.CategoryName, avg(products.Price) as AvgPrice from 
products inner join categories on products.CategoryID=categories.CategoryID group by categories.CategoryID;

-- Question 9 (Marks: 3)
-- Objective: Use aggregation to count records per group
-- Show the number of orders handled by each employee.
-- Question Template: Display EmployeeID, OrderCount Columns

-- Write your SQL solution here
select EmployeeID, count(OrderID) as OrderCount from orders group by EmployeeID;
-- Question 10 (Marks: 3)
-- Objective: Filter results using values from a joined table
-- List the names of products supplied by "Exotic Liquids".
-- Question Template: Display ProductName Column

-- Write your SQL solution here
select products.ProductName from products left join suppliers on products.SupplierID=suppliers.SupplierID where suppliers.SupplierName="Exotic Liquids";

-- Question 11 (Marks: 5)
-- Objective: Rank records using aggregation and sort
-- List the top 3 most ordered products (by quantity)
-- Question Template: Display ProductID, TotalOrdered Columns

-- Write your SQL solution here
select ProductID, count(OrderID) as TotalOrdered from orderdetails group by ProductID order by TotalOrdered desc limit 3;

-- Question 12 (Marks: 5)
-- Objective: Use GROUP BY and HAVING to filter on aggregates
-- Find customers who have placed orders worth more than $10,000 in total.
-- Question Template: Display CustomerName, TotalSpent Columns

-- Write your SQL solution here
 
select c.CustomerID, c.CustomerName, sum(od.Quantity*p.Price) as TotalSpent
from customers as c
join orders as o on o.CustomerID=c.CustomerID
join orderdetails as od on od.orderID=o.orderID
join products as p on od.ProductID=p.ProductID
group by c.customerID
having TotalSpent>10000;


-- Question 13 (Marks: 5)
-- Objective: Aggregate and filter at the order level
-- Display order IDs and total order value for orders that exceed $2,000 in value.
-- Question Template: Display OrderID, OrderValue Columns

-- Write your SQL solution here
select o.OrderID, sum(p.Price*o.Quantity) as OrderValue
from orderdetails as o
join products as p on p.ProductID=o.ProductID
group by o.orderID
having OrderValue>2000;


-- Question 14 (Marks: 5)
-- Objective: Use subqueries in HAVING clause
-- Find the name(s) of the customer(s) who placed the largest single order (by value).
-- Question Template: Display CustomerName, OrderID, TotalValue Column

-- Write your SQL solution here
select c.CustomerName, o.OrderID, sum(p.Price*od.Quantity) as TotalValue
from customers as c
join orders as o on c.CustomerID=o.CustomerID
join orderdetails as od on od.OrderID=o.OrderID
join products as p on p.ProductID=od.ProductID
group by c.CustomerName, o.orderID
having TotalValue=(select max(t.orderTotal) 
from 
(select sum(products.Price*orderdetails.Quantity) as orderTotal from products join orderdetails on products.productID=orderdetails.productID group by orderID) as t);


-- Question 15 (Marks: 5)
-- Objective: Identify records using NOT IN with subquery
-- Get a list of products that have never been ordered.
-- Question Template: Display ProductName Columns

-- Write your SQL solution here
select p.productName, 0 as Order_Count
from products as p 
where p.ProductID not in 
(select distinct od.productID from orderdetails as od where od.productID is not NULL);
