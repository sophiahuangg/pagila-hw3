/*
 * Compute the number of customers who live outside of the US.
 */

WITH uscust AS(
    SELECT
        customer_id
    FROM customer
    JOIN address
    USING(address_id)
    JOIN city
    USING(city_id)
    JOIN country
    USING(country_id)
    WHERE country_id = 103
),

notus AS(
    SELECT
        customer_id
    FROM customer
    WHERE customer_id NOT IN (SELECT * FROM uscust) AND customer_id IS NOT NULL
)

SELECT
    COUNT(*)
FROM notus;
