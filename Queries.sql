																										
#. Search the Product based on the category. Example - Shoes																										
select Product_Name																										
from Products																										
join Category on Category.Category_ID = Products.Category_ID																										
where Category_Name like 'Shoes%';																										
																										
#. Search the Product based on the Size. Example - Size XS, Small & Medium																										
select Products.Product_Name, Brand.Brand_Name, Products.Size																										
from Products																										
join Brand on Brand.SKU_Number = Products.SKU_Number																										
where																										
Products.Size like 'XS'																										
or																										
Products.Size like 'S'																										
or																										
Products.Size like 'M';																										
																										
#. Search the Product based on the Price.																										
select Supplier_Name, Products.Unit_Price																										
from Supplier																										
join Product_Supplier on Product_Supplier.Supplier_ID = Supplier.Supplier_ID																										
join Products on Products.Product_ID = Product_Supplier.Product_ID																										
where Products.Unit_Price < 100																										
																										
#. Find the Product based on Brand Name Example - Brand (Tory)																										
Select Product_Name																										
from Products																										
join Brand on Brand.SKU_Number = Products.SKU_Number																										
where Brand_Name like 'Tory%';																										
																										
# Search the Product based on the available color Example - Product Color (White)																										
select *																										
from Products																										
where color = 'White'																										
																										
# Search top five list of the best selling Products across all categories.																										
select count(Order_Details.Product_ID) as Number_Of_Orders, Products.Product_Name																										
from Products																										
join Order_Details on Order_Details.Product_ID = Products.Product_ID																										
group by Order_Details.Product_ID																										
order by Number_Of_Orders desc																										
limit 5																										
																										
# Search the top three best selling brands.																										
																										
# Find the best selling Product in each category.																										
select * from (																										
select count(Order_Details.Product_ID) as Number_Of_Orders, Products.Product_Name, Products.Product_ID, Category.Category_Name, Category.Category_ID																										
from Products																										
join Order_Details on Order_Details.Product_ID = Products.Product_ID																										
join Category on Category.Category_ID = Products.Category_ID																										
group by Order_Details.Product_ID																										
order by Category.Category_ID, Number_Of_Orders desc) as consolidated_sales																										
group by Category_ID																										
having Number_Of_Orders = max(Number_Of_Orders)																										
																										
# Find the Payment method of a customer 																										
SELECT CONCAT(C.First_Name, ' ', C.Last_Name) AS Full_Name, P.Payment_Method_ID, P.CC_Type, P.CC_Number, P.CC_Exp, P.CC_CVV																										
FROM Customers C INNER JOIN Payment_Method P ON C.Customer_ID = P.Customer_ID																										
WHERE C.Customer_ID = 10;																										
																										
 # Products added to shopping cart by a customer																										
SELECT P.Product_Name, OSCI.Product_Quantity, S.Shipper_Name, OSCI.Shipping_Charge, OSCI.Total_Item_Price																										
FROM Ordered_Shopping_Cart_Item OSCI INNER JOIN Products P ON P.Product_ID = OSCI.Product_ID																										
INNER JOIN Shipper S ON OSCI.Shipper_ID = S.Shipper_ID																										
INNER JOIN Ordered_Shopping_Cart OSC ON OSCI.Shopping_Cart_ID = OSC.Shopping_Cart_ID																										
INNER JOIN Customers C ON OSC.Customer_ID = C.Customer_ID																										
WHERE C.Customer_ID = 10;																										
																										
# Payment transaction of a customer																										
SELECT CONCAT(C.First_Name, ' ', C.Last_Name) AS Full_Name, PT.*																										
FROM Payment_Transaction PT INNER JOIN Payment_Method PM ON PM.Payment_Method_ID = PT.Payment_Method_ID																										
INNER JOIN Customers C ON PM.Customer_ID = C.Customer_ID																										
WHERE C.Customer_ID = 10;																										
																										
# Customers with more than 7 different items in their shopping cart																										
SELECT CONCAT(C.First_Name," ", C.Last_Name) AS 'Name', COUNT(OSCI.Shopping_Cart_Item_ID) AS 'Number of Items in Cart'																										
FROM Customers C INNER JOIN Ordered_Shopping_Cart OSC ON C.Customer_ID = OSC.Customer_ID INNER JOIN Ordered_Shopping_Cart_Item OSCI																										
ON OSCI.Shopping_Cart_ID = OSC.Shopping_Cart_ID GROUP BY OSC.Shopping_Cart_ID HAVING COUNT(OSCI.Shopping_Cart_Item_ID) > 7;																										
																										
# Customers who added items in the cart between May 09, 2017 and May 12, 2017																										
SELECT CONCAT(C.First_Name," ", C.Last_Name) AS 'Name', OSC.Creation_Date AS 'Cart creation date',																										
	COUNT(OSCI.Shopping_Cart_Item_ID) AS 'Number of Items in Cart'																									
