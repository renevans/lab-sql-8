USE sakila;

-- 1.  Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city c
ON a.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id;

-- 2.  Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(amount)
FROM store s
JOIN customer c
ON s.store_id = c.store_id
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 3.  Which film categories are longest?
SELECT c.category_id, name, length
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.category_id
ORDER BY length desc
LIMIT 5;

-- 4.  Display the most frequently rented movies in descending order.
SELECT f.film_id, title, count(rental_id) 
FROM rental r
JOIN inventory i
ON r.inventory_id =  i.inventory_id
JOIN film f
ON i.film_id =  f.film_id
GROUP BY f.film_id
ORDER BY count(rental_id) DESC;

-- 5.  List the top five genres in gross revenue in descending order.
SELECT c.name as 'Genres', sum(amount) as 'Gross revenue'
FROM payment p
JOIN rental r
ON p.rental_id = r.rental_id
JOIN inventory i
ON r.inventory_id = i. inventory_id
JOIN film_category fc
ON i.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY sum(amount) DESC
LIMIT 5;

-- 6.  Is "Academy Dinosaur" available for rent from Store 1?
SELECT film_id from film
WHERE title like '%Academy Dinosaur%';

SELECT inventory_id from inventory
WHERE film_id = 1 and store_id = 1;

SELECT inventory_id, return_date
from rental
WHERE return_date is not null AND inventory_id <= 4;

-- Yes, it is available.

-- 7.  Get all pairs of actors that worked together.
SELECT fa1.film_id, fa1.actor_id, fa2.actor_id
FROM film_actor fa1
JOIN film_actor fa2
ON fa1.actor_id <> fa2.actor_id AND fa1.film_id = fa2.film_id;

-- 8.  Get all pairs of customers that have rented the same film more than 3 times.
SELECT i.film_id, r1.inventory_id, r1.customer_id, r2.customer_id 
FROM rental r1
JOIN rental r2
ON r1.customer_id <> r2.customer_id AND r1.inventory_id = r2.inventory_id
JOIN inventory i
ON r1.inventory_id = i.inventory_id
GROUP BY r1.inventory_id
HAVING count(i.film_id)>3
ORDER BY i.film_id asc;

-- 9.  For each film, list actor that has acted in more films.
#Assumption: Provide the following: for each film, a list of actors that acted in multiple films (i.e. more than one).

SELECT title as film, concat(first_name,' ', last_name) as actor
FROM film_actor fa
JOIN film f
ON fa.film_id =  f.film_id
JOIN actor a
ON fa.actor_id = a.actor_id
GROUP BY f.film_id 
HAVING count(fa.film_id) > 1
ORDER BY film asc;









