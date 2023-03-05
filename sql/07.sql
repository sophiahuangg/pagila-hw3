/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH rbfilm AS(
    SELECT
        film_id, actor_id
    FROM actor
    JOIN film_actor
    USING(actor_id)
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),

bacalloneactors AS(
    SELECT
        actor_id
    FROM film_actor
    WHERE film_id IN (SELECT film_id FROM rbfilm) AND actor_id NOT IN (SELECT actor_id FROM rbfilm)
),

bacallonefilms AS(
    SELECT
        *
    FROM actor
    JOIN bacalloneactors
    USING(actor_id)
    WHERE actor_id IN (SELECT * FROM bacalloneactors)
),

 bacalltwoactors AS(
    SELECT
        actor_id
    FROM film_actor
    WHERE film_id IN (SELECT film_id FROM bacallonefilms) AND actor_id NOT IN (SELECT * FROM bacalloneactors)
        AND actor_id NOT IN (SELECT actor_id FROM rbfilm)
)


SELECT
    DISTINCT CONCAT(first_name, ' ', last_name) AS "Actor Name"
FROM bacalltwoactors
JOIN actor
USING(actor_id)
ORDER BY 1;