FROM Customers C INNER JOIN Ordered_Shopping_Cart OSC ON C.Customer_ID = OSC.Customer_ID INNER JOIN Ordered_Shopping_Cart_Item OSCI																										
	ON OSCI.Shopping_Cart_ID = OSC.Shopping_Cart_ID																									
GROUP BY OSC.Shopping_Cart_ID																										
HAVING OSC.Creation_Date BETWEEN STR_TO_DATE('May-09-2017', '%M-%d-%Y %h') AND STR_TO_DATE('May-12-2017', '%M-%d-%Y %h');																										
																										
 # List of Customers who bought a particular product and quantity bought																										
SELECT CONCAT(C.First_Name," ", C.Last_Name) AS 'Name', P.Product_Name,OSCI.Product_Quantity																										
FROM Customers C INNER JOIN Ordered_Shopping_Cart OSC ON C.Customer_ID =OSC.Customer_ID INNER JOIN Ordered_Shopping_Cart_Item OSCI ON																										
	OSCI.Shopping_Cart_ID = OSC.Shopping_Cart_ID INNER JOIN Products P ON P.Product_ID = OSCI.Product_ID																									
WHERE P.Product_Name = 'Rag & Bone Margot Bootie';																										
																										
#Name of customers who made transaction using ‘Discover ’ Card																										
SELECT DISTINCT CONCAT(C.First_Name," ", C.Last_Name) AS 'Name'																										
FROM Customers C INNER JOIN Payment_Method PM ON C.Customer_ID = PM.Customer_ID																										
	INNER JOIN Payment_Transaction PT ON PT.Payment_Method_ID =PM.Payment_Method_ID																									
WHERE PM.CC_Type = 'Discover';																										
																										
#The Products from a particular shipper added to Shopping Cart by customers																										
SELECT CONCAT(C.First_Name," ", C.Last_Name) AS 'Name', P.Product_Name, OSCI.Product_Quantity,S.Shipper_Name																										
FROM Customers C INNER JOIN Ordered_Shopping_Cart OSC ON C.Customer_ID = OSC.Customer_ID																										
	INNER JOIN Ordered_Shopping_Cart_Item OSCI ON OSCI.Shopping_Cart_ID = OSC.Shopping_Cart_ID																									
	INNER JOIN Products P ON P.Product_ID = OSCI.Product_ID																									
	INNER JOIN Shipper S ON S.Shipper_ID = OSCI.Shipper_ID																									
WHERE S.Shipper_Name = ' Links Cargo';																										
																										
#. Display number of orders per Customer																										
select Customers.Customer_ID, First_Name, Last_Name, count(*) as Number_of_orders																										
from Customers join Orders on Customers.Customer_ID = Orders.Customer_ID																										
group by  Customers.Customer_ID, First_Name, Last_Name;																										
																										
#. Display customer orders for specific date range																										
select Customers.Customer_ID, First_Name, Last_Name, Orders.Order_ID, Orders.Order_Date																										
from Customers join Orders on Customers.Customer_ID = Orders.Customer_ID																										
where Customers.Customer_ID = 2 and Order_Date >= STR_TO_DATE('18,05,2005','%d,%m,%Y') and Order_Date <= STR_TO_DATE('18,05,2020','%d,%m,%Y');																										
																										
#. Order details with price of each order item																										
select																										
Order_Details.Order_ID,																										
Products.Product_ID,																										
Products.Product_Name,																										
Order_Details.Product_Qty,																										
Shipper.Shipper_Name ,																										
Unit_Price,																										
Products.Quantity_Per_Unit,																										
Product_Qty*Unit_Price*Quantity_Per_Unit as product_item_total																										
from																										
Products join Order_Details on Products.Product_ID= Order_Details.Product_ID																										
join Shipper on Order_Details.Shipper_ID = Shipper.Shipper_ID																										
where Order_Details.Order_ID= 1;																										
																										
#. Total price of the order number N (N=1) 																										
select sum(t1.product_item_total) from																										
(																										
select																										
Order_Details.Order_ID,																										
Products.Product_ID,																										
Products.Product_Name,																										
Order_Details.Product_Qty,																										
Shipper.Shipper_Name ,																										
Unit_Price,																										
Products.Quantity_Per_Unit,																										
Product_Qty*Unit_Price*Quantity_Per_Unit as product_item_total																										
from																										
Products join Order_Details on Products.Product_ID= Order_Details.Product_ID																										
join Shipper on Order_Details.Shipper_ID = Shipper.Shipper_ID																										
where Order_Details.Order_ID= 1																										
) t1;																										
																										
#. order details of particular order 																										
select  Order_Details.Order_ID,Products.Product_ID,Products.Product_Name,Order_Details.Product_Qty,																										
Shipper.Shipper_Name from																										
Products join Order_Details on Products.Product_ID= Order_Details.Product_ID																										
join Shipper on Order_Details.Shipper_ID = Shipper.Shipper_ID																										
where Order_Details.Order_ID= 1;																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										
																										