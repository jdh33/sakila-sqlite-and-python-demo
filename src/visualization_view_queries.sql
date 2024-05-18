-- Create views to simplify queries for data visualization

DROP VIEW IF EXISTS inventory_store_1_view;
DROP VIEW IF EXISTS rating_inventory_store_1_view;
DROP VIEW IF EXISTS rating_inventory_rental_store_1_view;
DROP VIEW IF EXISTS category_inventory_store_1_view;
DROP VIEW IF EXISTS category_inventory_rental_store_1_view;
DROP VIEW IF EXISTS top_revenue_film_view;
DROP VIEW IF EXISTS actor_film_view;

-- Store 1 inventory
CREATE VIEW inventory_store_1_view AS
SELECT
    * FROM inventory AS i
WHERE
    i.store_id = 1;

-- Frequency of film ratings in store 1
CREATE VIEW rating_inventory_store_1_view AS
SELECT
    f.rating,
    COUNT(*) AS rating_count
FROM
    film AS f
    JOIN inventory_store_1_view AS i
        ON f.film_id = i.film_id
GROUP BY
    rating
ORDER BY
    rating_count DESC;

-- How often films with the different ratings are rented
-- from store 1
CREATE VIEW rating_inventory_rental_store_1_view AS
SELECT
    f.rating,
    COUNT(*) AS rating_count
FROM
    film AS f
    JOIN inventory_store_1_view AS i
        ON f.film_id = i.film_id
    JOIN rental AS r
        ON i.inventory_id = r.inventory_id
GROUP BY
    rating
ORDER BY
    rating_count DESC;

-- Frequency of film categories in store 1
CREATE VIEW category_inventory_store_1_view AS
SELECT 
    c.name AS category,
    COUNT(*) AS category_count
FROM
    film_category AS fc
    JOIN category AS c
        ON fc.category_id = c.category_id
    JOIN inventory_store_1_view AS i
        ON fc.film_id = i.film_id
GROUP BY
    category
ORDER BY
    category_count DESC;

-- How often films with the different categories are rented
-- from store 1
CREATE VIEW category_inventory_rental_store_1_view AS
SELECT
    c.name AS category,
    COUNT(*) AS category_count
FROM
    film_category AS fc
    JOIN category AS c
        ON fc.category_id = c.category_id
    JOIN inventory_store_1_view AS i
        ON fc.film_id = i.film_id
    JOIN rental AS r
        ON i.inventory_id = r.inventory_id
GROUP BY
    category
ORDER BY
    category_count DESC;

-- Top 10 revenue generating films
CREATE VIEW top_revenue_film_view AS
SELECT
    f.film_id,
    f.title,
    SUM(p.amount) AS revenue,
    -- AVG ignores null values
    AVG(p.amount) as average_payment,
    -- Use the specific column as the argument so null values are not counted
    COUNT(p.amount) as number_of_rentals
FROM
    film as f
    JOIN inventory AS i
        ON f.film_id = i.film_id
    JOIN rental as r
        ON i.inventory_id = r.inventory_id
    JOIN payment as p
        ON r.rental_id = p.rental_id
GROUP BY
    f.film_id
ORDER BY
    revenue DESC
-- We want the top 10 revenue generating films
LIMIT 10;

-- Actors in films
CREATE VIEW actor_film_view AS
SELECT
    a.first_name||' '||a.last_name AS actors,
    fa.film_id
FROM
    film_actor AS fa
    JOIN actor AS a
        ON fa.actor_id = a.actor_id;
