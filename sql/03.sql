/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
 */

WITH custcountry AS(
    SELECT 
        customer_id, country
    FROM customer
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id)
),

custpaid AS(
    SELECT
        customer.customer_id, amount
    FROM customer
    JOIN payment USING(customer_id)
)

SELECT
    country, SUM(amount) AS total_payments
FROM custcountry
JOIN custpaid USING(customer_id)
GROUP BY 1
ORDER BY 2 DESC, 1;
