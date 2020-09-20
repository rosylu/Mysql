# insert data
INSERT INTO sakila.actor (first_name, last_name, last_update)
VALUES ('KENNETH', 'OLIVIER', CURRENT_TIMESTAMP);

# Print table
SELECT  act.first_name, act.last_name
FROM sakila.actor act
where act.first_name = 'KENNETH';