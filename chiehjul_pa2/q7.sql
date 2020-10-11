SELECT actor_name, count(*) as ncat
FROM (
	SELECT  CONCAT_WS(" ", act.first_name, act.last_name) AS actor_name, count(*)
	FROM sakila.actor act, sakila.film_actor f_act, sakila.film_category cat
	where act.actor_id = f_act.actor_id AND f_act.film_id = cat.film_id
	group by actor_name, cat.category_id
	order by actor_name
    ) cat_list
group by actor_name;