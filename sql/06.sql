/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

WITH rbfilm AS(
    SELECT
        film_id, actor_id
    FROM actor
    JOIN film_actor
    USING(actor_id)
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),

actorsone AS(
    SELECT
        actor_id
    FROM film_actor
    WHERE film_id IN (SELECT film_id FROM rbfilm) AND actor_id NOT IN (SELECT actor_id FROM rbfilm)
)


SELECT
    DISTINCT CONCAT(first_name, ' ', last_name) AS "Actor Name"
FROM actorsone
JOIN actor
USING(actor_id)
ORDER BY 1;
