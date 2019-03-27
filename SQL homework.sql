-- 1a
SELECT first_name, last_name 
FROM actor;
-- 1b
SELECT concat(first_name,' ', last_name) AS Actor_Name 
FROM actor;
-- 2a
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";
-- 2b
SELECT * FROM actor
WHERE last_name LIKE "%GEN%";
-- 2c
SELECT * FROM actor
WHERE last_name LIKE "%LI%"
ORDER BY last_name, first_name;
-- 2d
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- 3a
ALTER TABLE actor
ADD description BLOB;
-- 3b
ALTER TABLE actor
DROP COLUMN description;
-- 4a
SELECT count(last_name), last_name FROM actor
GROUP BY last_name;
-- 4b
SELECT count(last_name), last_name FROM actor
GROUP BY last_name
HAVING count(last_name) > 1;
-- 4c
UPDATE actor
SET first_name='HARPO' 
WHERE first_name='GROUCHO' AND last_name='WILLIAMS';
-- 4d
UPDATE actor	
SET first_name='GROUHCO'
WHERE first_name='HARPO' and last_name='WILLIAMS';	
-- 5a
DESCRIBE sakila.address;
-- 6a
SELECT first_name, last_name, address 
FROM staff
LEFT JOIN address ON
staff.address_id = address.address_id;
-- 6b
SELECT s.first_name AS firstName, s.last_name AS lastName, sum(p.amount) AS total_amount
FROM payment AS p
JOIN staff AS s
ON p.staff_id=s.staff_id
WHERE payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY p.staff_id;
-- 6c
SELECT f.title AS filmTitle, COUNT(fa.actor_id) AS numberofActors
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY fa.film_id;
-- 6d
select count(i.inventory_id) as numberofCopies 
from inventory as i 
inner join film as f
on f.film_id=i.film_id
where title='Hunchback Impossible';
-- 6e
select c.first_name as firstName, c.last_name as lastName, sum(p.amount) as totalPaid
from customer as c
join payment as p
on c.customer_id=p.customer_id
group by p.customer_id
order by last_name;
-- 7a
SELECT f.title 
FROM film AS f
JOIN language AS l
ON f.language_id=l.language_id
WHERE l.name ='English' IN (
	SELECT f.title LIKE 'K%' OR f.title LIKE 'Q%');
-- 7b
SELECT a.first_name, a.last_name
FROM actor AS a
JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
JOIN film AS f
ON f.film_id = fa.film_id 
WHERE ( 
    f.title='Alone Trip'
	);
-- 7c
SELECT c.first_name, c.last_name, c.email 
FROM customer AS c
JOIN address AS a
ON c.address_id = a.address_id
JOIN city AS ci
ON a.city_id = ci.city_id
JOIN country AS co
ON ci.country_id = co.country_id
WHERE co.country = 'Canada';
-- 7d
SELECT f.title 
FROM film AS f
JOIN film_category AS fc
ON fc.film_id = f.film_id
JOIN category AS ca
ON ca.category_id = fc.category_id
WHERE ca.name = 'Family';
-- 7e
SELECT f.title, count(r.rental_date)
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.title 
ORDER BY count(r.rental_date) desc; 
-- 7f
SELECT i.store_id, sum(p.amount)
FROM inventory AS i
JOIN rental AS r
ON r.inventory_id = i.inventory_id
JOIN payment AS p
ON p.rental_id = r.rental_id
GROUP BY i.store_id;
-- 7g
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS ad
ON s.address_id=ad.address_id
JOIN city AS ci
ON ad.city_id=ci.city_id
JOIN country AS co
ON ci.country_id=co.country_id
GROUP BY s.store_id
ORDER BY s.store_id;
-- 7h
SELECT ca.name AS genre, sum(p.amount) AS gross_revenue
FROM category AS ca
JOIN film_category AS fc
ON ca.category_id=fc.category_id
JOIN inventory AS i
ON fc.film_id=i.film_id
JOIN rental AS r
ON i.inventory_id=r.inventory_id
JOIN payment AS p
ON r.rental_id=p.rental_id
GROUP BY ca.name 
ORDER BY sum(p.amount) desc
LIMIT 5;
-- 8a
CREATE VIEW top_five_genres_by_gross_revenue AS
SELECT ca.name AS genre, sum(p.amount) AS gross_revenue
FROM category AS ca
JOIN film_category AS fc
ON ca.category_id=fc.category_id
JOIN inventory AS i
ON fc.film_id=i.film_id
JOIN rental AS r
ON i.inventory_id=r.inventory_id
JOIN payment AS p
ON r.rental_id=p.rental_id
GROUP BY ca.name 
ORDER BY sum(p.amount) desc
LIMIT 5;
-- 8b
SELECT * FROM top_five_genres_by_gross_revenue;
-- 8c
DROP VIEW top_five_genres_by_gross_revenue;