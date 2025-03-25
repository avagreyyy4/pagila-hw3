/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */


select title from film
join film_category using (film_id)
join film_actor using (film_id)
where category_id in (
    select category_id from category
    join film_category using (category_id)
    join film using (film_id)
    where title = 'AMERICAN CIRCUS')
and actor_id in (
    select actor_id from actor 
    join film_actor using (actor_id)
    join film using (film_id)
    where title = 'AMERICAN CIRCUS')
group by film_id, title
having count(distinct category_id) >=2
order by title;
