# Given a pair of different films as (f1, f2), 
# find out all pairs of films such that every pair has equal length and rating.

SELECT film1.title as film_1, film2.title as film_2, film1.length, film1.rating
FROM sakila.film film1  join sakila.film film2 on film1.title != film2.title  and film1.film_id > film2.film_id and film1.length = film2.length and film1.rating = film2.rating
order by film1.title, film2.title;