-- USE CASE 1 :
SELECT *
FROM superstore_order
WHERE ship_mode = 'Same Day' and order_date != ship_date

-- USE CASE 2 :
SELECT discount, AVG(profit),
CASE
    WHEN discount < 0.2 THEN 'LOW'
    WHEN discount >= 0.2 and discount < 0.4 THEN 'MODERATE'
    WHEN discount >= 0.4 THEN 'HIGH'
END AS criteria_discount
FROM superstore_order
GROUP BY discount
ORDER BY AVG(profit) DESC;

-- USE CASE 3 :
SELECT product.category, product.subcategory, AVG(order_.discount) AS avg_discount, AVG(order_.profit) AS avg_profit
FROM superstore_product AS product
    JOIN superstore_order AS order_
    ON product.product_id = order_.product_id
GROUP BY product.category, product.subcategory
ORDER BY avg_discount DESC;

-- USE CASE 4 :
SELECT EXTRACT(year from order_.order_date) AS year_,cust.segment, SUM(order_.sales) AS total_sales, AVG(order_.profit) AS rata2_profit
FROM superstore_customer AS cust
JOIN superstore_order AS order_
ON cust.customer_id = order_.customer_id
WHERE state IN ('California', 'Texas', 'Georgia') AND EXTRACT(year from order_.order_date) = 2016
GROUP BY year_, cust.segment
ORDER BY rata2_profit DESC;

-- USE CASE 5 :
SELECT cust.region, count(1) AS total
FROM
(
    SELECT customer_id, avg(discount), count(1)
    FROM superstore_order
    GROUP BY 1
    HAVING avg(discount) > 0.4
) tab
join superstore_customer AS cust
on tab.customer_id = cust.customer_id
Group by 1



-- LATIHAN
SELECT DISTINCT(cust.region), AVG(order_.discount) AS avg_discount,COUNT(order_.discount) AS jumlah
FROM superstore_customer AS cust
JOIN superstore_order AS order_
ON cust.customer_id = order_.customer_id
where order_.discount > 0.4
GROUP BY cust.region


SELECT DISTINCT(cust.region), COUNT(1) AS total
FROM superstore_customer AS cust
JOIN superstore_order AS order_
ON cust.customer_id = order_.customer_id
GROUP BY cust.region, order_.discount
HAVING order_.discount > 0.4

SELECT cust.region, COUNT(order_.discount) AS total
FROM superstore_customer AS cust
JOIN superstore_order AS order_
ON cust.customer_id = order_.customer_id
WHERE cust.customer_id IN(
    SELECT customer_id
    FROM superstore_order
    GROUP BY 1
    HAVING avg(discount) > 0.4
)
GROUP BY 1


