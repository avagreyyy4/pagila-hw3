/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

select distinct first_name || ' ' || last_name as "Actor Name" from actor 
join film_actor on actor.actor_id = film_actor.actor_id
where film_actor.film_id in (
    select film_id 
    from film_actor fa 
    join actor a on fa.actor_id=a.actor_id
    where a.first_name = 'RUSSELL'
   and a.last_name = 'BACALL' 
)

and not (actor.first_name = 'RUSSELL' and actor.last_name = 'BACALL')
order by "Actor Name";
