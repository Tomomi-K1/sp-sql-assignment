-- Comments in SQL Start with dash-dash --
1. playstore=# SELECT * FROM analytics WHERE id = 1880;
2. playstore=# SELECT id, app_name FROM analytics WHERE last_updated = '2018-08-01';
3. playstore=# SELECT category, COUNT(*) FROM analytics GROUP BY category;
4. playstore=# SELECT app_name, reviews FROM analytics ORDER BY reviews DESC LIMIT 5;
5. playstore=# SELECT app_name, reviews, rating FROM analytics WHERE rating > 4.8 ORDER BY reviews DESC LIMIT 1;
6. playstore=# SELECT category, AVG(rating) FROM analytics GROUP BY category ORDER BY AVG(rating) DESC;
7. playstore=# SELECT app_name, price, rating FROM analytics WHERE rating < 3 ORDER BY price DESC LIMIT 1;
8. SELECT app_name, min_installs, rating FROM analytics WHERE min_installs <= 50 AND rating IS NOT NULL  ORDER
BY rating DESC;
9.playstore=# SELECT app_name, rating FROM analytics WHERE rating < 3 AND reviews >=10000;
10. playstore=# SELECT app_name, reviews, price FROM analytics WHERE price BETWEEN 0.10 AND 1.00 ORDER BY reviews DESC LIMIT
 10;
11.playstore=# SELECT app_name, last_updated FROM analytics WHERE last_updated = (SELECT MIN(last_updated) FROM analytics);  
12.playstore=# SELECT app_name, price FROM analytics WHERE price = (SELECT MAX(price) FROM analytics);
13.playstore=# SELECT SUM(reviews) FROM analytics WHERE reviews IS NOT NULL;
14.playstore=# SELECT category, COUNT(app_name) FROM analytics  GROUP BY category having COUNT(app_name) > 300;
15.Playstore=# SELECT app_name, reviews, min_installs, min_installs/reviews AS proportion FROM analytics WHERE min_installs >= 100000 ORDER BY proportion DESC LIMIT 1; 

-- FURTHER STUDY 

-- FS1. Find the name and rating of the top rated apps in each category, 
-- among apps that have been installed at least 50,000 times.
SELECT app_name, rating, category FROM analytics
  WHERE (rating, category) in (
    SELECT MAX(rating), category FROM analytics
      WHERE min_installs >= 50000
      GROUP BY category
    )
  ORDER BY category;

-- FS2. Find all the apps that have a name similar to "facebook".
SELECT * FROM analytics 
  WHERE app_name ILIKE '%facebook%';

-- FS3. Find all the apps that have more than 1 genre.
SELECT * FROM analytics 
  WHERE  array_length(genres, 1) = 2;

-- FS4. Find all the apps that have education as one of their genres.
SELECT * FROM analytics 
  WHERE genres @> '{"Education"}';