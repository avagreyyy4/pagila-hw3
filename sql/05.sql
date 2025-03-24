/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

select title from film 
join film_actor using (film_id) 
where actor_id in (
    select actor_id from actor 
    join film_actor using (actor_id)
    join film using (film_id)
    where title = 'AMERICAN CIRCUS')
order by title;
