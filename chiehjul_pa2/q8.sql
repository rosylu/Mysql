SELECT rental_id, payment_id
FROM sakila.payment pay1
WHERE amount <= ALL (
	SELECT amount
    FROM sakila.payment pay2
)
ORDER BY rental_id