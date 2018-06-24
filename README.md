# ShoppingCart

## Description of the system
The system is to assist e-commerce online shopping in tracking transactions and managing them. Another role of the db is organizing products. DB will have 8 core tables.
It needs to keep track of the orders along with the details of the items by providing a complete and organized structure of all items and data.
Here the consumers will be able to browse the products provided by the company and select products of interest.

## Business rules
Product belongs to one to many categories
Each category will contain zero to many products
Each product belongs to one brand
Each brand will have one to many products
Each customer has zero to many orders
Each order will have one to many order lines
Each order line will contain only one product and product's quantity
Each order will have zero to one payments
Each payment will belong to exactly one order
Each product will have one SKU number
Each brand belongs to one to many categories

## Assumptions
1. the db is intended for customers, not for employees
2. we are not adding supply chain department()
3. We are not adding internal team work.
4. We are not adding discount table
5. Inventory is not to be included.
6. Every customer will only have one address.
7. Customers must pay with a CC or Debit Card
8. No returns and no exchanges.

## Queries, Functions, Stored procedures (Implement the transactions using SQL on a relational system)
1. Find the Product based on Brand Name
2. Search the Product based on the category.
3. Search the Product based on the Size.
4. Search the Product based on the Product Description.
5. Search the Product based on the available color.
6. Search the Product based on SKU Number.
7. Search the Product based on the Price.
8. Search top ten list of the best selling Products across all categories.
9. Search top ten list of the best selling Products per category.
10. Search the top three best selling brands.
