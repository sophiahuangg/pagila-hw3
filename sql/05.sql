/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

WITH acid AS(
    SELECT
        film_id
    FROM film
    WHERE title = 'AMERICAN CIRCUS'
),

acactors AS(
    SELECT
        *
    FROM film_actor a
    WHERE a.film_id IN (SELECT * FROM acid)
),

othermovies AS(
    SELECT
        film_actor.film_id
    FROM acactors
    JOIN film_actor USING(actor_id)
    GROUP BY film_actor.film_id
    HAVING COUNT(acactors.actor_id) >= 2
)


SELECT
    title
FROM film
JOIN othermovies
USING(film_id)
ORDER BY 1;
