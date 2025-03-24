/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

select title from film
join film_actor using (film_id)
where actor_id in (
    select actor_id from actor
    join film_actor using (actor_id)
    join film using (film_id)
    where title = 'AMERICAN CIRCUS')
intersect
select title from film
join film_actor using (film_id)
where actor_id in (
    select actor_id from actor
    join film_actor using (actor_id)
    join film using (film_id)
    where title = 'AGENT TRUMAN')
intersect
select title from film
join film_actor using (film_id)
where actor_id in (
    select actor_id from actor
    join film_actor using (actor_id)
    join film using (film_id)
    where title = 'ACADEMY DINOSAUR')
order by title;
