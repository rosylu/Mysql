# Find the actor’s first name and last name if first name is KENNETH. 

SELECT  act.first_name, act.last_name
FROM sakila.actor act
where act.first_name = 'KENNETH';