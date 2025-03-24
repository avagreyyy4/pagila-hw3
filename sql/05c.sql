/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

select title from film
join film_actor using (film_id)
where actor_id in (
    select actor_id from actor
    join film_actor using (actor_id)
    join film using (film_id)
    where title IN ('AMERICAN CIRCUS', 'AGENT TRUMAN', 'ACADEMY DINOSAUR'))
group by film_id, title
having count(actor_id) >=3;
