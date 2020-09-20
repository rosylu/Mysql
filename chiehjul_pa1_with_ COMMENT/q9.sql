# Find out the film with the rental rate lower than 1, return their film id and title. 

SELECT film.film_id, film.title
FROM sakila.film film
where film.rental_rate < 1;