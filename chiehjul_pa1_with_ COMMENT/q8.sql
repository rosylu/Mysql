# Construct a SQL script with two statements, at the first statement: 
# Deactivate the account of customer MARIA MILLER by setting the active column to zero. 

UPDATE sakila.customer
set active = 0
where first_name = 'MARIA' and last_name = 'MILLER';

# Show the updated instance with email and active column in the second statement.

SELECT email, active 
FROM sakila.customer cus
where first_name = 'MARIA' and last_name = 'MILLER';