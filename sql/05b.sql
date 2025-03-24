/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */


select title from film 
join film_actor using (film_id) 
where actor_id in (
    select actor_id from actor 
    join film_actor using (actor_id)
    join film using (film_id)
    where title = 'AMERICAN CIRCUS')
group by film_id, title
having count(distinct actor_id) >=2
order by title;
