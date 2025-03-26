/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */


WITH rental_categories AS (
    SELECT
        r.rental_id,
        c.customer_id,
        c.first_name,
        c.last_name,
        r.rental_date,
        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM film_category fc
                JOIN category cat ON fc.category_id = cat.category_id
                WHERE cat.name = 'Action'
                AND fc.film_id = f.film_id
            ) THEN 1
            ELSE 0
        END AS is_action
    FROM customer c
    JOIN rental r ON r.customer_id = c.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
),
ranked_rentals AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY rental_date DESC
           ) AS rank
    FROM rental_categories
)
SELECT customer_id, first_name, last_name
FROM ranked_rentals
WHERE rank <= 5
GROUP BY customer_id, first_name, last_name
HAVING SUM(is_action) >= 4
ORDER BY customer_id;

