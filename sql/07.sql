/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT DISTINCT a3.first_name || ' ' || a3.last_name AS "Actor Name"
FROM actor a3
JOIN film_actor fa3 ON a3.actor_id = fa3.actor_id
WHERE fa3.film_id IN (
    SELECT DISTINCT fa2.film_id
    FROM film_actor fa2
    WHERE fa2.actor_id IN (
        SELECT DISTINCT fa1.actor_id
        FROM film_actor fa1
        WHERE fa1.film_id IN (
            SELECT film_id
            FROM film_actor fa0
            JOIN actor a0 ON fa0.actor_id = a0.actor_id
            WHERE a0.first_name = 'RUSSELL' AND a0.last_name = 'BACALL'
        )
        AND fa1.actor_id != (
            SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
        )
    )
)
AND a3.actor_id != (
    SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
)
AND a3.actor_id NOT IN (
    SELECT DISTINCT fa1.actor_id
    FROM film_actor fa1
    WHERE fa1.film_id IN (
        SELECT film_id
        FROM film_actor fa0
        JOIN actor a0 ON fa0.actor_id = a0.actor_id
        WHERE a0.first_name = 'RUSSELL' AND a0.last_name = 'BACALL'
    )
)
ORDER BY "Actor Name";

