/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */


WITH children AS(
    SELECT
        *
    FROM actor_info
    WHERE film_info LIKE '%Children:%'
),

nothorror AS(
    SELECT
        *
    FROM children
    WHERE film_info NOT LIKE '%Horror:%'
)

SELECT
    first_name, last_name
FROM nothorror
ORDER BY 2, 1;
